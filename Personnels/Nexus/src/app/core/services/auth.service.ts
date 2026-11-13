import { Injectable, inject } from '@angular/core';
import {
  Auth,
  GoogleAuthProvider,
  signInWithPopup,
  signOut,
  user,
  createUserWithEmailAndPassword, // <--- NEW
  signInWithEmailAndPassword,     // <--- NEW
  updateProfile                   // <--- NEW (To save their name)
} from '@angular/fire/auth';
import { Observable } from 'rxjs';
import { Firestore, doc, setDoc, docData, getDoc } from '@angular/fire/firestore';

@Injectable({
  providedIn: 'root'
})
export class AuthService {
  private auth = inject(Auth);
  private firestore = inject(Firestore);

  user$ = user(this.auth);

  // 1. LOGIN WITH EMAIL
  async loginWithEmail(email: string, pass: string) {
    const credential = await signInWithEmailAndPassword(this.auth, email, pass);
    this.updateUserInFirestore(credential.user);
  }

  // 2. REGISTER WITH EMAIL
  async registerWithEmail(email: string, pass: string, name: string) {
    const credential = await createUserWithEmailAndPassword(this.auth, email, pass);

    // Set the display name (Firebase doesn't do this automatically for email)
    if (credential.user) {
      await updateProfile(credential.user, {
        displayName: name,
        photoURL: `https://api.dicebear.com/7.x/initials/svg?seed=${name}` // Generate a random avatar
      });

      this.updateUserInFirestore(credential.user);
    }
  }

  // 3. GOOGLE LOGIN (Existing)
  async loginWithGoogle() {
    const provider = new GoogleAuthProvider();
    const credential = await signInWithPopup(this.auth, provider);
    this.updateUserInFirestore(credential.user);
  }

  async logout() {
    await signOut(this.auth);
  }

  getUserProfile(uid: string): Observable<any> {
    const userRef = doc(this.firestore, 'users', uid);
    return docData(userRef);
  }

  // Helper to save user to database
  private async updateUserInFirestore(user: any) {
    const userRef = doc(this.firestore, 'users', user.uid);
    const userSnap = await getDoc(userRef); // 1. Check if user exists

    const dataToUpdate: any = {
      uid: user.uid,
      email: user.email,
      displayName: user.displayName,
      photoURL: user.photoURL,
      lastSeen: new Date()
    };

    // 2. ONLY set the role if this is a brand new user
    if (!userSnap.exists()) {
      dataToUpdate.role = 'user'; 
    }

    await setDoc(userRef, dataToUpdate, { merge: true });
  }
}