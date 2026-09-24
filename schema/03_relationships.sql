-- PostgreSQL Lab
-- Etapa 3: relacionamentos e regras de chave estrangeira.

ALTER TABLE lab.produtos
    ADD CONSTRAINT fk_produtos_categoria
    FOREIGN KEY (categoria_id)
    REFERENCES lab.categorias(id)
    ON UPDATE CASCADE
    ON DELETE SET NULL;

ALTER TABLE lab.vendas
    ADD CONSTRAINT fk_vendas_cliente
    FOREIGN KEY (cliente_id)
    REFERENCES lab.clientes(id)
    ON UPDATE CASCADE
    ON DELETE RESTRICT;

ALTER TABLE lab.itens_venda
    ADD CONSTRAINT fk_itens_venda
    FOREIGN KEY (venda_id)
    REFERENCES lab.vendas(id)
    ON UPDATE CASCADE
    ON DELETE CASCADE,
    ADD CONSTRAINT fk_itens_produto
    FOREIGN KEY (produto_id)
    REFERENCES lab.produtos(id)
    ON UPDATE CASCADE
    ON DELETE RESTRICT;

ALTER TABLE lab.pagamentos
    ADD CONSTRAINT fk_pagamentos_venda
    FOREIGN KEY (venda_id)
    REFERENCES lab.vendas(id)
    ON UPDATE CASCADE
    ON DELETE CASCADE;

ALTER TABLE lab.movimentacoes_estoque
    ADD CONSTRAINT fk_movimentacoes_produto
    FOREIGN KEY (produto_id)
    REFERENCES lab.produtos(id)
    ON UPDATE CASCADE
    ON DELETE RESTRICT;
