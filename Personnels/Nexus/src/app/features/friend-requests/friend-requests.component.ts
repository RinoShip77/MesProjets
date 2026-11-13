import { Component, OnInit, inject } from '@angular/core';
import { CommonModule } from '@angular/common';
import { AuthService } from '../../core/services/auth.service';
import { FriendService } from '../../core/services/friend.service';
import { Observable, switchMap, of, map, combineLatest } from 'rxjs';
import { Firestore, doc, docData } from '@angular/fire/firestore';

@Component({
  selector: 'app-friend-requests',
  standalone: true,
  imports: [CommonModule],
  templateUrl: './friend-requests.component.html',
  styleUrls: ['./friend-requests.component.scss']
})
export class FriendRequestsComponent implements OnInit {
  private auth = inject(AuthService);
  private friendService = inject(FriendService);
  private firestore = inject(Firestore); // Direct inject for quick profile lookup

  requests$!: Observable<any[]>;
  currentUid: string = '';

  ngOnInit() {
    this.requests$ = this.auth.user$.pipe(
      switchMap(user => {
        if (!user) return of([]);
        this.currentUid = user.uid;
        
        // 1. Get the list of request IDs
        return this.friendService.getMyRequests(user.uid).pipe(
          switchMap(requests => {
            if (requests.length === 0) return of([]);

            // 2. For each request, fetch the Sender's Profile Data
            const detailedRequests = requests.map(req => {
              const userRef = doc(this.firestore, `users/${req.id}`);
              return docData(userRef).pipe(
                map(userData => ({ ...req, sender: userData })) // Merge Request + User Data
              );
            });

            // 3. Combine them all into one list
            return combineLatest(detailedRequests);
          })
        );
      })
    );
  }

  async accept(senderId: string) {
    if (!this.currentUid) return;
    try {
      await this.friendService.acceptFriendRequest(this.currentUid, senderId);
      // The list will automatically update because it's an Observable!
    } catch (error) {
      console.error('Error accepting friend:', error);
    }
  }
}