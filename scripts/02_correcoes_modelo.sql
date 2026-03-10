
--Tabela: produtos_filial 
ALTER TABLE public.produtos_filial
RENAME COLUMN idfornecedor TO fornecedor_id;


--Tabela: fornecedor
ALTER TABLE public.fornecedor
RENAME COLUMN idfornecedor TO fornecedor_id;


ALTER TABLE public.fornecedor
ALTER COLUMN fornecedor_id TYPE int4;

