
/* Monte uma consulta que traga o total de vendas, em quantidade e em valores (R$), de cada produto, no mês de fevereiro de 2025. */

select 
	to_char(venda.data_emissao,'mm/yyyy') as competencia,
    venda.produto_id,
    coalesce(pf.descricao, 'Sem Descricao') as descricao,   
    sum(venda.qtde_vendida) as total_quantidade_vendida,
    round(sum(venda.qtde_vendida * venda.valor_unitario)::numeric, 2) AS total_valor_vendido
from venda 
left join produtos_filial pf
	on venda.produto_id = pf.produto_id 
where venda.data_emissao between '2025-02-01' and '2025-02-28'
group by
		 to_char(venda.data_emissao,'mm/yyyy'),
		 venda.produto_id, 
		 pf.descricao		 
order by venda.produto_id;


/* Crie uma consulta para listar os produtos que foram requisitados, mas não recebidos. */

select	
	pedido_id,
    produto_id,
    descricao_produto,
    qtde_pedida,
    qtde_entregue,
    (qtde_pedida - qtde_entregue) AS quantidade_pendente
 from pedido_compra
where qtde_entregue < qtde_pedida    
order by produto_id;