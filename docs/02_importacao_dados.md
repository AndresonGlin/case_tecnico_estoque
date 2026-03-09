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
- data_emissao: data (transformado)
- horariomov: texto 
- produto_id: texto
- qtde_vendida: numero (Subtituido vírgula por ponto)
- valor_unitario: numero (Subtituido vírgula por ponto)
- filial_id: inteiro 
- item: inteiro 
- unidade_medida: texto


2 - Tratamentos aplicados

Durante o processo de importação, os dados da planilha foram adaptados para atender à estrutura da tabela venda no banco:

- Conversão de data_emissao para o tipo DATE
- Substituição do separador decimal de vírgula (,) por ponto (.), nos campos qtde_vendida, valor_unitario.
    
3 - Validação inicial

Após a importação foi realizada a verificação da quantidade de registros:

- SELECT COUNT(*) FROM venda;


Após a validação da tabela venda, o mesmo processo de importação
foi aplicado às demais tabelas da planilha:

