export interface Comment {
  id: string;
  authorName: string;
  content: string;
  timestamp: Date;
}

export interface Post {
  id?: string;
  authorId: string;
  authorName: string;
  authorPhoto?: string; // <--- Add this new field
  content: string;
  imageUrl?: string; // <--- Add this new field for image posts
  timestamp: string; // or Date
  likes: number;       // We keep this for easy display
  likedBy?: string[];  // <--- NEW: List of User IDs who liked it
  comments: Comment[];
  type: 'text' | 'image';
}