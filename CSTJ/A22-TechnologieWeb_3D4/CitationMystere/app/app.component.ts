//----------------------------------------
//  Fichier : app.component.ts
//  Développeur: Olivier Bourgault
//  Date: 2022-10-06
//-----------------------------------------

import { Component } from '@angular/core';

@Component({
  selector: 'app-root',
  templateUrl: './app.component.html',
  styleUrls: ['./app.component.css']
})
export class AppComponent {
  title = 'tp1'; //Initialise le nom de l'application
  citationSaisie:string = ''; //Déclare la chaîne saisie par l'utilisateur comme une chaîne vide

  //--------------------------------------------
  //Fonction qui est appelée seulement lorsque la citation de l'utilisateur est coonforme aux critères
  //--------------------------------------------
  onCitationValide(citation:string) {
    this.citationSaisie = citation; //Conserve la saisie de l'utilisateur en mémoire
  }
}
