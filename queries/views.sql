-- View para consolidar vendas finalizadas.
CREATE OR REPLACE VIEW lab.vw_vendas_resumo AS
SELECT
    v.id AS venda_id,
    v.criada_em,
    c.id AS cliente_id,
    c.nome AS cliente,
    v.subtotal,
    v.desconto,
    v.total,
    lab.total_pago_venda(v.id) AS total_pago
FROM lab.vendas AS v
LEFT JOIN lab.clientes AS c
    ON c.id = v.cliente_id
WHERE v.status = 'FINALIZADA';

SELECT *
FROM lab.vw_vendas_resumo
ORDER BY criada_em DESC;

-- Materialized View para um relatório que pode ser recalculado sob demanda.
CREATE MATERIALIZED VIEW IF NOT EXISTS lab.mv_faturamento_produto AS
SELECT
    p.id AS produto_id,
    p.sku,
    p.nome,
    SUM(iv.quantidade) AS quantidade_vendida,
    SUM(iv.total_item) AS faturamento
FROM lab.produtos AS p
JOIN lab.itens_venda AS iv
    ON iv.produto_id = p.id
JOIN lab.vendas AS v
    ON v.id = iv.venda_id
WHERE v.status = 'FINALIZADA'
GROUP BY p.id, p.sku, p.nome
WITH NO DATA;

-- Para popular/atualizar:
-- REFRESH MATERIALIZED VIEW lab.mv_faturamento_produto;
