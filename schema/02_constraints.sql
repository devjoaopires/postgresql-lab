-- PostgreSQL Lab
-- Etapa 2: constraints de domínio e integridade.

ALTER TABLE lab.clientes
    ADD CONSTRAINT uq_clientes_email UNIQUE (email),
    ADD CONSTRAINT uq_clientes_documento UNIQUE (documento),
    ADD CONSTRAINT ck_clientes_email_basico CHECK (POSITION('@' IN email) > 1);

ALTER TABLE lab.categorias
    ADD CONSTRAINT uq_categorias_nome UNIQUE (nome);

ALTER TABLE lab.produtos
    ADD CONSTRAINT uq_produtos_sku UNIQUE (sku),
    ADD CONSTRAINT ck_produtos_preco CHECK (preco >= 0),
    ADD CONSTRAINT ck_produtos_estoque CHECK (estoque_atual >= 0),
    ADD CONSTRAINT ck_produtos_estoque_minimo CHECK (estoque_minimo >= 0);

ALTER TABLE lab.vendas
    ADD CONSTRAINT ck_vendas_status
        CHECK (status IN ('ABERTA', 'FINALIZADA', 'CANCELADA')),
    ADD CONSTRAINT ck_vendas_subtotal CHECK (subtotal >= 0),
    ADD CONSTRAINT ck_vendas_desconto CHECK (desconto >= 0),
    ADD CONSTRAINT ck_vendas_total CHECK (total >= 0),
    ADD CONSTRAINT ck_vendas_total_coerente CHECK (total = subtotal - desconto);

ALTER TABLE lab.itens_venda
    ADD CONSTRAINT ck_itens_quantidade CHECK (quantidade > 0),
    ADD CONSTRAINT ck_itens_preco CHECK (preco_unitario >= 0),
    ADD CONSTRAINT ck_itens_desconto CHECK (desconto >= 0),
    ADD CONSTRAINT ck_itens_total CHECK (total_item >= 0);

ALTER TABLE lab.pagamentos
    ADD CONSTRAINT ck_pagamentos_valor CHECK (valor > 0),
    ADD CONSTRAINT ck_pagamentos_forma
        CHECK (forma IN ('DINHEIRO', 'PIX', 'DEBITO', 'CREDITO')),
    ADD CONSTRAINT ck_pagamentos_status
        CHECK (status IN ('PENDENTE', 'CONFIRMADO', 'ESTORNADO'));

ALTER TABLE lab.movimentacoes_estoque
    ADD CONSTRAINT ck_movimentacoes_tipo
        CHECK (tipo IN ('ENTRADA', 'SAIDA')),
    ADD CONSTRAINT ck_movimentacoes_quantidade CHECK (quantidade > 0);
