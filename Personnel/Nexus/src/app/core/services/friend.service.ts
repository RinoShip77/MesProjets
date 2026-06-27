import { Injectable, inject } from '@angular/core';
import { 
  Firestore, 
  doc, 
  setDoc, 
  deleteDoc, 
  collection, 
  collectionData, 
  docData,          // <--- Fixed: Was missing
  writeBatch 
} from '@angular/fire/firestore';
import { Observable } from 'rxjs';
import { map } from 'rxjs/operators'; // <--- Fixed: Was missing

@Injectable({
  providedIn: 'root'
})
export class FriendService {
  private firestore = inject(Firestore);

  // 1. SEND A REQUEST
  async sendFriendRequest(myUid: string, targetUid: string) {
    const targetRef = doc(this.firestore, `users/${targetUid}/friendRequests/${myUid}`);
    await setDoc(targetRef, {
      from: myUid,
      status: 'pending',
      timestamp: new Date()
    });
  }

  // 2. ACCEPT A REQUEST
  async acceptFriendRequest(myUid: string, newFriendUid: string) {
    const batch = writeBatch(this.firestore);

    // A. Add them to YOUR friends list
    const myFriendRef = doc(this.firestore, `users/${myUid}/friends/${newFriendUid}`);
    batch.set(myFriendRef, { since: new Date() });

    // B. Add YOU to THEIR friends list
    const theirFriendRef = doc(this.firestore, `users/${newFriendUid}/friends/${myUid}`);
    batch.set(theirFriendRef, { since: new Date() });

    // C. Delete the request
    const requestRef = doc(this.firestore, `users/${myUid}/friendRequests/${newFriendUid}`);
    batch.delete(requestRef);

    await batch.commit();
  }

  // 3. GET MY REQUESTS
  getMyRequests(myUid: string): Observable<any[]> {
    const ref = collection(this.firestore, `users/${myUid}/friendRequests`);
    return collectionData(ref, { idField: 'id' });
  }

  // 4. CHECK IF ALREADY FRIENDS
  isFriend(myUid: string, targetUid: string): Observable<boolean> {
     const ref = doc(this.firestore, `users/${myUid}/friends/${targetUid}`);
     // Fixed: Added explicit type (val: any) to prevent TypeScript error
     return docData(ref).pipe(map((val: any) => !!val)); 
  }

  // 5. CHECK IF REQUEST IS PENDING (Add this to FriendService)
  hasPendingRequest(myUid: string, targetUid: string): Observable<boolean> {
    const ref = doc(this.firestore, `users/${targetUid}/friendRequests/${myUid}`);
    return docData(ref).pipe(map((val: any) => !!val));
  }
}