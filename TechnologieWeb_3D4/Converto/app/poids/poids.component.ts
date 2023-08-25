//----------------------------------------
//  Fichier : poids.component.ts
//  Développeur: Olivier Bourgault
//  Date: 2022-11-07
//-----------------------------------------

import { Component, OnInit } from '@angular/core';
import { convertir } from './conversion';
import { majPrecision } from '../outils';

@Component({
  selector: 'app-poids',
  templateUrl: './poids.component.html',
  styleUrls: ['./poids.component.css']
})
export class PoidsComponent implements OnInit {
  //On déclare et on initialise quelques variables locales pour l'affichage de base
  titre = "poids";
  uniteEntree: string = "kg";
  uniteSortie: string = "livre";
  nbPrecisions: number = 2;
  valeurEntree: number = 1;
  valeurSortie: any = 2.20;

  constructor() { }

  //--------------------------------------------
  //C'est la fonction qui sera appelée lors de l'affichage du domaine de poids
  //--------------------------------------------
  ngOnInit(): void {
    this.majResultat();
  }

  //--------------------------------------------
  //Fonction qui prend la valeur initiale en paramètre, affiche la conversion de cette valeur avec la précision sélectrionnée par l'utilisateur et elle sera appelée à chaque modification de valeur
  //--------------------------------------------
  majResultat() {
    this.valeurSortie = convertir(this.uniteEntree, this.uniteSortie, this.valeurEntree);
    this.valeurSortie = majPrecision(this.valeurSortie, this.nbPrecisions);
  }
}