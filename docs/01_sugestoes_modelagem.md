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


Tabela: entradas_mercadoria
-----------------------------------------------------

1 - Inconsistência na chave primária
A estrutura original da tabela não possuía a coluna ordem_compra,
apesar dela estar definida na chave primária.

Foi necessário incluir essa coluna na estrutura da tabela para
permitir a criação correta da PK.

2 - Uso de FLOAT para identificadores
O campo item utiliza FLOAT, porém ele faz parte da chave primária.
O ideal seria utilizar INTEGER, pois identificadores não devem
utilizar tipos de ponto flutuante.

3 - Uso de DEFAULT em identificadores
O campo produto_id possui DEFAULT '0'. Esse tipo de prática pode
gerar registros inconsistentes.

4 - Campos de quantidade
O campo qtde_recebida utiliza FLOAT. Dependendo da regra de
negócio, poderia ser avaliado o uso de NUMERIC para maior
controle de precisão.

Tabela: produtos_filial
-----------------------------------------------------

1 - Correções estruturais necessárias
O script original apresentava alguns problemas que impediam
a criação da tabela:

- Ausência de vírgula após a coluna idfornecedor.
- Nome incorreto da coluna na chave primária (idproduto).
- Nome da coluna idfonecedor incorreto, corrigido para idfornecedor.

2 - Campos de valores monetários utilizando FLOAT
Os campos preco_unitario, preco_compra e preco_venda utilizam FLOAT.
Para valores financeiros o recomendado seria utilizar
NUMERIC(12,4), evitando problemas de precisão em cálculos.

3 - Campo de estoque utilizando FLOAT
O campo estoque utiliza FLOAT. Dependendo da regra de negócio,
poderia ser avaliado o uso de INTEGER ou NUMERIC, pois quantidades
de itens geralmente não precisam de ponto flutuante.

4 - Possível erro de nomenclatura
A coluna "decricao" aparenta ser um erro de digitação.
O ideal seria utilizar "descricao" para manter consistência
e clareza na estrutura do banco.


Padronização geral de tipos
-----------------------------------------------------

Algumas melhorias sugeridas em uma tabela podem ser replicadas em outras tabelas
do modelo. Por esse motivo não foi detalhado todas as melhorias de cada tabela espcificamente.

Por exemplo:

- Campos de quantidade definidos como FLOAT poderiam utilizar
NUMERIC para evitar problemas de precisão. (Dependendo da regra de negócio)

- Identificadores (IDs, itens, ordens, etc.) deveriam utilizar
INTEGER