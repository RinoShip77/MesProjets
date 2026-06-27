import { Injectable } from '@angular/core';
import { BehaviorSubject } from 'rxjs';

@Injectable({
  providedIn: 'root'
})
export class ThemeService {
  private theme = new BehaviorSubject<'light' | 'dark'>('light');
  theme$ = this.theme.asObservable();

  constructor() {
    // 1. Check if user has a saved preference
    const savedTheme = localStorage.getItem('nexus-theme') as 'light' | 'dark';
    if (savedTheme) {
      this.setTheme(savedTheme);
    } else {
      // Default to Dark if no preference
      this.setTheme('dark'); 
    }
  }

  toggleTheme() {
    const newTheme = this.theme.value === 'light' ? 'dark' : 'light';
    this.setTheme(newTheme);
  }

  private setTheme(theme: 'light' | 'dark') {
    this.theme.next(theme);
    localStorage.setItem('nexus-theme', theme);
    
    // This is the magic line that changes the CSS
    document.documentElement.setAttribute('data-theme', theme);
  }
}