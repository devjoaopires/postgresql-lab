-- Antes de criar um índice, confirme o padrão real de consulta.

-- Busca case-insensitive por nome.
EXPLAIN (ANALYZE, BUFFERS)
SELECT id, sku, nome, preco
FROM lab.produtos
WHERE LOWER(nome) = LOWER('Notebook Pro');

-- O índice funcional correspondente está em schema/04_indexes.sql:
-- CREATE INDEX idx_produtos_nome_lower ON lab.produtos (LOWER(nome));

-- Consulta típica de histórico por cliente.
EXPLAIN (ANALYZE, BUFFERS)
SELECT id, status, total, criada_em
FROM lab.vendas
WHERE cliente_id = 1
ORDER BY criada_em DESC
LIMIT 20;

-- Compare o plano antes/depois de:
-- CREATE INDEX idx_vendas_cliente_data
--     ON lab.vendas (cliente_id, criada_em DESC);
