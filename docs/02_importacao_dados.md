=====================================================
IMPORTAÇÃO DE DADOS
=====================================================

- Os dados foram extraídos da planilha: base_teste_systock.xlsx
- Ferramenta utilizada para importação: Dbeaver

## Processo de Importação Geral, para todas as tabelas.

1. Exportação de cada aba da planilha Excel para CSV (separadamente).
2. Verificação do nome das colunas (quantidade, descrição). Checar se bate com a tabela existente no banco de dados.
3. Alterar tipo de dado se necessário.
4. Importação inicial com apenas duas linhas da planilha para validar compatibilidade de tipos de dados e estrutura da tabela antes da carga completa.
5. Após a validação dessa importação inicial, é realizada a importação completa das demais linhas.
6. Resumo Dbeaver: 
    - Clicar com botão direito no mouse na tabela que deseja importar dados.
    - Selecionar opção importar dados
    - Selecionar a opção de CSV e avançar
    - Selecionar arquivo a ser importado. Realizar configuração de Top e definir delimitação de coluna (Ex: , ou ;) e avançar.
    - Selecionar o mapeamento das colunas e verificar se os campos do CSV foram corretamente associados às colunas da tabela. 
    - Por fim, confirmar.


Tabela: venda (passo a passo)
-----------------------------------------------------

1 - Estrutura da Planilha:

Coluna / Tipo

- venda_id: inteiro 
- data_emissao: texto (padrão: YYYY-MM-DD)
- horariomov: texto 
- produto_id: texto
- qtde_vendida: texto (Subtituido vírgula por (.))
- valor_unitario: texto (Subtituido vírgula por (.))
- filial_id: inteiro 
- item: inteiro 
- unidade_medida: texto


2 - Tratamentos aplicados

Durante o processo de importação, os dados da planilha foram adaptados para atender à estrutura da tabela venda no banco:

- Conversão de data_emissao para o tipo TEXTO (padrão: YYYY-MM-DD). Como se trata de poucas linhas, recomendo salvar em um documento a coluna de datas, em seguida
transforme a coluna na planilha para o tipo texto e depois cole as datas no formato YYYY-MM-DD.
- Substituição do separador decimal de vírgula (,) por ponto (.), nos campos qtde_vendida, valor_unitario e transformado para Texto a coluna. 
    
3 - Validação inicial

Após a importação foi realizada a verificação da quantidade de registros:

- SELECT COUNT(*) FROM venda;


Após a validação da tabela venda, o mesmo processo de importação
foi aplicado às demais tabelas da planilha:

Obs: Caso alguma tabela apresente inconsistências, estas serão
registradas abaixo, juntamente com a decisão adotada para permitir
a continuidade do processo de importação.

-----------------------------------------------------

Tabela: pedido_compra

Inconsistências identificadas:

1. A coluna qtde_pendente não existe na base enviada para importar, porém existe na entrutura do banco de dados. 
   Obs: Após a tabela ter sido criada, sua coluna foi tratada (pasta script -> 02_correcoes_modelo.sql) para fazer o cálculo automáticamente. 

2. Foram identificadas linhas contendo mais colunas do que o layout
   definido na tabela.

Decisões adotadas:

1. As colunas adicionais sem correspondência no layout definido
   foram removidas do arquivo de importação.

Obs: A base de dados original foi preservada e armazenada para
posterior análise junto ao cliente, com o objetivo de validar
essas inconsistências identificadas.


-----------------------------------------------------

Tabela: entradas_mercadoria

-----------------------------------------------------

Tabela: produtos_filial

Inconsistências identificadas:

1. A coluna idfornecedor na estrutura do banco de dados está definida
   como tipo numérico (INT4). Entretanto, na planilha de origem os
   valores dessa coluna possuem um prefixo textual "F" antes do código
   numérico (exemplo: F01, F02).

2. Alterado idfornecedor para fornecedor_id no banco e planilha, seguindo o padrão da tabela pedido_compra. (alteração está na pasta script -> 02_correcoes_modelo.sql) 

Decisões adotadas:

1. Para viabilizar a importação dos dados, foi realizada a remoção do
   prefixo "F" dos valores da coluna idfornecedor, mantendo apenas a
   parte numérica do identificador.


-----------------------------------------------------

Tabela: fornecedor

Ajustes realizados:

1. Alterado idforncedor para fornecedor_id no banco e planilha, seguindo o    padrão da tabela pedido_compra e prudutos_filial. (alteração está na pasta script -> 02_correcoes_modelo.sql) 

2. A coluna fornecedor_id na estrutura do banco de dados está definida
   como tipo numérico (INT4). Entretanto, na planilha de origem os
   valores dessa coluna possuem um prefixo textual "F" antes do código
   numérico (exemplo: F01, F02).

Decisões adotadas:

1. Para viabilizar a importação dos dados, foi realizada a remoção do
   prefixo "F" dos valores da coluna idfornecedor, mantendo apenas a
   parte numérica do identificador.


Obs: A base de dados original foi preservada para futura validação
junto ao cliente, caso seja necessário confirmar qual formato de
identificador deve ser considerado como padrão.

