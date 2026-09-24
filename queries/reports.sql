-- Relatório de vendas com cliente e total pago.
SELECT
    v.id AS venda_id,
    c.nome AS cliente,
    v.criada_em,
    v.status,
    v.total,
    COALESCE(SUM(p.valor) FILTER (WHERE p.status = 'CONFIRMADO'), 0) AS total_pago,
    v.total - COALESCE(
        SUM(p.valor) FILTER (WHERE p.status = 'CONFIRMADO'),
        0
    ) AS saldo
FROM lab.vendas AS v
LEFT JOIN lab.clientes AS c
    ON c.id = v.cliente_id
LEFT JOIN lab.pagamentos AS p
    ON p.venda_id = v.id
GROUP BY v.id, c.nome
ORDER BY v.criada_em DESC;

-- Curva simples de produtos por quantidade vendida.
SELECT
    p.sku,
    p.nome,
    COALESCE(SUM(iv.quantidade), 0) AS quantidade_vendida,
    COALESCE(SUM(iv.total_item), 0) AS faturamento
FROM lab.produtos AS p
LEFT JOIN lab.itens_venda AS iv
    ON iv.produto_id = p.id
LEFT JOIN lab.vendas AS v
    ON v.id = iv.venda_id
   AND v.status = 'FINALIZADA'
GROUP BY p.id, p.sku, p.nome
ORDER BY faturamento DESC, p.nome;
