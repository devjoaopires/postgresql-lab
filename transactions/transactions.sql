-- Exemplo de venda atômica.
-- Se qualquer etapa falhar, ROLLBACK impede um estado parcial.

BEGIN;

-- Bloqueia o produto enquanto a venda altera seu estoque.
SELECT id, estoque_atual
FROM lab.produtos
WHERE id = 1
FOR UPDATE;

INSERT INTO lab.vendas (
    cliente_id,
    status,
    subtotal,
    desconto,
    total
)
VALUES (1, 'ABERTA', 0, 0, 0);

-- Em código de aplicação, o ID retornado seria reutilizado
-- nas próximas instruções da mesma transação.

-- Exemplo conceitual de validação de estoque:
UPDATE lab.produtos
SET estoque_atual = estoque_atual - 1
WHERE id = 1
  AND estoque_atual >= 1;

-- A aplicação deve verificar se exatamente uma linha foi alterada.
-- Caso contrário: ROLLBACK.

COMMIT;

-- SAVEPOINT permite desfazer somente parte da transação.
BEGIN;

SAVEPOINT antes_do_ajuste;

UPDATE lab.produtos
SET preco = preco * 1.05
WHERE categoria_id = 1;

-- Para cancelar apenas o ajuste:
-- ROLLBACK TO SAVEPOINT antes_do_ajuste;

COMMIT;
