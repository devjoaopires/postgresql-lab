# 🐘 PostgreSQL Lab

Laboratório prático dedicado ao estudo e à aplicação de **PostgreSQL**, com foco em modelagem de dados, SQL, integridade, performance e recursos avançados de bancos de dados relacionais.

Este repositório reúne exemplos desenvolvidos para demonstrar conhecimentos práticos em PostgreSQL utilizando cenários e dados totalmente fictícios.

---

## 🎯 Objetivo

O objetivo deste projeto é documentar e demonstrar, de forma prática, conceitos utilizados no desenvolvimento de aplicações que trabalham com bancos de dados relacionais.

Os exemplos abrangem desde a criação de estruturas básicas até consultas, transações e técnicas de otimização.

---

## 🧠 Conteúdos abordados

- Modelagem de bancos de dados relacionais
- Criação e alteração de tabelas
- Primary Keys e Foreign Keys
- Constraints
- Relacionamentos entre tabelas
- `INNER JOIN`, `LEFT JOIN` e outros tipos de JOIN
- Subqueries
- Common Table Expressions (`CTE`)
- Agregações e agrupamentos
- Views
- Functions
- Triggers
- Transactions
- Índices
- Window Functions
- Consultas parametrizadas
- Integridade referencial
- `EXPLAIN`
- `EXPLAIN ANALYZE`
- Otimização de consultas
- Boas práticas com PostgreSQL

---

## 📂 Estrutura do repositório

```text
postgresql-lab/
│
├── schema/
│   ├── 01_tables.sql
│   ├── 02_constraints.sql
│   ├── 03_relationships.sql
│   └── 04_indexes.sql
│
├── queries/
│   ├── joins.sql
│   ├── subqueries.sql
│   ├── cte.sql
│   ├── window-functions.sql
│   └── reports.sql
│
├── functions/
│   ├── functions.sql
│   └── triggers.sql
│
├── transactions/
│   └── transactions.sql
│
├── performance/
│   ├── indexes.sql
│   └── explain-analyze.sql
│
├── examples/
│   └── ecommerce.sql
│
└── README.md
