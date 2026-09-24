const API_URL = import.meta.env.VITE_API_URL || 'http://localhost:3001';

async function request(path, options = {}) {
  const response = await fetch(`${API_URL}${path}`, {
    headers: {
      'Content-Type': 'application/json',
      ...options.headers
    },
    ...options
  });

  const data = await response.json();

  if (!response.ok) {
    throw new Error(data.error || 'Falha na requisição');
  }

  return data;
}

export function getProducts(search = '') {
  return request(`/api/products?q=${encodeURIComponent(search)}`);
}

export function createCustomer(customer) {
  return request('/api/customers', {
    method: 'POST',
    body: JSON.stringify(customer)
  });
}
