import { type FormEvent, useEffect, useState } from 'react';

import {
  createCustomer,
  getProducts,
  type CustomerInput,
  type Product
} from './api';

const emptyCustomer: CustomerInput = {
  nome: '',
  email: '',
  documento: ''
};

export function App() {
  const [products, setProducts] = useState<Product[]>([]);
  const [search, setSearch] = useState('');
  const [message, setMessage] = useState('');
  const [customer, setCustomer] = useState<CustomerInput>(emptyCustomer);

  async function loadProducts(term = ''): Promise<void> {
    try {
      setMessage('');
      setProducts(await getProducts(term));
    } catch (error) {
      setMessage(error instanceof Error ? error.message : 'Erro ao buscar produtos');
    }
  }

  useEffect(() => {
    void loadProducts();
  }, []);

  async function submitCustomer(event: FormEvent<HTMLFormElement>): Promise<void> {
    event.preventDefault();

    try {
      const created = await createCustomer(customer);
      setMessage(`Cliente ${created.nome} criado com ID ${created.id}.`);
      setCustomer(emptyCustomer);
    } catch (error) {
      setMessage(error instanceof Error ? error.message : 'Erro ao cadastrar cliente');
    }
  }

  return (
    <main className="container">
      <header>
        <span className="eyebrow">React + TypeScript + Node.js + PostgreSQL</span>
        <h1>PostgreSQL Lab Fullstack</h1>
        <p>
          Interface tipada consumindo uma API Express conectada ao schema
          <code> lab</code>.
        </p>
      </header>

      {message && <div className="message">{message}</div>}

      <section className="card">
        <h2>Produtos</h2>

        <form
          className="search"
          onSubmit={(event) => {
            event.preventDefault();
            void loadProducts(search);
          }}
        >
          <input
            value={search}
            onChange={(event) => setSearch(event.target.value)}
            placeholder="Buscar por nome ou SKU"
          />
          <button type="submit">Buscar</button>
        </form>

        <div className="grid">
          {products.map((product) => (
            <article key={product.id} className="product">
              <strong>{product.nome}</strong>
              <span>{product.sku}</span>
              <span>{product.categoria || 'Sem categoria'}</span>
              <span>Estoque: {product.estoque_atual}</span>
              <b>
                {Number(product.preco).toLocaleString('pt-BR', {
                  style: 'currency',
                  currency: 'BRL'
                })}
              </b>
            </article>
          ))}
        </div>
      </section>

      <section className="card">
        <h2>Novo cliente</h2>

        <form className="form" onSubmit={(event) => void submitCustomer(event)}>
          <input
            required
            value={customer.nome}
            onChange={(event) =>
              setCustomer((current) => ({ ...current, nome: event.target.value }))
            }
            placeholder="Nome"
          />
          <input
            required
            type="email"
            value={customer.email}
            onChange={(event) =>
              setCustomer((current) => ({ ...current, email: event.target.value }))
            }
            placeholder="E-mail"
          />
          <input
            value={customer.documento}
            onChange={(event) =>
              setCustomer((current) => ({
                ...current,
                documento: event.target.value
              }))
            }
            placeholder="Documento fictício"
          />
          <button type="submit">Cadastrar</button>
        </form>
      </section>
    </main>
  );
}
