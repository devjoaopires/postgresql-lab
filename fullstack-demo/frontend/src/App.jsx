import { useEffect, useState } from 'react';
import { createCustomer, getProducts } from './api.js';

export function App() {
  const [products, setProducts] = useState([]);
  const [search, setSearch] = useState('');
  const [message, setMessage] = useState('');
  const [customer, setCustomer] = useState({
    nome: '',
    email: '',
    documento: ''
  });

  async function loadProducts(term = '') {
    try {
      setProducts(await getProducts(term));
    } catch (error) {
      setMessage(error.message);
    }
  }

  useEffect(() => {
    loadProducts();
  }, []);

  async function submitCustomer(event) {
    event.preventDefault();

    try {
      const created = await createCustomer(customer);
      setMessage(`Cliente ${created.nome} criado com ID ${created.id}.`);
      setCustomer({ nome: '', email: '', documento: '' });
    } catch (error) {
      setMessage(error.message);
    }
  }

  return (
    <main className="container">
      <header>
        <span className="eyebrow">React + Node.js + PostgreSQL</span>
        <h1>PostgreSQL Lab Fullstack</h1>
        <p>
          Interface simples consumindo uma API Express conectada ao schema
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
            loadProducts(search);
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

        <form className="form" onSubmit={submitCustomer}>
          <input
            required
            value={customer.nome}
            onChange={(event) =>
              setCustomer({ ...customer, nome: event.target.value })
            }
            placeholder="Nome"
          />
          <input
            required
            type="email"
            value={customer.email}
            onChange={(event) =>
              setCustomer({ ...customer, email: event.target.value })
            }
            placeholder="E-mail"
          />
          <input
            value={customer.documento}
            onChange={(event) =>
              setCustomer({ ...customer, documento: event.target.value })
            }
            placeholder="Documento fictício"
          />
          <button type="submit">Cadastrar</button>
        </form>
      </section>
    </main>
  );
}
