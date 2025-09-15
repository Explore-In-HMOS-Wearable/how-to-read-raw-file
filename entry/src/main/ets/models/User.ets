export interface User {
  id: number;
  name: string;
  email: string;
  active: boolean;
  role: 'admin' | 'editor' | 'viewer';
}

export interface Users {
  users: Array<User>
}