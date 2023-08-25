//----------------------------------------------
// fichier: app.component.ts
// Dev: Olivier Bourgault
// Date: 2021-11-08
// Projet: Poker
//----------------------------------------------

import { Component } from '@angular/core'; //On importe le composant du noyau de l'application
import { Carte } from './modeles/carte'; //On importe la classe externe
import { Evaluateur } from './modeles/evaluateur';
import { Joueur } from './modeles/joueur';
import { Paquet } from './modeles/paquet'; //On importe la classe externe
import { Ronde } from './modeles/ronde'; //On importe la classe externe

@Component({
  selector: 'app-root',
  templateUrl: './app.component.html',
  styleUrls: ['./app.component.css']
})
export class AppComponent {
  //Déclaration d'attributs
  enteteVisible:boolean = true;
  tableVisible:boolean = false;
  ronde:Ronde = new Ronde;

  //----------------------------------------------
  //
  //----------------------------------------------

  constructor() { }  

  //----------------------------------------------
  //
  //----------------------------------------------

  demarrer() //Va exécuter une partie
  {
    //Va dissimuler l'entête et afficher la partie
    this.enteteVisible = false;
    this.tableVisible = true;
    console.log(this.ronde.joueurs);

                                    //Appelle trois fonction de la ronde de poker pour assurer:
    this.ronde.distrubuerCartes();  //- La distibution des cartes aux joueurs et des cartes du croupier
    this.ronde.evaluerMains();      //- L'évaluation des mains des joueurs lorsqu'elles sont combinées aux cartes publiques
    this.ronde.determineGagnant();  //- L'indiquation du joueur gangnant selon les valeurs calculées précédemment
  }

  //----------------------------------------------
  //
  //----------------------------------------------

  recommencer() //Si l'utilisateur souhaite rejouer au poker
  {
    window.location.reload(); //Va forcer la page à recharger pour ainsi pouvoir jouer une autre partie
  }
}