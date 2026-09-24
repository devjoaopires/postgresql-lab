# 🌐 Fullstack Demo

Demonstração de integração entre **React + TypeScript**, **Node.js/Express + TypeScript** e **PostgreSQL** usando o mesmo schema fictício do laboratório.

## Stack

- TypeScript
- React + Vite
- Node.js
- Express
- PostgreSQL
- `pg` (node-postgres)
- Helmet
- CORS

## O que este exemplo demonstra

- TypeScript em frontend e backend
- Tipagem das respostas da API e payloads
- Pool de conexões PostgreSQL
- Queries parametrizadas com `$1`, `$2`, etc.
- API REST
- tratamento de erros de constraint
- pesquisa com `ILIKE`
- frontend React consumindo a API
- transação de venda com `BEGIN`, `COMMIT` e `ROLLBACK`
- lock pessimista com `SELECT ... FOR UPDATE`
- atualização de estoque dentro da mesma transação
- variáveis de ambiente via arquivos `.env` não versionados

## 1. Banco

Na raiz do repositório:

```bash
createdb postgresql_lab
psql -d postgresql_lab -f setup.sql
```

## 2. Backend

```bash
cd fullstack-demo/backend
cp .env.example .env
npm install
npm run typecheck
npm run dev
```

API: `http://localhost:3001`

Para gerar JavaScript compilado em `dist/`:

```bash
npm run build
npm start
```

Endpoints:

```text
GET  /health
GET  /api/products?q=mouse
POST /api/customers
POST /api/sales
```

Exemplo de venda:

```json
{
  "clienteId": 1,
  "formaPagamento": "PIX",
  "itens": [
    {
      "produtoId": 3,
      "quantidade": 1
    }
  ]
}
```

## 3. Frontend

Em outro terminal:

```bash
cd fullstack-demo/frontend
cp .env.example .env
npm install
npm run typecheck
npm run dev
```

Frontend: `http://localhost:5173`

Para gerar o build de produção:

```bash
npm run build
```

> Todo o projeto usa somente dados fictícios.
