# Supermarket Analytics Engineering 🛒📊

Projeto *End-to-End* de Engenharia de Dados simulando o ecossistema de dados de uma grande rede de varejo ("MC Supermercados"). 

O objetivo foi construir um **Data Warehouse** do zero, partindo da geração de dados massivos (Python), passando pela modelagem dimensional e carga (SQL Server), até a preparação para Analytics.

---

## 🏗️ Arquitetura do Projeto

**Fluxo de Dados:**
`Geração de Dados (Python)` ➔ `ETL & Tratamento` ➔ `Data Warehouse (SQL Server)` ➔ `Analytics (SQL/Power BI)`

* **Volume de Dados:** +2.4 Milhões de registros de vendas gerados.
* **Modelagem:** Star Schema (Esquema Estrela) com tabela Fato e Dimensões.
* **Período:** Dados transacionais simulando o ano fiscal de 2025.

## 🛠️ Tecnologias Utilizadas

* **Python:** Pandas, Numpy, Faker (Geração de dados sintéticos complexos com sazonalidade e regras de negócio).
* **SQL Server:** Banco de Dados Relacional e Data Warehouse.
* **SQLAlchemy & PyODBC:** Conectores para pipeline de ETL.
* **SQL Avançado:** Window Functions (LAG, RANK), CTEs e Otimização de Índices.
* **Git/GitHub:** Versionamento e Documentação.

---

## 📂 Estrutura do Repositório

```text
SupermarketAnalyticsEngineering/
│
├── 📁 src/                  # Notebooks Python para Geração e ETL
│   ├── Gerador de Vendas.ipynb        (Regras de negócio e geração de massa)
│   └── Gerador do Banco de Dados.ipynb (Pipeline de Carga para o SQL Server)
│
├── 📁 sql/                  # Scripts SQL
│   ├── estrutura_tabelas/   (DDL das tabelas Fato e Dimensões)
│   ├── analise_avancada/    (Queries de negócio: Churn, Month-over-Month, Ranking)
│   └── queries_validacao.sql (Scripts de auditoria de dados)
│
├── 📁 data/                 # Arquivos CSV brutos (Gitgnored devido ao tamanho)
└── README.md                # Documentação do Projeto
