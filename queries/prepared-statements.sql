-- Prepared Statements demonstram consultas parametrizadas
-- sem interpolar valores diretamente no SQL.

PREPARE buscar_vendas_cliente (BIGINT, TIMESTAMPTZ, TIMESTAMPTZ) AS
SELECT
    id,
    status,
    subtotal,
    desconto,
    total,
    criada_em
FROM lab.vendas
WHERE cliente_id = $1
  AND criada_em >= $2
  AND criada_em < $3
ORDER BY criada_em DESC;

EXECUTE buscar_vendas_cliente(
    1,
    NOW() - INTERVAL '30 days',
    NOW() + INTERVAL '1 day'
);

DEALLOCATE buscar_vendas_cliente;

PREPARE buscar_produto_sku (VARCHAR) AS
SELECT
    id,
    sku,
    nome,
    preco,
    estoque_atual
FROM lab.produtos
WHERE sku = $1;

EXECUTE buscar_produto_sku('INF-001');

DEALLOCATE buscar_produto_sku;
