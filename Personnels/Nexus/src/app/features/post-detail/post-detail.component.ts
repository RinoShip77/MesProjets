import { Component, OnInit, inject } from '@angular/core';
import { CommonModule } from '@angular/common';
import { ActivatedRoute } from '@angular/router';
import { PostService } from '../../core/services/post.service';
import { Post } from '../../post.model';
import { PostCardComponent } from '../../shared/post-card/post-card.component'; // Reuse the card!
import { Observable } from "rxjs";
import { switchMap } from 'rxjs/operators'; // Optional, but good practice
import { of } from 'rxjs';

@Component({
  selector: 'app-post-detail',
  standalone: true,
  imports: [CommonModule, PostCardComponent],
  templateUrl: './post-detail.component.html',
  styleUrl: './post-detail.component.scss'
})
export class PostDetailComponent implements OnInit {
  private route = inject(ActivatedRoute);
  private postService = inject(PostService);
  
  // CHANGED: Now it's an Observable Stream
  post$!: Observable<Post | undefined>;

  ngOnInit(): void {
    const id = this.route.snapshot.paramMap.get('id');
    
    if (id) {
      this.post$ = this.postService.getPost(id);
    } else {
      // Safety net if no ID found
      console.error('No ID in URL');
    }
  }
}