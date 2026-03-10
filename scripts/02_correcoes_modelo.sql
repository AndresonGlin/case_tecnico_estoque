
--Tabela: pedido_compra
--Alteração para calcular qtd_pendente automáticamente
ALTER TABLE pedido_compra
DROP COLUMN qtde_pendente;

ALTER TABLE pedido_compra
ADD COLUMN qtde_pendente FLOAT8
GENERATED ALWAYS AS (qtde_pedida - qtde_entregue) STORED;

--Tabela: produtos_filial 
--Alteração: padronizar coluna para o nome fornecedor_id
ALTER TABLE public.produtos_filial
RENAME COLUMN idfornecedor TO fornecedor_id;

--Tabela: fornecedor
--Alteração: padronizar coluna para o nome fornecedor_id
ALTER TABLE public.fornecedor
RENAME COLUMN idfornecedor TO fornecedor_id;

--Alteração: padronizar coluna para tipo int4
ALTER TABLE public.fornecedor
ALTER COLUMN fornecedor_id TYPE int4;

