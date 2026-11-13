//----------------------------------------
//  Fichier: app.component.ts
//  Développeur: Olivier Bourgault
//  Date: 2022-12-14
//  Projet: Jourvie
//-----------------------------------------

import { Component } from '@angular/core';
import { Developpeur } from './modeles/Developpeur';
import { tr } from './outils';

@Component({
  selector: 'app-root',
  templateUrl: './app.component.html',
  styleUrls: ['./app.component.css']
})
export class AppComponent {
  title = 'jourvie';
  logonOK: boolean = false;
  bgColor: string = "bg-info";
  devConnecte: Developpeur = new Developpeur();

  //-------------------------------------------
  //  Quand un développeur se connecte avec succès
  //-------------------------------------------
  onConnexionReussie(dev: Developpeur) {
    this.logonOK = true;
    this.bgColor = "bg-light";
    this.devConnecte = dev;
  }

  //-------------------------------------------
  // Quand un administrateur se connecte avec succès
  //-------------------------------------------
  onConnexionAdmin() {
    this.bgColor = "bg-light";
  }
}