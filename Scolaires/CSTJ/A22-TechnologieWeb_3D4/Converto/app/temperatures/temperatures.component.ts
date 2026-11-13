//----------------------------------------
//  Fichier : temperatures.component.ts
//  Développeur: Olivier Bourgault
//  Date: 2022-11-07
//-----------------------------------------

import { Component, OnInit } from '@angular/core';
import { convertir } from './conversion';
import { majPrecision } from '../outils';

@Component({
  selector: 'app-temperatures',
  templateUrl: './temperatures.component.html',
  styleUrls: ['./temperatures.component.css']
})
export class TemperaturesComponent implements OnInit {
  //On déclare et on initialise quelques variables locales pour l'affichage de base
  titre = "températures";
  uniteEntree: string = "Celsius";
  uniteSortie: string = "Fahranheit";
  nbPrecisions: number = 2;
  valeurEntree: number = 20;
  valeurSortie: any = 68.00;

  constructor() { }

  //--------------------------------------------
  //C'est la fonction qui sera appelée lors de l'affichage du domaine de températures
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