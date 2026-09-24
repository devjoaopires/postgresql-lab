import { Router, type NextFunction, type Request, type Response } from 'express';
import { pool } from '../db.js';

type CustomerBody = {
  nome?: string;
  email?: string;
  documento?: string | null;
};

type PgError = Error & {
  code?: string;
};

export const customersRouter = Router();

customersRouter.post(
  '/',
  async (
    req: Request<Record<string, never>, unknown, CustomerBody>,
    res: Response,
    next: NextFunction
  ) => {
    try {
      const { nome, email, documento = null } = req.body;

      if (!nome || !email) {
        res.status(400).json({ error: 'nome e email são obrigatórios' });
        return;
      }

      const result = await pool.query(
        `INSERT INTO lab.clientes (nome, email, documento)
         VALUES ($1, $2, $3)
         RETURNING id, nome, email, documento, ativo, criado_em`,
        [nome.trim(), email.trim().toLowerCase(), documento]
      );

      res.status(201).json(result.rows[0]);
    } catch (error) {
      const pgError = error as PgError;

      if (pgError.code === '23505') {
        res.status(409).json({ error: 'email ou documento já cadastrado' });
        return;
      }

      next(error);
    }
  }
);
