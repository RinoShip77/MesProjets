import { ApplicationConfig, importProvidersFrom } from '@angular/core';
import { provideRouter, withComponentInputBinding } from '@angular/router';
import { routes } from './app.routes';
import { initializeApp, provideFirebaseApp } from '@angular/fire/app';
import { getFirestore, provideFirestore } from '@angular/fire/firestore';
import { getAuth, provideAuth } from '@angular/fire/auth';

const firebaseConfig = {
  apiKey: "AIzaSyD4DWFPvJRnjmDf6oYx_8Sy1_uI7CbBH4s",
  authDomain: "nexus-bc8e9.firebaseapp.com",
  projectId: "nexus-bc8e9",
  storageBucket: "nexus-bc8e9.firebasestorage.app",
  messagingSenderId: "137949376821",
  appId: "1:137949376821:web:39778420df7e5202f8dc7c",
  measurementId: "G-KD80V9R9MG"
};

export const appConfig: ApplicationConfig = {
  providers: [
    provideRouter(routes, withComponentInputBinding()),

    // FIX: No 'importProvidersFrom' wrapper. Just call the function directly.
    provideFirebaseApp(() => initializeApp(firebaseConfig)),

    // Add Authentication
    provideAuth(() => getAuth()),
    
    // FIX: Same here. Direct call.
    provideFirestore(() => getFirestore())
  ]
};