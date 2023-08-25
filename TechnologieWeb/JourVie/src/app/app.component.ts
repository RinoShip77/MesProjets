//------------------------------------------
//   fichier :app.component.ts
//   Dev : Olivier Bourgault
//   Date: 2021-11-21
//   Projet: JourVie
//------------------------------------------

import { Component } from '@angular/core';
import { Developpeur } from './modeles/developpeur';
import { tr } from './outils';

@Component({
  selector: 'app-root',
  templateUrl: './app.component.html',
  styleUrls: ['./app.component.css']
})
export class AppComponent {
  title = 'JourVie';
  modification:boolean = true;
  developpeurConnecte:Developpeur = new Developpeur();

  //----------------------------------
  //
  //----------------------------------

  onConnexionReussie(dev:Developpeur) {
    this.modification = false;

    if (dev.ProjetAssigne_Id != 0)
      this.title = dev.Prenom + " " + dev.Nom + ", " + dev.NomProjet;
    else
      this.title = dev.Prenom + " " + dev.Nom + ": Aucun projet assigné"
    this.developpeurConnecte = dev;
  }

  onConnexionAdmin() {
    this.modification = false;
  }
}
