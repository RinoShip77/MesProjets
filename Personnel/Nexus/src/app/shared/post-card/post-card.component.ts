import { Component, Input, OnInit, inject } from '@angular/core';
import { CommonModule } from '@angular/common';
import { RouterLink } from '@angular/router';
import { Post } from '../../post.model'; // Adjust path if needed
import { PostService } from '../../core/services/post.service';
import { AuthService } from '../../core/services/auth.service'; // Import this
import { Observable } from 'rxjs'; // <--- Add Observable
import { map } from 'rxjs/operators';
import { take } from 'rxjs/operators'; 
import { User } from '@angular/fire/auth';

@Component({
  selector: 'app-post-card',
  standalone: true,
  imports: [CommonModule, RouterLink],
  templateUrl: './post-card.component.html',
  styleUrl: './post-card.component.scss'
})
export class PostCardComponent {
  // Receives a single post from the parent (Feed)
  @Input({ required: true }) post!: Post;

  // Local state: Is the comment section open?
  showComments = false;

  private postService = inject(PostService);
  private authService = inject(AuthService);

  // Declare it here, but don't define it yet
  isOwner$!: Observable<boolean>;
  // 1. New Observable to check if I liked it
  isLikedByMe$!: Observable<boolean>;

  ngOnInit() {
    // 1. Define it here, where 'this.post' is guaranteed to exist!
    this.isOwner$ = this.authService.user$.pipe(
      map(user => user?.uid === this.post.authorId)
    );

    // 2. Check if MY distinct ID is inside the 'likedBy' array
    this.isLikedByMe$ = this.authService.user$.pipe(
      map(user => {
        if (!user || !this.post.likedBy) return false;
        return this.post.likedBy.includes(user.uid);
      })
    );
  }

  // 3. New Toggle Function
  async onLike() {
    this.authService.user$.pipe(take(1)).subscribe(async (user) => {
      if (!user) {
        alert('Please log in to like posts.');
        return;
      }
      
      // Check if I already liked it
      const isLiked = this.post.likedBy?.includes(user.uid) || false;
      
      // Send the toggle command
      if (this.post.id) {
        await this.postService.toggleLike(this.post.id, user.uid, isLiked);
      }
    });
  }

  async onComment(content: string) { // Changed to accept string directly
    if (!content.trim()) return;

    this.authService.user$.pipe(take(1)).subscribe(async (user: User | null) => {
      if (user) {
        await this.postService.addComment(
          this.post.id!, 
          content, 
          user.displayName || 'Anonymous'
        );
        // Note: We don't need to clear the input here because 
        // your HTML (commentInput.value='') does it automatically!
      } else {
        alert('Please log in to comment.');
      }
    });
  }

  toggleComments() {
    this.showComments = !this.showComments;
  }

  async onShare() {
    const shareData = {
      title: `Post by ${this.post.authorName}`,
      text: this.post.content,
      url: `${window.location.origin}/post/${this.post.id}`
    };

    try {
      // 1. Try the Native Share API (Mobile standard)
      if (navigator.share) {
        await navigator.share(shareData);
      } else {
        // 2. Fallback: Copy to Clipboard (Desktop standard)
        await navigator.clipboard.writeText(`${shareData.title}\n${shareData.text}`);
        alert('Post copied to clipboard!'); // Simple feedback
      }
    } catch (err) {
      console.error('Error sharing:', err);
    }
  }

  async onDelete() {
    const confirm = window.confirm('Are you sure you want to delete this post?');
    if (confirm && this.post.id) {
      await this.postService.deletePost(this.post.id);
    }
  }
}