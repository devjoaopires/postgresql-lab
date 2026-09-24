import { pool } from '../db.js';

export async function createSale({ clienteId, itens, formaPagamento }) {
  if (!Number.isInteger(clienteId) || !Array.isArray(itens) || itens.length === 0) {
    const error = new Error('clienteId e itens são obrigatórios');
    error.status = 400;
    throw error;
  }

  const client = await pool.connect();

  try {
    await client.query('BEGIN');

    const clienteResult = await client.query(
      `SELECT id
         FROM lab.clientes
        WHERE id = $1
          AND ativo = TRUE`,
      [clienteId]
    );

    if (clienteResult.rowCount === 0) {
      const error = new Error('Cliente não encontrado');
      error.status = 404;
      throw error;
    }

    const vendaResult = await client.query(
      `INSERT INTO lab.vendas (cliente_id, status, subtotal, desconto, total)
       VALUES ($1, 'ABERTA', 0, 0, 0)
       RETURNING id`,
      [clienteId]
    );

    const vendaId = vendaResult.rows[0].id;

    for (const item of itens) {
      const produtoId = Number(item.produtoId);
      const quantidade = Number(item.quantidade);

      if (!Number.isInteger(produtoId) || !Number.isFinite(quantidade) || quantidade <= 0) {
        const error = new Error('Item de venda inválido');
        error.status = 400;
        throw error;
      }

      const produtoResult = await client.query(
        `SELECT id, nome, preco, estoque_atual
           FROM lab.produtos
          WHERE id = $1
            AND ativo = TRUE
          FOR UPDATE`,
        [produtoId]
      );

      if (produtoResult.rowCount === 0) {
        const error = new Error(`Produto ${produtoId} não encontrado`);
        error.status = 404;
        throw error;
      }

      const produto = produtoResult.rows[0];

      if (Number(produto.estoque_atual) < quantidade) {
        const error = new Error(`Estoque insuficiente para ${produto.nome}`);
        error.status = 409;
        throw error;
      }

      const preco = Number(produto.preco);
      const totalItem = Number((preco * quantidade).toFixed(2));

      await client.query(
        `INSERT INTO lab.itens_venda (
           venda_id, produto_id, quantidade, preco_unitario, desconto, total_item
         )
         VALUES ($1, $2, $3, $4, 0, $5)`,
        [vendaId, produtoId, quantidade, preco, totalItem]
      );

      await client.query(
        `UPDATE lab.produtos
            SET estoque_atual = estoque_atual - $1
          WHERE id = $2`,
        [quantidade, produtoId]
      );

      await client.query(
        `INSERT INTO lab.movimentacoes_estoque (
           produto_id, tipo, quantidade, referencia
         )
         VALUES ($1, 'SAIDA', $2, $3)`,
        [produtoId, quantidade, `VENDA-${vendaId}`]
      );
    }

    const totalResult = await client.query(
      `SELECT subtotal, desconto, total
         FROM lab.vendas
        WHERE id = $1`,
      [vendaId]
    );

    const total = Number(totalResult.rows[0].total);

    await client.query(
      `INSERT INTO lab.pagamentos (venda_id, forma, valor, status)
       VALUES ($1, $2, $3, 'CONFIRMADO')`,
      [vendaId, formaPagamento, total]
    );

    const finalResult = await client.query(
      `UPDATE lab.vendas
          SET status = 'FINALIZADA',
              finalizada_em = NOW()
        WHERE id = $1
        RETURNING id, cliente_id, subtotal, desconto, total, status, finalizada_em`,
      [vendaId]
    );

    await client.query('COMMIT');
    return finalResult.rows[0];
  } catch (error) {
    await client.query('ROLLBACK');
    throw error;
  } finally {
    client.release();
  }
}
