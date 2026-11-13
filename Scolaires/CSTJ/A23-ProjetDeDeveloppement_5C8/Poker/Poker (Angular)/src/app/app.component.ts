import { Component } from '@angular/core';
import { Joueur } from './modele/joueur';

@Component({
  selector: 'app-root',
  templateUrl: './app.component.html',
  styleUrls: ['./app.component.css'],
})
export class AppComponent {
  title = 'Poker420';
  logonOK = false;

  //--------------------------------
  //
  //--------------------------------
  onConnexionReussie(j: Joueur) {
    this.logonOK = true;
  }

  //--------------------------------
  //
  //--------------------------------
  onQuitterAccueil(j: Joueur) {
    this.logonOK = false;
  }
}