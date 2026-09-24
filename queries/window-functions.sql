-- Ranking de produtos por faturamento dentro de cada categoria.
WITH vendas_por_produto AS (
    SELECT
        p.categoria_id,
        p.id AS produto_id,
        p.nome AS produto,
        SUM(iv.total_item) AS faturamento
    FROM lab.itens_venda AS iv
    JOIN lab.vendas AS v
        ON v.id = iv.venda_id
       AND v.status = 'FINALIZADA'
    JOIN lab.produtos AS p
        ON p.id = iv.produto_id
    GROUP BY p.categoria_id, p.id, p.nome
)
SELECT
    categoria_id,
    produto_id,
    produto,
    faturamento,
    DENSE_RANK() OVER (
        PARTITION BY categoria_id
        ORDER BY faturamento DESC
    ) AS posicao_categoria
FROM vendas_por_produto
ORDER BY categoria_id, posicao_categoria;

-- Acumulado de vendas por data.
SELECT
    criada_em::date AS data,
    SUM(total) AS total_dia,
    SUM(SUM(total)) OVER (
        ORDER BY criada_em::date
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS total_acumulado
FROM lab.vendas
WHERE status = 'FINALIZADA'
GROUP BY criada_em::date
ORDER BY data;
