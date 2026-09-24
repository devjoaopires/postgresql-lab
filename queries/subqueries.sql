-- Produtos com preço acima da média.
SELECT
    id,
    sku,
    nome,
    preco
FROM lab.produtos
WHERE preco > (
    SELECT AVG(preco)
    FROM lab.produtos
    WHERE ativo = TRUE
)
ORDER BY preco DESC;

-- Clientes que já possuem pelo menos uma venda finalizada.
SELECT
    c.id,
    c.nome,
    c.email
FROM lab.clientes AS c
WHERE EXISTS (
    SELECT 1
    FROM lab.vendas AS v
    WHERE v.cliente_id = c.id
      AND v.status = 'FINALIZADA'
)
ORDER BY c.nome;
