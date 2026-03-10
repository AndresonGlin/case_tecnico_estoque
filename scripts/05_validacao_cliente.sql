/*  	
	1. Validar importação dos dados com apenas um produto (P15).
	Objetivo: Validar os dados da importação em todas as tabelas.

	2. Validar os dados do mês de Fev/2025, conforme solicitado.

	3. Registrar insconsistências para checar junto ao cliente.
*/


/********* ETAPA 1 ***********/

--1. Verificar se produto foi importado com sucesso.
SELECT * 
FROM produtos_filial
WHERE produto_id = 'P15'

--1.2. Verificar se o fornecedor do produto existe.
SELECT * 
FROM fornecedor
WHERE fornecedor_id = '5'

--1.3. Verificar se existe pedido de compra.
SELECT *
 FROM pedido_compra
 WHERE ordem_compra = 15
   AND produto_id = 'P15'

--1.4. Verificar se existe entrada do produto atraves de alguma ordem de compra.
SELECT * 
FROM entradas_mercadoria
 WHERE ordem_compra = 15
 AND produto_id = 'P15'

--1.5. Verificar se existe alguma venda desse produto.
SELECT * 
FROM venda
WHERE data_emissao BETWEEN '2025-02-01' AND '2025-02-28'
 AND produto_id = 'P15'


/********* ETAPA 1 e 2 ***********/

-- 3.1 Total de vendas por produto em Fevereiro/2025 (tabela venda - fato)
SELECT 
	to_char(venda.data_emissao,'MM/YYYY') AS compentencia,
    venda.produto_id,
    COALESCE(produto.descricao,'N Cadastrado') AS descricao,
    SUM(venda.qtde_vendida) AS total_qte_vendida,
	venda.valor_unitario as valor_unitario,
    ROUND(SUM(venda.qtde_vendida * venda.valor_unitario)::numeric, 2) AS total_valor
FROM venda
LEFT JOIN produtos_filial produto ON venda.produto_id = produto.produto_id
WHERE venda.data_emissao BETWEEN '2025-02-01' AND '2025-02-28'
  --AND produto.produto_id = 'P17'
GROUP BY 
	to_char(venda.data_emissao,'MM/YYYY'),
	venda.produto_id, 
	produto.descricao,
	venda.valor_unitario
ORDER BY 
    total_valor DESC;


-- 3.2 Baseado na consulta 3.1, identificar porque produto não contem descrição:
-- Motivo: Produto vendido não cadastrado (Ex: produto P25) - Inconsistência
SELECT * FROM produtos_filial WHERE produto_id = 'P25'


-- 3.3 Produto vendido em fev/25 sem registro de entrada no estoque - Inconsistência
SELECT 
    venda.produto_id,
    venda.data_emissao AS data_venda,
    entradas.data_entrada
FROM venda
LEFT JOIN entradas_mercadoria entradas 
       ON venda.produto_id = entradas.produto_id
       AND entradas.data_entrada <= venda.data_emissao
WHERE entradas.produto_id IS NULL
 AND venda.data_emissao BETWEEN '2025-02-01' AND '2025-02-28';


-- 3.4 Pedidos de compra realizados em Fevereiro/2025
SELECT *
FROM pedido_compra
WHERE data_pedido BETWEEN '2025-02-01' AND '2025-02-28'  


--3.5 Pedido de compra com a data de entrega inferior a data do pedido - Inconsistência
SELECT *
FROM pedido_compra
WHERE data_pedido BETWEEN '2025-02-01' AND '2025-02-28'
  AND data_entrega < data_pedido


--3.6 Pedido de compra com mesma ordem de compra e codigo sendo zero - Inconsistência
SELECT *
FROM pedido_compra
WHERE data_pedido BETWEEN '2025-02-01' AND '2025-02-28'
  AND ordem_compra = 0


-- 3.7 Entradas de mercadoria em Fevereiro/2025
SELECT *
FROM entradas_mercadoria
WHERE data_entrada BETWEEN '2025-02-01' AND '2025-02-28'


-- 3.4 Conferência de produtos e fornecedores
SELECT produto.produto_id, 
	   produto.descricao, 
	   produto.fornecedor_id, 
	   fornecedor.razao_social
FROM produtos_filial produto
LEFT JOIN fornecedor ON produto.fornecedor_id = fornecedor.fornecedor_id;

