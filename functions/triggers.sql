-- Trigger genérico para atualização automática de atualizado_em.
CREATE OR REPLACE FUNCTION lab.definir_atualizado_em()
RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
BEGIN
    NEW.atualizado_em = NOW();
    RETURN NEW;
END;
$$;

DROP TRIGGER IF EXISTS trg_clientes_atualizado_em ON lab.clientes;
CREATE TRIGGER trg_clientes_atualizado_em
BEFORE UPDATE ON lab.clientes
FOR EACH ROW
EXECUTE FUNCTION lab.definir_atualizado_em();

DROP TRIGGER IF EXISTS trg_produtos_atualizado_em ON lab.produtos;
CREATE TRIGGER trg_produtos_atualizado_em
BEFORE UPDATE ON lab.produtos
FOR EACH ROW
EXECUTE FUNCTION lab.definir_atualizado_em();

-- Recalcula o total da venda sempre que os itens forem alterados.
CREATE OR REPLACE FUNCTION lab.trg_recalcular_total_venda()
RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
DECLARE
    v_venda_id BIGINT;
BEGIN
    v_venda_id := COALESCE(NEW.venda_id, OLD.venda_id);
    PERFORM lab.recalcular_venda(v_venda_id);
    RETURN COALESCE(NEW, OLD);
END;
$$;

DROP TRIGGER IF EXISTS trg_itens_recalcular_venda ON lab.itens_venda;
CREATE TRIGGER trg_itens_recalcular_venda
AFTER INSERT OR UPDATE OR DELETE ON lab.itens_venda
FOR EACH ROW
EXECUTE FUNCTION lab.trg_recalcular_total_venda();
