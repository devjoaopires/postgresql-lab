import 'dotenv/config';
import cors from 'cors';
import express, { type NextFunction, type Request, type Response } from 'express';
import helmet from 'helmet';

import { pool } from './db.js';
import { AppError } from './errors.js';
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

app.get('/health', async (_req: Request, res: Response, next: NextFunction) => {
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

app.use(
  (error: unknown, _req: Request, res: Response, _next: NextFunction) => {
    console.error(error);

    if (error instanceof AppError) {
      res.status(error.status).json({ error: error.message });
      return;
    }

    res.status(500).json({ error: 'Erro interno do servidor' });
  }
);
