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
```

---

## 🗃️ Banco de exemplo

Os exemplos deste laboratório utilizam um cenário fictício de sistema comercial, permitindo trabalhar com entidades como:

- clientes
- produtos
- categorias
- vendas
- itens de venda
- pagamentos
- estoque

Nenhum dado utilizado neste projeto pertence a sistemas ou bancos de dados reais.

---

## 🚀 Executando o projeto

É necessário ter o PostgreSQL instalado.

Crie um banco para o laboratório:

```sql
CREATE DATABASE postgresql_lab;
```

Ou pelo terminal:

```bash
createdb postgresql_lab
```

Depois, execute os arquivos SQL:

```bash
psql -d postgresql_lab -f schema/01_tables.sql
```

Os demais scripts podem ser executados conforme a ordem e o assunto estudado.

---

## ⚡ Performance

Uma parte do laboratório é dedicada à análise e otimização de consultas utilizando recursos nativos do PostgreSQL.

Exemplo:

```sql
EXPLAIN ANALYZE
SELECT
    c.nome,
    COUNT(v.id) AS total_vendas
FROM clientes c
LEFT JOIN vendas v
    ON v.cliente_id = c.id
GROUP BY c.id, c.nome
ORDER BY total_vendas DESC;
```

O objetivo é analisar planos de execução, identificar gargalos e entender quando índices podem melhorar o desempenho das consultas.

---

## 🔐 Segurança e privacidade

Este projeto utiliza somente informações fictícias.

Arquivos com credenciais ou informações sensíveis não devem ser versionados, incluindo:

```text
.env
.env.*
*.pem
*.key
*.p12
*.pfx
*.dump
*.sql.gz
```

Credenciais de bancos reais, endereços de servidores, backups e informações de clientes não fazem parte deste repositório.

---

## 🛠️ Tecnologia

<p>
  <img
    alt="PostgreSQL"
    title="PostgreSQL"
    width="45px"
    src="https://cdn.jsdelivr.net/gh/devicons/devicon@latest/icons/postgresql/postgresql-original.svg"
  />
</p>

**PostgreSQL**

---

## 📈 Evolução do laboratório

Este repositório será expandido gradualmente com novos exemplos de SQL, modelagem, administração e otimização de bancos PostgreSQL.

A ideia é manter os exemplos organizados, reproduzíveis e próximos de situações encontradas em aplicações reais.

---

## 👨🏻‍💻 Autor

**João Pires**

Desenvolvedor Fullstack

[GitHub](https://github.com/devjoaopires)
