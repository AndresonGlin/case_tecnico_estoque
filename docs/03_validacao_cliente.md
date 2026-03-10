=====================================================
ROTEIRO DE VALIDAÇÃO COM O CLIENTE - FEV/2025
=====================================================

## 1 - Principais pontos para validação:

- Integridade dos dados:
  Validar dados importados no banco de dados comparando com a base de origem.

- Validar fluxo de operação dos dados:
  Ex: 
    1.Data de entrega do pedido é posterior à data do pedido.        

- Identificar dados inconsistêntes. 
  Ex:
    1. Produto vendido sem cadastro.
    2. Venda sem entrada de mercadoria.
    3. Pedido de compra com mesma ordem de serviço e o código da mesma sendo zero.

    
## 2 - Técnias utilizadas para garantir exatidão dos dados:

- Validação por amostragem. 

1. Primeiro: foi escolhido um produto para checar a existencia dele em todas a etapas (tabelas) do processo.

    - Produto P15, tabelas verificadas: 
        1. produtos_filial
        2. fornecedor
        3. pedido_compra
        4. entrada_mercadoria
        5. venda
    - Obs: Sempre se baseando pela base de origem enviada.

2. Segundo: escolher um mês fechado para realizar validação (fev/2025), confome solicitado.

    - Realizado a seguinte análise:
        1. Total de vendas por produto - fev/25
        2. Identifcar produtos vendido sem cadastro - fev/25
        3. Identificar produto sem entrada de mercadoria - fev/25
        4. Pedidos de compra realizado em fev/25
        5. Pedido de compra com data de entrega inferior a data do pedido.
        6. Pedido de compra com mesma orgdem de compra e o código da mesma sendo zero.
        ...

## 3 - Consultas prontas para a reunião

- As consultas prontas estão na pasta SCRIPT, arquivo, 05_validacao_cliente.sql

Outra sugestão:    
    Criar uma planilha no excel seguindo a linha do tempo das consultas, talvez inserir duas tabelas, uma com os dados de origem e a outra retirada do banco para mostrar para o cliente. 





