const API_URL = import.meta.env.VITE_API_URL || 'http://localhost:3001';

export type Product = {
  id: string;
  sku: string;
  nome: string;
  preco: string;
  estoque_atual: string;
  categoria: string | null;
};

export type CustomerInput = {
  nome: string;
  email: string;
  documento: string;
};

export type Customer = {
  id: string;
  nome: string;
  email: string;
  documento: string | null;
  ativo: boolean;
  criado_em: string;
};

async function request<T>(path: string, options: RequestInit = {}): Promise<T> {
  const response = await fetch(`${API_URL}${path}`, {
    ...options,
    headers: {
      'Content-Type': 'application/json',
      ...options.headers
    }
  });

  const data = (await response.json()) as T & { error?: string };

  if (!response.ok) {
    throw new Error(data.error || 'Falha na requisição');
  }

  return data;
}

export function getProducts(search = ''): Promise<Product[]> {
  return request<Product[]>(`/api/products?q=${encodeURIComponent(search)}`);
}

export function createCustomer(customer: CustomerInput): Promise<Customer> {
  return request<Customer>('/api/customers', {
    method: 'POST',
    body: JSON.stringify(customer)
  });
}
