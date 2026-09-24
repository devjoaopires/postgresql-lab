import { Router } from 'express';
import { pool } from '../db.js';

export const customersRouter = Router();

customersRouter.post('/', async (req, res, next) => {
  try {
    const { nome, email, documento = null } = req.body;

    if (!nome || !email) {
      return res.status(400).json({ error: 'nome e email são obrigatórios' });
    }

    const result = await pool.query(
      `INSERT INTO lab.clientes (nome, email, documento)
       VALUES ($1, $2, $3)
       RETURNING id, nome, email, documento, ativo, criado_em`,
      [String(nome).trim(), String(email).trim().toLowerCase(), documento]
    );

    res.status(201).json(result.rows[0]);
  } catch (error) {
    if (error.code === '23505') {
      return res.status(409).json({ error: 'email ou documento já cadastrado' });
    }

    next(error);
  }
});
