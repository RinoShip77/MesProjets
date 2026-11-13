import { NgModule } from '@angular/core';
import { FormsModule } from '@angular/forms';
import { BrowserModule } from '@angular/platform-browser';

import { AppComponent } from './app.component';
import { SaisieComponent } from './saisie/saisie.component';
import { GrilleComponent } from './grille/grille.component';

@NgModule({
  declarations: [
    AppComponent,
    SaisieComponent,
    GrilleComponent
  ],
  imports: [
    BrowserModule,
    FormsModule
  ],
  providers: [],
  bootstrap: [AppComponent]
})
export class AppModule { }
