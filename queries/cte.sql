-- CTE para consolidar faturamento mensal.
WITH vendas_finalizadas AS (
    SELECT
        DATE_TRUNC('month', criada_em) AS mes,
        total
    FROM lab.vendas
    WHERE status = 'FINALIZADA'
),
faturamento AS (
    SELECT
        mes,
        COUNT(*) AS quantidade_vendas,
        SUM(total) AS valor_total,
        AVG(total) AS ticket_medio
    FROM vendas_finalizadas
    GROUP BY mes
)
SELECT
    mes,
    quantidade_vendas,
    ROUND(valor_total, 2) AS valor_total,
    ROUND(ticket_medio, 2) AS ticket_medio
FROM faturamento
ORDER BY mes DESC;

-- CTE para produtos abaixo do estoque mínimo.
WITH estoque_critico AS (
    SELECT
        id,
        sku,
        nome,
        estoque_atual,
        estoque_minimo,
        estoque_minimo - estoque_atual AS necessidade
    FROM lab.produtos
    WHERE ativo = TRUE
      AND estoque_atual < estoque_minimo
)
SELECT *
FROM estoque_critico
ORDER BY necessidade DESC;
