=====================================================
ALGUMAS SUGESTÕES DE MELHORIA NA MODELAGEM
=====================================================

Tabela: pedido_compra
-----------------------------------------------------

1 - Evitar uso de FLOAT para identificadores
Campos como pedido_id, item e ordem_compra utilizam FLOAT.
O ideal seria utilizar tipos inteiros (INTEGER).

2 - Campos com DEFAULT '0'
O campo produto_id possui valor default '0', o que pode gerar
registros inválidos. O ideal seria obrigar o preenchimento.

3 - Tipagem de valores monetários
O campo preco_compra utiliza FLOAT. Para valores financeiros,
o recomendado seria utilizar NUMERIC(12,4) para evitar
problemas de precisão.


Tabela: venda
-----------------------------------------------------

1 - Alterar o VARCHAR para TIME
O campo horariomov está definido como VARCHAR. O tipo TIME
permitiria validação automática do formato do horário.

2 - Padronização de nomes de constraint
A constraint "pk_consumo" poderia ser renomeada para "pk_venda",
para refletir corretamente a tabela onde está definida.


Padronização geral de tipos
-----------------------------------------------------

Algumas melhorias sugeridas em uma tabela podem ser replicadas em outras tabelas
do modelo. Por esse motivo não foi detalhado todas as melhorias de cada tabela espcificamente.

Por exemplo:

- Campos de quantidade definidos como FLOAT poderiam utilizar
NUMERIC para evitar problemas de precisão.
