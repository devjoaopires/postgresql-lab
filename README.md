# 🐘 PostgreSQL Lab

Laboratório prático dedicado ao estudo e à aplicação de **PostgreSQL**, com foco em modelagem relacional, SQL, integridade de dados, transações, performance e recursos avançados.

Este repositório utiliza apenas **dados fictícios** e foi criado para demonstrar, por meio de código executável, conhecimentos aplicáveis a sistemas reais.

---

## 🎯 Objetivo

Demonstrar de forma prática conceitos usados no desenvolvimento de aplicações que trabalham com bancos de dados relacionais, desde a criação do schema até análise de planos de execução e otimização de consultas.

---

## 🧠 Conteúdos abordados

- Modelagem de bancos de dados relacionais
- Primary Keys e Foreign Keys
- `CHECK`, `UNIQUE` e integridade referencial
- Relacionamentos e regras de exclusão/atualização
- `INNER JOIN` e `LEFT JOIN`
- Subqueries e `EXISTS`
- Common Table Expressions (`CTE`)
- Agregações e `FILTER`
- Views e Materialized Views
- Functions SQL e PL/pgSQL
- Triggers
- Transactions, `SAVEPOINT` e `FOR UPDATE`
- Índices compostos, funcionais e parciais
- Window Functions
- Prepared Statements e consultas parametrizadas
- `EXPLAIN` e `EXPLAIN ANALYZE`
- Análise de buffers e planos de execução
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
│   ├── reports.sql
│   ├── views.sql
│   └── prepared-statements.sql
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
├── setup.sql
├── .gitignore
└── README.md
```

---

## 🗃️ Banco de exemplo

O laboratório simula um pequeno sistema comercial com entidades como:

- clientes
- categorias
- produtos
- vendas
- itens de venda
- pagamentos
- movimentações de estoque

O dataset em `examples/ecommerce.sql` é totalmente fictício.

---

## 🚀 Executando o projeto

Tenha o PostgreSQL e o cliente `psql` instalados.

Crie o banco:

```bash
createdb postgresql_lab
```

Na raiz do repositório, execute:

```bash
psql -d postgresql_lab -f setup.sql
```

O `setup.sql` executa, na ordem:

1. criação das tabelas;
2. constraints;
3. foreign keys;
4. índices;
5. functions;
6. triggers;
7. dataset fictício.

Depois disso, os arquivos de `queries/`, `transactions/` e `performance/` podem ser executados individualmente.

Exemplo:

```bash
psql -d postgresql_lab -f queries/cte.sql
```

---

## ⚡ Performance

O laboratório inclui exemplos com `EXPLAIN (ANALYZE, BUFFERS)` para comparar estimativas do planner com a execução real.

Exemplo:

```sql
EXPLAIN (ANALYZE, BUFFERS)
SELECT
    p.id,
    p.nome,
    SUM(iv.quantidade) AS quantidade_vendida
FROM lab.produtos AS p
JOIN lab.itens_venda AS iv
    ON iv.produto_id = p.id
JOIN lab.vendas AS v
    ON v.id = iv.venda_id
WHERE v.status = 'FINALIZADA'
GROUP BY p.id, p.nome
ORDER BY quantidade_vendida DESC
LIMIT 10;
```

Os exemplos observam pontos como:

- `Seq Scan` versus `Index Scan`;
- estimativa de linhas versus linhas reais;
- índices compostos;
- índices funcionais;
- índices parciais;
- custo de ordenação;
- buffers utilizados;
- tempo total da consulta.

---

## 🔐 Segurança e privacidade

Este projeto não utiliza credenciais, dumps ou informações de produção.

O `.gitignore` bloqueia arquivos comuns que podem conter informações sensíveis, como:

```text
.env
.env.*
*.pem
*.key
*.p12
*.pfx
*.dump
*.backup
*.sql.gz
```

Não fazem parte deste repositório:

- senhas de banco;
- strings de conexão reais;
- IPs de servidores;
- backups de produção;
- certificados;
- tokens;
- informações reais de clientes.

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

O repositório pode continuar evoluindo com exemplos de migrations, isolamento de transações, locking, JSONB, full-text search, procedures, particionamento, backup/restore e outras funcionalidades do PostgreSQL.

---

## 👨🏻‍💻 Autor

**João Pires**

Desenvolvedor Fullstack

[GitHub](https://github.com/devjoaopires)
