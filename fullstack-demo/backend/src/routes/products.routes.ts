import { Router, type NextFunction, type Request, type Response } from 'express';
import { pool } from '../db.js';

type ProductRow = {
  id: string;
  sku: string;
  nome: string;
  preco: string;
  estoque_atual: string;
  categoria: string | null;
};

export const productsRouter = Router();

productsRouter.get('/', async (req: Request, res: Response, next: NextFunction) => {
  try {
    const search = String(req.query.q || '').trim();
    const requestedLimit = Number(req.query.limit || 20);
    const limit = Math.min(
      Math.max(Number.isFinite(requestedLimit) ? requestedLimit : 20, 1),
      100
    );

    const result = await pool.query<ProductRow>(
      `SELECT
          p.id,
          p.sku,
          p.nome,
          p.preco,
          p.estoque_atual,
          c.nome AS categoria
       FROM lab.produtos AS p
       LEFT JOIN lab.categorias AS c
         ON c.id = p.categoria_id
       WHERE p.ativo = TRUE
         AND ($1 = '' OR p.nome ILIKE '%' || $1 || '%' OR p.sku ILIKE '%' || $1 || '%')
       ORDER BY p.nome
       LIMIT $2`,
      [search, limit]
    );

    res.json(result.rows);
  } catch (error) {
    next(error);
  }
});
