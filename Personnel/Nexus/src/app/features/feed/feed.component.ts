import { Component, OnInit, inject } from '@angular/core';
import { CommonModule } from '@angular/common';
import { Router, RouterOutlet, RouterModule } from '@angular/router'; // Added RouterModule
import { FormsModule } from '@angular/forms'; // <--- ADDED: Needed for [(ngModel)]
import { PostService } from '../../core/services/post.service';
import { Post } from '../../post.model';
import { Observable } from 'rxjs';
import { PostCardComponent } from '../../shared/post-card/post-card.component';
import { AuthService } from '../../core/services/auth.service';
import { take } from 'rxjs/operators';

@Component({
  selector: 'app-feed',
  standalone: true,
  imports: [CommonModule, PostCardComponent, RouterOutlet, FormsModule, RouterModule], // <--- Added Modules here
  templateUrl: './feed.component.html',
  styleUrl: './feed.component.scss'
})
export class FeedComponent implements OnInit {
  private postService = inject(PostService);
  private router = inject(Router);
  public auth = inject(AuthService);
  
  user$ = this.auth.user$;
  posts$!: Observable<Post[]>;
  
  selectedFile: File | null = null;
  content: string = ''; // <--- ADDED: To track what you type

  ngOnInit(): void {
    this.posts$ = this.postService.posts$;
  }

  onFileSelected(event: any) {
    const file = event.target.files[0];
    if (file) {
      if (file.size > 500000) {
        alert('Image too large! Please use one under 500KB.');
        return;
      }
      this.selectedFile = file;
    }
  }

  // Updated to use 'this.content'
  async onPost() {
    if (!this.content.trim() && !this.selectedFile) return;

    this.user$.pipe(take(1)).subscribe(async (user) => {
      if (user) {
        if (this.selectedFile) {
          await this.postService.addPostWithImage(this.content, user, this.selectedFile);
        } else {
          await this.postService.addPost(this.content, user);
        }
        
        // Reset everything
        this.selectedFile = null;
        this.content = ''; // Clear the input
      } else {
        alert('You must be logged in to post!');
      }
    });
  }

  get isModalOpen(): boolean {
    return this.router.url.includes('/post/');
  }

  closeModal(event: MouseEvent) {
    this.router.navigate(['/']);
  }
}