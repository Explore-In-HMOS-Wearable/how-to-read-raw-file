export interface Product {
  id: number;
  name: string;
  category: string;
  price: number;
  stock: number;
  rating: number;
  tags: string[];
}

export interface ProductsData {
  products: Product[];
}
