-- PostgreSQL Lab
-- Etapa 4: índices voltados a consultas comuns do sistema.

CREATE INDEX IF NOT EXISTS idx_produtos_categoria
    ON lab.produtos (categoria_id);

CREATE INDEX IF NOT EXISTS idx_produtos_nome_lower
    ON lab.produtos (LOWER(nome));

CREATE INDEX IF NOT EXISTS idx_vendas_cliente_data
    ON lab.vendas (cliente_id, criada_em DESC);

CREATE INDEX IF NOT EXISTS idx_itens_venda_venda
    ON lab.itens_venda (venda_id);

CREATE INDEX IF NOT EXISTS idx_itens_venda_produto
    ON lab.itens_venda (produto_id);

CREATE INDEX IF NOT EXISTS idx_pagamentos_venda
    ON lab.pagamentos (venda_id);

CREATE INDEX IF NOT EXISTS idx_movimentacoes_produto_data
    ON lab.movimentacoes_estoque (produto_id, criado_em DESC);

-- Partial index: mantém o índice menor quando a consulta procura
-- somente vendas ainda abertas.
CREATE INDEX IF NOT EXISTS idx_vendas_abertas
    ON lab.vendas (criada_em DESC)
    WHERE status = 'ABERTA';

-- Partial index para reposição de estoque.
CREATE INDEX IF NOT EXISTS idx_produtos_estoque_baixo
    ON lab.produtos (estoque_atual, estoque_minimo)
    WHERE ativo = TRUE;
