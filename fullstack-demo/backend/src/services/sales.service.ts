import { pool } from '../db.js';
import { AppError } from '../errors.js';

type SaleItemInput = {
  produtoId: number;
  quantidade: number;
};

type CreateSaleInput = {
  clienteId: number;
  itens: SaleItemInput[];
  formaPagamento: string;
};

type CreatedSale = {
  id: string;
  cliente_id: string;
  subtotal: string;
  desconto: string;
  total: string;
  status: string;
  finalizada_em: string;
};

export async function createSale({
  clienteId,
  itens,
  formaPagamento
}: CreateSaleInput): Promise<CreatedSale> {
  if (!Number.isInteger(clienteId) || !Array.isArray(itens) || itens.length === 0) {
    throw new AppError('clienteId e itens são obrigatórios', 400);
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
      throw new AppError('Cliente não encontrado', 404);
    }

    const vendaResult = await client.query<{ id: string }>(
      `INSERT INTO lab.vendas (cliente_id, status, subtotal, desconto, total)
       VALUES ($1, 'ABERTA', 0, 0, 0)
       RETURNING id`,
      [clienteId]
    );

    const vendaId = vendaResult.rows[0]?.id;

    if (!vendaId) {
      throw new AppError('Falha ao criar venda', 500);
    }

    for (const item of itens) {
      const produtoId = Number(item.produtoId);
      const quantidade = Number(item.quantidade);

      if (!Number.isInteger(produtoId) || !Number.isFinite(quantidade) || quantidade <= 0) {
        throw new AppError('Item de venda inválido', 400);
      }

      const produtoResult = await client.query<{
        id: string;
        nome: string;
        preco: string;
        estoque_atual: string;
      }>(
        `SELECT id, nome, preco, estoque_atual
           FROM lab.produtos
          WHERE id = $1
            AND ativo = TRUE
          FOR UPDATE`,
        [produtoId]
      );

      const produto = produtoResult.rows[0];

      if (!produto) {
        throw new AppError(`Produto ${produtoId} não encontrado`, 404);
      }

      if (Number(produto.estoque_atual) < quantidade) {
        throw new AppError(`Estoque insuficiente para ${produto.nome}`, 409);
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

    const totalResult = await client.query<{ total: string }>(
      `SELECT total
         FROM lab.vendas
        WHERE id = $1`,
      [vendaId]
    );

    const total = Number(totalResult.rows[0]?.total ?? 0);

    await client.query(
      `INSERT INTO lab.pagamentos (venda_id, forma, valor, status)
       VALUES ($1, $2, $3, 'CONFIRMADO')`,
      [vendaId, formaPagamento, total]
    );

    const finalResult = await client.query<CreatedSale>(
      `UPDATE lab.vendas
          SET status = 'FINALIZADA',
              finalizada_em = NOW()
        WHERE id = $1
        RETURNING id, cliente_id, subtotal, desconto, total, status, finalizada_em`,
      [vendaId]
    );

    await client.query('COMMIT');

    const venda = finalResult.rows[0];

    if (!venda) {
      throw new AppError('Falha ao finalizar venda', 500);
    }

    return venda;
  } catch (error) {
    await client.query('ROLLBACK');
    throw error;
  } finally {
    client.release();
  }
}
