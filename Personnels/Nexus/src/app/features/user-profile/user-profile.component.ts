import { Component, OnInit, inject } from '@angular/core';
import { CommonModule } from '@angular/common';
import { ActivatedRoute } from '@angular/router';
import { PostService } from '../../core/services/post.service';
import { AuthService } from "../../core/services/auth.service";
import { FriendService } from '../../core/services/friend.service'; // <--- NEW IMPORT
import { Post } from '../../post.model';
import { Observable, of } from 'rxjs'; // <--- Added 'of'
import { PostCardComponent } from '../../shared/post-card/post-card.component';

@Component({
  selector: 'app-user-profile',
  standalone: true,
  imports: [CommonModule, PostCardComponent],
  templateUrl: './user-profile.component.html',
  styleUrl: './user-profile.component.scss'
})
export class UserProfileComponent implements OnInit {
  private route = inject(ActivatedRoute);
  private postService = inject(PostService);
  private authService = inject(AuthService);
  private friendService = inject(FriendService); // <--- NEW INJECT

  posts$!: Observable<Post[]>;
  userProfile$!: Observable<any>;

  // Friendship State
  currentUid: string | null = null;
  profileId: string = '';
  isFriend$: Observable<boolean> = of(false);
  requestPending$: Observable<boolean> = of(false);
  requestSent = false;

  ngOnInit() {
    this.route.paramMap.subscribe(params => {
      this.profileId = params.get('id') || '';

      if (this.profileId) {
        // 1. Load Data
        this.posts$ = this.postService.getPostsByUser(this.profileId);
        this.userProfile$ = this.authService.getUserProfile(this.profileId);

        // 2. Check Permissions & Friendship
        this.checkFriendStatus();
      }
    });
  }

  checkFriendStatus() {
    this.authService.user$.subscribe(user => {
      if (user) {
        this.currentUid = user.uid;
        // Only check friendship if we are looking at someone else
        if (this.currentUid !== this.profileId) {
          // 1. Check if we are already friends
          this.isFriend$ = this.friendService.isFriend(this.currentUid, this.profileId);

          // 2. Check if a request is ALREADY pending (Fixes the refresh issue)
          this.requestPending$ = this.friendService.hasPendingRequest(this.currentUid, this.profileId);
        }
      }
    });
  }

  async sendRequest() {
    if (!this.currentUid || !this.profileId) return;
    try {
      await this.friendService.sendFriendRequest(this.currentUid, this.profileId);
      this.requestSent = true;
    } catch (error) {
      console.error(error);
    }
  }
}