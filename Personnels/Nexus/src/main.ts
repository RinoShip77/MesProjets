import { bootstrapApplication } from '@angular/platform-browser';
import { appConfig } from './app/app.config';
import { AppComponent } from './app/app.component'; // Make sure this points to .component

bootstrapApplication(AppComponent, appConfig)
  .catch((err) => console.error(err));