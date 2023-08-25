//----------------------------------------
//  Fichier : app.component.ts
//  Développeur: Olivier Bourgault
//  Date: 2022-11-07
//-----------------------------------------

import { Component } from '@angular/core';

@Component({
  selector: 'app-root',
  templateUrl: './app.component.html',
  styleUrls: ['./app.component.css']
})
export class AppComponent {
  dimensionsVisible = true; //Le domaine pour les dimensions doit s'afficher lors du chargement de l'application
  poidsVisible = false;
  temperaturesVisible = false;
  monnaieVisible = false;

  //--------------------------------------------
  //Fonction qui reçoit un nom de domaine en paramètre et va simplement rendre accessible ce demaine pour l'utilisateur
  //--------------------------------------------
  onClickBtns(domaine: string) {
    switch (domaine) {
      //Pour chaque cas, on rend le domaine ciblé visible et on rend les autres invisibles à l'écran
      case "dimensions":
        this.dimensionsVisible = true;
        this.poidsVisible = false;
        this.temperaturesVisible = false;
        this.monnaieVisible = false;
        break;

      case "poids":
        this.dimensionsVisible = false;
        this.poidsVisible = true;
        this.temperaturesVisible = false;
        this.monnaieVisible = false;
        break;

      case "temperatures":
        this.dimensionsVisible = false;
        this.poidsVisible = false;
        this.temperaturesVisible = true;
        this.monnaieVisible = false;
        break;

      case "monnaie":
        this.dimensionsVisible = false;
        this.poidsVisible = false;
        this.temperaturesVisible = false;
        this.monnaieVisible = true;
        break;
    }
  }
}