--1.Concatenar os campos produto_id e descricao_produto (onde houver) no formato;
--2.Transformar o campo de datas para o formato DD/MM/YYYY;
SELECT
    produto_id || ' - ' || descricao_produto AS produto,
    to_char(data_pedido,'DD/MM/YYYY') AS data_pedido_formatada,
    qtde_pedida
FROM pedido_compra;

SELECT 
	venda_id,
	to_char(data_emissao ,'DD/MM/YYYY') AS data_venda,
	qtde_vendida,
	valor_unitario
FROM venda 

--3. Retornar os dados filtrando apenas os produtos requisitados mais de 10 vezes no período.
SELECT
    produto_id || ' - ' || COALESCE(descricao_produto,'Sem Descrição') AS produto,
    COUNT(*) AS qtde_requisitada,
    TO_CHAR(MIN(data_pedido),'DD/MM/YYYY') AS data_solicitacao
FROM pedido_compra
WHERE data_pedido BETWEEN '2025-02-01' AND '2025-02-28'
GROUP BY produto_id, descricao_produto
HAVING COUNT(*) > 10
ORDER BY produto;


--4.Criação Trigger 

-- 1.Criar sequence
CREATE SEQUENCE seq_fornecedor_id START 1;

-- 2.Ajustar sequence para iniciar a partir do ultimo fornecedor existente
SELECT setval(
    'seq_fornecedor_id',
    COALESCE((SELECT MAX(fornecedor_id::int) FROM fornecedor),0)
);

-- 3.Criar a função que usará a sequence.
CREATE OR REPLACE FUNCTION gerar_idfornecedor()
RETURNS TRIGGER AS $$
BEGIN

    IF NEW.fornecedor_id IS NULL THEN
        NEW.fornecedor_id := nextval('seq_fornecedor_id');
    END IF;

    RETURN NEW;

END;
$$ LANGUAGE plpgsql;

-- 4.Criar a trigger
CREATE TRIGGER trg_gerar_fornecedor
BEFORE INSERT ON produtos_filial
FOR EACH ROW
EXECUTE FUNCTION gerar_idfornecedor();

--5.Validar trigger
INSERT INTO produtos_filial(filial_id,produto_id,descricao,estoque,preco_unitario,preco_compra,preco_venda)VALUES(1,'P999','Produto Teste', 10, 5, 3, 8);

/*
Observação: A trigger atual gera automaticamente um fornecedor_id na tabela produtos_filial, independente da existência do fornecedor na tabela fornecedor.
Em uma implementação real, é recomendado que os produtos se relacionem com fornecedores existentes para manter a integridade referencial.
*/