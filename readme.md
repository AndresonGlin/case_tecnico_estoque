# 📊 Desafio Técnico – Análise e Validação de Dados (Systock)

Este repositório contém a solução desenvolvida para o desafio técnico proposto pela Systock.
O objetivo do projeto foi analisar uma base de dados fornecida, realizar a modelagem do banco, importar os dados, validar inconsistências e documentar o processo de validação.

---

# 📁 Estrutura do Projeto

```
systock-desafio/
│
├─ backup/
│   └─ bkp_systock.backup
│
├─ data/
│   ├─ base_teste_systock.xlsx
│   └─ importados/
│        ├─ 01_venda.csv
│        ├─ 02_pedido_compra.csv
│        └─ 03_entradas_mercadoria.csv
│           ...
├─ scripts/
│   ├─ 01_create_tables.sql
│   ├─ 02_validacoes.sql
│      ...
├─ docs/
│   └─ estrategia_validacao.md
│
└─ README.md
```

---

# 🗂 Gestão das Atividades

Durante o desenvolvimento do desafio foi utilizado um **board Kanban no GitHub Projects** para organizar e acompanhar o progresso das atividades.

```bash
Link: https://github.com/users/AndresonGlin/projects/6/views/1
```

O quadro foi estruturado com colunas como:

* **Backlog**
* **Em andamento**
* **Em validação**
* **Concluído**

Esse controle permitiu organizar melhor as etapas do projeto, como:

* análise da base de dados
* criação do modelo de banco
* importação de dados
* validações
* documentação da solução

---

# 🧰 Tecnologias Utilizadas

* Docker
* PostgreSQL
* pgAdmin
* SQL

---

# 🐘 Versões Utilizadas

| Ferramenta              | Versão                |
| ----------------------- | --------------------- |
| PostgreSQL              | 18.1                  |
| pgAdmin                 | latest                |
| Docker Image PostgreSQL | postgres:latest       |
| Docker Image pgAdmin    | dpage/pgadmin4:latest |

Versão do PostgreSQL utilizada no banco:

```
PostgreSQL 18.1 (Debian 18.1-1.pgdg13+2)
```

---

# 🚀 Como Executar o Projeto

## 1️⃣ Clonar o repositório

```bash
git clone https://github.com/SEU-USUARIO/systock-desafio.git
```

Entrar na pasta do projeto:

```bash
cd systock
```

---

# 🐳 Configuração do Ambiente com Docker

## 1️⃣ Criar rede Docker

Criar uma rede para permitir a comunicação entre os containers.

```bash
docker network create systock-network
```

---

## 2️⃣ Subir o container do PostgreSQL

```bash
docker run -d \
--name postgres-server \
--network systock-network \
-e POSTGRES_PASSWORD=postgres \
-p 5433:5432 \
postgres:latest
```

---

## 3️⃣ Subir o container do pgAdmin

```bash
docker run -d \
--name pgadmin \
--network systock-network \
-e PGADMIN_DEFAULT_EMAIL=admin@admin.com \
-e PGADMIN_DEFAULT_PASSWORD=admin \
-p 8080:80 \
dpage/pgadmin4
```

---

# 🌐 Acessar o pgAdmin

Abrir no navegador:

```
http://localhost:8080
```

Login:

```
Email: admin@admin.com
Senha: admin
```

---

# 🔗 Conectar ao PostgreSQL no pgAdmin

Ao adicionar um novo servidor no pgAdmin:

Host:

```
postgres-server
```

Porta:

```
5432
```

Usuário:

```
postgres
```

Senha:

```
postgres
```

---

# 📦 Restaurar o Backup do Banco

O backup do banco utilizado na análise está disponível em:

```
backup/bkp_systock.backup
```

Para restaurar:

1. Criar um novo banco de dados no pgAdmin.
2. Clicar com botão direito no banco criado.
3. Selecionar **Restore**.
4. Escolher o arquivo:

```
bkp_systock.backup
```

5. Executar o restore.

---

# 🔁 Alternativa caso o Restore não funcione

Caso não seja possível restaurar o banco a partir do backup, é possível reproduzir o ambiente manualmente seguindo os passos abaixo.

### 1️⃣ Criar as tabelas

Executar o script:

```
scripts/01_create_tables.sql
```

Esse script contém a criação das tabelas do modelo de dados.

---

### 2️⃣ Aplicar correções de modelagem

Executar os scripts de ajustes de modelagem presentes na pasta:

```
scripts/02_correcoes_modelo.sql
```

Esses scripts realizam ajustes na estrutura do banco para melhorar integridade e consistência dos dados.

---

### 3️⃣ Importar os dados

Importar os arquivos CSV disponíveis em:

```
data/importados/
```

Esses arquivos correspondem às tabelas principais do sistema:

* vendas
* pedidos de compra
* entradas de mercadoria
* produtos filial
* fornecedor

A importação pode ser realizada diretamente pelo **pgAdmin utilizando a função Import/Export**.

---

### 4️⃣ Executar os roteiros de transformação e validação

Após a importação dos dados, executar os scripts SQL disponíveis na pasta:

```
scripts/04_transformacao_dados.sql
```

Eles contêm:

* transformações de dados
* validações
* consultas de verificação

⚠️ **Observação**

No roteiro **04_transformacao_dados** existe a criação de uma **trigger**.
Caso o script seja executado mais de uma vez, pode ser necessário remover a trigger previamente para evitar erro de duplicidade.

---

# 📥 Dados Utilizados

Os dados fornecidos no desafio estão localizados em:

```
data/base_teste_systock.xlsx
```

Os arquivos CSV utilizados para importação estão em:

```
data/importados/
```

---

# 🧱 Estrutura do Banco

O script responsável pela criação das tabelas está em:

```
scripts/01_create_tables.sql
```

Ele contém a definição das seguintes tabelas principais:

* venda
* pedido_compra
* entrada_mercadoria
* fornecedor
* produtos_filial

---

# 🔎 Estratégia de Validação dos Dados

As validações foram implementadas no script:

```
scripts/02_validacoes.sql
```

Entre as validações realizadas:

* Verificação de contagem de registros por tabela
* Validação de integridade entre vendas e produtos
* Verificação de pedidos sem correspondência em entradas
* Identificação de dados inconsistentes
* Validação de fluxo de dados entre pedido, entrada e venda

A documentação detalhada das validações pode ser encontrada em:

```
docs/03_validacao_cliente.md
```

---

# ✔️ Validação do Restore

Após restaurar o banco, é possível validar se a importação ocorreu corretamente executando consultas como:

```sql
SELECT COUNT(*) FROM venda;
SELECT COUNT(*) FROM pedido_compra;
SELECT COUNT(*) FROM entrada_mercadoria;
```

Também foi realizada verificação manual de amostras de dados para garantir consistência.

---

# 🔍 Principais Problemas Identificados

Durante a análise da base foram encontrados alguns pontos relevantes (ex):

1. Uso de FLOAT como identificador em algumas tabelas
2. Campos com valor default '0' que podem gerar inconsistência
3. Possível divergência entre pedidos e entradas de mercadoria (dependendo da regra de negócio)
4. Falta de chaves estrangeiras em algumas relações

Esses foram alguns pontos considerados nas validações implementadas no projeto.

---

# 📌 Considerações

Este projeto demonstra:

* organização de dados
* criação e estruturação de banco relacional
* uso de Docker para ambientes reproduzíveis
* importação e restauração de banco de dados
* validação de integridade de dados
* organização do desenvolvimento utilizando **Kanban**

---

## 👨‍💻 Autor

Andreson Glin
