
/* Monte uma consulta que traga o total de vendas, em quantidade e em valores (R$), de cada produto, no mês de fevereiro de 2025. */

SELECT 
	to_char(venda.data_emissao,'mm/yyyy') as competencia,
    venda.produto_id,
    coalesce(pf.descricao, 'Sem Descricao') as descricao,   
    sum(venda.qtde_vendida) as total_quantidade_vendida,
    round(sum(venda.qtde_vendida * venda.valor_unitario)::numeric, 2) AS total_valor_vendido
FROM venda 
LEFT JOIN produtos_filial pf
	ON venda.produto_id = pf.produto_id 
WHERE venda.data_emissao between '2025-02-01' and '2025-02-28'
GROUP BY
		 to_char(venda.data_emissao,'mm/yyyy'),
		 venda.produto_id, 
		 pf.descricao		 
ORDER BY venda.produto_id;


/* Crie uma consulta para listar os produtos que foram requisitados, mas não recebidos. */

SELECT	
	pedido_id,
    produto_id,
    descricao_produto,
    qtde_pedida,
    qtde_entregue,
    (qtde_pedida - qtde_entregue) AS quantidade_pendente
FROM pedido_compra
WHERE qtde_entregue < qtde_pedida    
ORDER BY produto_id;