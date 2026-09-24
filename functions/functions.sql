-- Função SQL para calcular o total efetivamente pago de uma venda.
CREATE OR REPLACE FUNCTION lab.total_pago_venda(p_venda_id BIGINT)
RETURNS NUMERIC(12,2)
LANGUAGE SQL
STABLE
AS $$
    SELECT COALESCE(
        SUM(valor) FILTER (WHERE status = 'CONFIRMADO'),
        0
    )::NUMERIC(12,2)
    FROM lab.pagamentos
    WHERE venda_id = p_venda_id;
$$;

-- Função PL/pgSQL que recalcula os totais a partir dos itens.
CREATE OR REPLACE FUNCTION lab.recalcular_venda(p_venda_id BIGINT)
RETURNS VOID
LANGUAGE plpgsql
AS $$
DECLARE
    v_subtotal NUMERIC(12,2);
BEGIN
    SELECT COALESCE(SUM(total_item), 0)
      INTO v_subtotal
      FROM lab.itens_venda
     WHERE venda_id = p_venda_id;

    UPDATE lab.vendas
       SET subtotal = v_subtotal,
           total = GREATEST(v_subtotal - desconto, 0)
     WHERE id = p_venda_id;
END;
$$;
