-- INNER JOIN: itens vendidos com produto e venda.
SELECT
    v.id AS venda_id,
    p.sku,
    p.nome AS produto,
    iv.quantidade,
    iv.preco_unitario,
    iv.total_item
FROM lab.itens_venda AS iv
INNER JOIN lab.vendas AS v
    ON v.id = iv.venda_id
INNER JOIN lab.produtos AS p
    ON p.id = iv.produto_id
ORDER BY v.id, p.nome;

-- LEFT JOIN: clientes permanecem no resultado mesmo sem vendas.
SELECT
    c.id,
    c.nome,
    COUNT(v.id) AS quantidade_vendas,
    COALESCE(SUM(v.total) FILTER (WHERE v.status = 'FINALIZADA'), 0) AS total_comprado
FROM lab.clientes AS c
LEFT JOIN lab.vendas AS v
    ON v.cliente_id = c.id
GROUP BY c.id, c.nome
ORDER BY total_comprado DESC, c.nome;
