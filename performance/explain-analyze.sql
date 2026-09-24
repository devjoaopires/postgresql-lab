-- EXPLAIN mostra o plano estimado.
EXPLAIN
SELECT
    c.id,
    c.nome,
    COUNT(v.id) AS vendas
FROM lab.clientes AS c
LEFT JOIN lab.vendas AS v
    ON v.cliente_id = c.id
GROUP BY c.id;

-- EXPLAIN ANALYZE executa a consulta e mede o plano real.
-- BUFFERS ajuda a enxergar leituras em cache/disco.
EXPLAIN (ANALYZE, BUFFERS)
SELECT
    p.id,
    p.nome,
    SUM(iv.quantidade) AS quantidade_vendida
FROM lab.produtos AS p
JOIN lab.itens_venda AS iv
    ON iv.produto_id = p.id
JOIN lab.vendas AS v
    ON v.id = iv.venda_id
WHERE v.status = 'FINALIZADA'
GROUP BY p.id, p.nome
ORDER BY quantidade_vendida DESC
LIMIT 10;

-- Em uma análise real, observe principalmente:
-- 1. Seq Scan em tabelas grandes quando filtros são seletivos;
-- 2. diferença entre rows estimadas e rows reais;
-- 3. loops excessivos;
-- 4. sort/hash usando muito espaço;
-- 5. tempo total e buffers lidos.
