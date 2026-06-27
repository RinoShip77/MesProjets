import { Injectable, inject } from '@angular/core';
import { Firestore, query, orderBy, where, collection, collectionData, doc, docData, addDoc, updateDoc, deleteDoc, arrayUnion, arrayRemove, increment } from '@angular/fire/firestore';
import { Observable } from 'rxjs';
import { Post, Comment } from '../../post.model';
import { User } from '@angular/fire/auth'; // <--- Import this

@Injectable({
  providedIn: 'root'
})
export class PostService {
  private firestore = inject(Firestore);

  // This automatically connects to the 'posts' collection in your database
  private postsCollection = collection(this.firestore, 'posts');

  // 1. READ: Get all posts (Live Stream)
  // We sort by 'timestamp' descending so newest is top
  posts$: Observable<Post[]> = collectionData(
    query(this.postsCollection, orderBy('timestamp', 'desc')),
    { idField: 'id' }
  ) as Observable<Post[]>;

  // 2. CREATE: Add a new post with REAL user data
  async addPost(content: string, user: User): Promise<void> {
    const newPost = {
      authorId: user.uid,           // The real unique ID from Google
      authorName: user.displayName || 'Anonymous', // Real Name
      authorPhoto: user.photoURL || '', // Real Photo
      content: content,
      timestamp: new Date().toISOString(),
      likes: 0,
      comments: [],
      type: 'text'
    };

    await addDoc(this.postsCollection, newPost);
  }

  // 3. Toggle Like (Heart/Unheart)
  async toggleLike(postId: string, userId: string, isCurrentlyLiked: boolean): Promise<void> {
    const postRef = doc(this.firestore, 'posts', postId);

    if (isCurrentlyLiked) {
      // A. UN-LIKE: Remove user from array, decrease count
      await updateDoc(postRef, {
        likes: increment(-1),
        likedBy: arrayRemove(userId)
      });
    } else {
      // B. LIKE: Add user to array, increase count
      await updateDoc(postRef, {
        likes: increment(1),
        likedBy: arrayUnion(userId)
      });
    }
  }

  // 4. UPDATE: Add a comment with a Real Name
  async addComment(postId: string, content: string, userName: string): Promise<void> {
    const postRef = doc(this.firestore, 'posts', postId);
    const newComment: Comment = {
      id: Math.random().toString(36).substring(7),
      authorName: userName, // <--- This was hardcoded 'Johnny' before
      content: content,
      timestamp: new Date()
    };
    await updateDoc(postRef, { comments: arrayUnion(newComment) });
  }

  // 5. GET ONE (Helper for the Detail Page if needed)
  getPost(id: string): Observable<Post | undefined> {
    const postRef = doc(this.firestore, 'posts', id);
    // 'docData' is the function that streams the single document
    return docData(postRef, { idField: 'id' }) as Observable<Post>;
  }

  // 6. DELETE: Remove a post
  async deletePost(postId: string): Promise<void> {
    const postRef = doc(this.firestore, 'posts', postId);
    await deleteDoc(postRef);
  }

  // 7. NEW: Add Post with Image (Base64 Method - No Credit Card required)
  async addPostWithImage(content: string, user: any, file: File): Promise<void> {
    // 1. Convert File to Text String (Base64)
    const reader = new FileReader();

    // We wrap this in a "Promise" to wait for the conversion to finish
    const imageUrl = await new Promise<string>((resolve, reject) => {
      reader.onload = (e: any) => resolve(e.target.result);
      reader.onerror = (e) => reject(e);
      reader.readAsDataURL(file); // Start reading
    });

    // 2. Save to Firestore (Image is now just a long string)
    const newPost = {
      authorId: user.uid,
      authorName: user.displayName || 'Anonymous',
      authorPhoto: user.photoURL || '',
      content: content,
      imageUrl: imageUrl, // <--- The image text
      timestamp: new Date().toISOString(),
      likes: 0,
      comments: [],
      type: 'image'
    };

    await addDoc(this.postsCollection, newPost);
  }

  // 9. GET PROFILE POSTS: Get posts by a specific user
  getPostsByUser(userId: string): Observable<Post[]> {
    const q = query(
      this.postsCollection,
      where('authorId', '==', userId), // <--- The Filter
      orderBy('timestamp', 'desc')
    );
    return collectionData(q, { idField: 'id' }) as Observable<Post[]>;
  }
}