-- Dataset 100% fictício para executar as consultas do laboratório.
-- Execute depois dos arquivos de schema.

TRUNCATE TABLE
    lab.pagamentos,
    lab.movimentacoes_estoque,
    lab.itens_venda,
    lab.vendas,
    lab.produtos,
    lab.categorias,
    lab.clientes
RESTART IDENTITY CASCADE;

INSERT INTO lab.clientes (nome, email, documento)
VALUES
    ('Ana Souza', 'ana.souza@example.com', 'DOC-0001'),
    ('Carlos Lima', 'carlos.lima@example.com', 'DOC-0002'),
    ('Marina Alves', 'marina.alves@example.com', 'DOC-0003'),
    ('Rafael Costa', 'rafael.costa@example.com', 'DOC-0004');

INSERT INTO lab.categorias (nome, descricao)
VALUES
    ('Informática', 'Produtos de informática'),
    ('Escritório', 'Itens para escritório'),
    ('Acessórios', 'Acessórios diversos');

INSERT INTO lab.produtos (
    categoria_id,
    sku,
    nome,
    preco,
    estoque_atual,
    estoque_minimo
)
VALUES
    (1, 'INF-001', 'Notebook Pro', 4299.90, 8, 3),
    (1, 'INF-002', 'Monitor 27', 1399.90, 14, 5),
    (3, 'ACE-001', 'Mouse Sem Fio', 149.90, 30, 10),
    (3, 'ACE-002', 'Teclado Mecânico', 429.90, 18, 6),
    (2, 'ESC-001', 'Cadeira Escritório', 899.90, 4, 5);

INSERT INTO lab.vendas (
    cliente_id,
    status,
    subtotal,
    desconto,
    total,
    criada_em,
    finalizada_em
)
VALUES
    (1, 'FINALIZADA', 4449.80, 49.80, 4400.00, NOW() - INTERVAL '15 days', NOW() - INTERVAL '15 days'),
    (2, 'FINALIZADA', 1829.80, 29.80, 1800.00, NOW() - INTERVAL '7 days', NOW() - INTERVAL '7 days'),
    (1, 'FINALIZADA', 579.80, 0, 579.80, NOW() - INTERVAL '2 days', NOW() - INTERVAL '2 days'),
    (3, 'ABERTA', 899.90, 0, 899.90, NOW(), NULL);

INSERT INTO lab.itens_venda (
    venda_id,
    produto_id,
    quantidade,
    preco_unitario,
    desconto,
    total_item
)
VALUES
    (1, 1, 1, 4299.90, 0, 4299.90),
    (1, 3, 1, 149.90, 0, 149.90),
    (2, 2, 1, 1399.90, 0, 1399.90),
    (2, 4, 1, 429.90, 0, 429.90),
    (3, 3, 1, 149.90, 0, 149.90),
    (3, 4, 1, 429.90, 0, 429.90),
    (4, 5, 1, 899.90, 0, 899.90);

INSERT INTO lab.pagamentos (venda_id, forma, valor, status, pago_em)
VALUES
    (1, 'PIX', 4400.00, 'CONFIRMADO', NOW() - INTERVAL '15 days'),
    (2, 'CREDITO', 1800.00, 'CONFIRMADO', NOW() - INTERVAL '7 days'),
    (3, 'DEBITO', 579.80, 'CONFIRMADO', NOW() - INTERVAL '2 days');

INSERT INTO lab.movimentacoes_estoque (
    produto_id,
    tipo,
    quantidade,
    referencia
)
VALUES
    (1, 'SAIDA', 1, 'VENDA-1'),
    (3, 'SAIDA', 1, 'VENDA-1'),
    (2, 'SAIDA', 1, 'VENDA-2'),
    (4, 'SAIDA', 1, 'VENDA-2'),
    (3, 'SAIDA', 1, 'VENDA-3'),
    (4, 'SAIDA', 1, 'VENDA-3');

-- Conferência rápida.
SELECT
    v.id,
    c.nome AS cliente,
    v.status,
    v.total,
    lab.total_pago_venda(v.id) AS total_pago
FROM lab.vendas AS v
JOIN lab.clientes AS c
    ON c.id = v.cliente_id
ORDER BY v.id;
