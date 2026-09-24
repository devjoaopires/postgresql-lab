import { Router, type NextFunction, type Request, type Response } from 'express';
import { createSale } from '../services/sales.service.js';

type SaleBody = {
  clienteId?: number;
  formaPagamento?: string;
  itens?: Array<{
    produtoId: number;
    quantidade: number;
  }>;
};

export const salesRouter = Router();

salesRouter.post(
  '/',
  async (
    req: Request<Record<string, never>, unknown, SaleBody>,
    res: Response,
    next: NextFunction
  ) => {
    try {
      const venda = await createSale({
        clienteId: Number(req.body.clienteId),
        itens: req.body.itens ?? [],
        formaPagamento: String(req.body.formaPagamento || 'PIX').toUpperCase()
      });

      res.status(201).json(venda);
    } catch (error) {
      next(error);
    }
  }
);
