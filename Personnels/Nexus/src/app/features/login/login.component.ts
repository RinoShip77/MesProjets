import { Component, inject } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';
import { Router } from '@angular/router';
import { AuthService } from '../../core/services/auth.service';

@Component({
  selector: 'app-login',
  standalone: true,
  imports: [CommonModule, FormsModule],
  templateUrl: './login.component.html',
  styleUrl: './login.component.scss'
})
export class LoginComponent {
  authService = inject(AuthService);
  router = inject(Router);

  isRegistering = false;
  name = '';
  email = '';
  password = '';

  async onSubmit() {
    try {
      if (this.isRegistering) {
        await this.authService.registerWithEmail(this.email, this.password, this.name);
      } else {
        await this.authService.loginWithEmail(this.email, this.password);
      }
      this.router.navigate(['/']); // Go to Feed on success
    } catch (error: any) {
      alert(error.message);
    }
  }

  async onGoogleLogin() {
    try {
      await this.authService.loginWithGoogle();
      this.router.navigate(['/']);
    } catch (error: any) {
      alert(error.message);
    }
  }
}