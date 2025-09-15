export interface Post {
  id: number;
  title: string;
  author: string;
  published: boolean;
  publishedAt: string | null; // null if not published yet
  tags: string[];
  views: number;
}

export interface PostsData {
  posts: Post[];
}
