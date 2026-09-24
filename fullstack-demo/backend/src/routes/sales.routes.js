import { Router } from 'express';
import { createSale } from '../services/sales.service.js';

export const salesRouter = Router();

salesRouter.post('/', async (req, res, next) => {
  try {
    const venda = await createSale({
      clienteId: Number(req.body.clienteId),
      itens: req.body.itens,
      formaPagamento: String(req.body.formaPagamento || 'PIX').toUpperCase()
    });

    res.status(201).json(venda);
  } catch (error) {
    next(error);
  }
});
