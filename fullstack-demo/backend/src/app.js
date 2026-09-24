import 'dotenv/config';
import cors from 'cors';
import express from 'express';
import helmet from 'helmet';

import { pool } from './db.js';
import { customersRouter } from './routes/customers.routes.js';
import { productsRouter } from './routes/products.routes.js';
import { salesRouter } from './routes/sales.routes.js';

export const app = express();

app.use(helmet());
app.use(
  cors({
    origin: process.env.FRONTEND_ORIGIN || 'http://localhost:5173'
  })
);
app.use(express.json({ limit: '1mb' }));

app.get('/health', async (_req, res, next) => {
  try {
    await pool.query('SELECT 1');
    res.json({ ok: true, database: 'connected' });
  } catch (error) {
    next(error);
  }
});

app.use('/api/products', productsRouter);
app.use('/api/customers', customersRouter);
app.use('/api/sales', salesRouter);

app.use((error, _req, res, _next) => {
  console.error(error);
  res.status(error.status || 500).json({
    error: error.status ? error.message : 'Erro interno do servidor'
  });
});
