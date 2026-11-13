import { Component } from '@angular/core';
import { RouterOutlet } from '@angular/router';
import { NavbarComponent } from "./shared/navbar/navbar.component";

@Component({
  selector: 'app-root',
  standalone: true,
  imports: [RouterOutlet, NavbarComponent], // Add FeedComponent here
  templateUrl: './app.component.html',    // Updated name
  styleUrl: './app.component.scss'        // Updated name
})
export class AppComponent {
  title = 'Nexus';
}