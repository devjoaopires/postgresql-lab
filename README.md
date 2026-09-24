# 🐘 PostgreSQL Lab

Laboratório prático dedicado ao estudo e à aplicação de **PostgreSQL**, com foco em modelagem relacional, SQL, integridade de dados, transações, performance e integração Fullstack com **TypeScript**.

Este repositório utiliza apenas **dados fictícios** e foi criado para demonstrar, por meio de código executável, conhecimentos aplicáveis a sistemas reais.

---

## 🎯 Objetivo

Demonstrar de forma prática conceitos usados no desenvolvimento de aplicações que trabalham com bancos de dados relacionais, desde a criação do schema até análise de planos de execução, otimização de consultas e integração com uma aplicação web tipada.

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
- Prepared Statements e queries parametrizadas
- `EXPLAIN` e `EXPLAIN ANALYZE`
- Análise de buffers e planos de execução
- API REST com Node.js, Express e TypeScript
- Pool de conexões com `pg`
- Transações PostgreSQL controladas pelo backend
- React + TypeScript consumindo a API
- Tipagem de payloads e respostas
- Boas práticas de configuração com variáveis de ambiente

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
├── fullstack-demo/
│   ├── backend/
│   │   ├── src/
│   │   │   ├── routes/
│   │   │   ├── services/
│   │   │   ├── app.ts
│   │   │   ├── db.ts
│   │   │   ├── errors.ts
│   │   │   └── server.ts
│   │   ├── .env.example
│   │   ├── tsconfig.json
│   │   └── package.json
│   │
│   ├── frontend/
│   │   ├── src/
│   │   │   ├── App.tsx
│   │   │   ├── api.ts
│   │   │   ├── main.tsx
│   │   │   └── styles.css
│   │   ├── .env.example
│   │   ├── index.html
│   │   ├── tsconfig.json
│   │   ├── package.json
│   │   └── vite.config.ts
│   │
│   └── README.md
│
├── setup.sql
├── .gitignore
└── README.md
```

---

## 🗃️ Banco de exemplo

O laboratório simula um pequeno sistema comercial com clientes, categorias, produtos, vendas, itens de venda, pagamentos e movimentações de estoque.

O dataset em `examples/ecommerce.sql` é totalmente fictício.

---

## 🚀 Executando o banco

Tenha o PostgreSQL e o cliente `psql` instalados.

```bash
createdb postgresql_lab
psql -d postgresql_lab -f setup.sql
```

O `setup.sql` cria tabelas, constraints, foreign keys, índices, functions, triggers e carrega o dataset fictício.

---

## 🌐 Fullstack Demo

A pasta `fullstack-demo/` conecta o PostgreSQL a uma aplicação web tipada de ponta a ponta.

### Backend

**Node.js + Express + TypeScript + pg**

Demonstra pool de conexões, queries parametrizadas, API REST, tratamento de constraints, `ILIKE`, `BEGIN`, `COMMIT`, `ROLLBACK`, `SELECT ... FOR UPDATE`, atualização de estoque transacional e health check do banco.

### Frontend

**React + TypeScript + Vite**

A interface consulta produtos, pesquisa por nome/SKU, renderiza dados vindos do PostgreSQL e cadastra clientes pela API com tipos compartilhados no cliente.

Instruções completas estão em `fullstack-demo/README.md`.

---

## ⚡ Performance

O laboratório inclui exemplos com `EXPLAIN (ANALYZE, BUFFERS)` para comparar estimativas do planner com a execução real.

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

---

## 🔐 Segurança e privacidade

Este projeto não utiliza credenciais, dumps ou informações de produção.

O `.gitignore` bloqueia arquivos comuns que podem conter informações sensíveis, enquanto os arquivos `.env.example` contêm apenas valores genéricos para desenvolvimento local.

---

## 🛠️ Tecnologias

<p>
  <img alt="PostgreSQL" title="PostgreSQL" width="42px" src="https://cdn.jsdelivr.net/gh/devicons/devicon@latest/icons/postgresql/postgresql-original.svg" />&nbsp;
  <img alt="TypeScript" title="TypeScript" width="42px" src="https://cdn.jsdelivr.net/gh/devicons/devicon@latest/icons/typescript/typescript-original.svg" />&nbsp;
  <img alt="Node.js" title="Node.js" width="42px" src="https://cdn.jsdelivr.net/gh/devicons/devicon@latest/icons/nodejs/nodejs-original.svg" />&nbsp;
  <img alt="Express" title="Express" width="42px" src="https://cdn.jsdelivr.net/gh/devicons/devicon@latest/icons/express/express-original.svg" />&nbsp;
  <img alt="React" title="React" width="42px" src="https://cdn.jsdelivr.net/gh/devicons/devicon@latest/icons/react/react-original.svg" />&nbsp;
  <img alt="Vite" title="Vite" width="42px" src="https://cdn.jsdelivr.net/gh/devicons/devicon@latest/icons/vitejs/vitejs-original.svg" />
</p>

**PostgreSQL · SQL · PL/pgSQL · TypeScript · Node.js · Express · React · Vite**

---

## 📈 Evolução do laboratório

O repositório pode continuar evoluindo com migrations, isolamento de transações, JSONB, full-text search, procedures, particionamento, testes automatizados e autenticação.

---

## 👨🏻‍💻 Autor

**João Pires**

Desenvolvedor Fullstack

[GitHub](https://github.com/devjoaopires)
