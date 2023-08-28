//----------------------------------------
//  Fichier : dimensions.component.ts
//  Développeur: Olivier Bourgault
//  Date: 2022-11-07
//-----------------------------------------

import { Component, OnInit } from '@angular/core';
import { majPrecision } from './../outils';
import { convertir1D, convertir2D, convertir3D } from './conversion';

@Component({
  selector: 'app-dimensions',
  templateUrl: './dimensions.component.html',
  styleUrls: ['./dimensions.component.css']

})
export class DimensionsComponent implements OnInit {
  //On déclare et on initialise quelques variables locales pour l'affichage de base
  titre = "dimensions";
  uniteEntree: string = "m";
  uniteSortie: string = "pouce";
  nbDimensions: number = 1;
  nbPrecisions: number = 2;
  
  valeurEntree1: any = 1;
  valeurEntree2: any = 1;
  valeurEntree3: any = 1;
  valeurEntree_2: any = 1;
  valeurEntree_3: any = 1;

  valeurSortie1: any = 39.37;
  valeurSortie2: any = 39.37;
  valeurSortie3: any = 39.37;
  valeurSortie_2: any = 39.37;
  valeurSortie_3: any = 39.37;
  
  constructor() { }

  //--------------------------------------------
  //C'est la fonction qui sera appelée lors de l'affichage du domaine de dimensions
  //--------------------------------------------
  ngOnInit(): void {
    this.majResultat();
  }

  //--------------------------------------------
  //Fonction qui prend la valeur initiale en paramètre, affiche la conversion de cette valeur avec la précision sélectrionnée par l'utilisateur et elle sera appelée à chaque modification de valeur
  //--------------------------------------------
  majResultat() {
    //Calcul du résultat de la première dimension
    this.valeurSortie1 = convertir1D(this.uniteEntree, this.uniteSortie, this.valeurEntree1);
    this.valeurSortie1 = majPrecision(this.valeurSortie1, this.nbPrecisions);

    //Calcul du résultat de la deuxième dimension
    this.valeurSortie2 = convertir1D(this.uniteEntree, this.uniteSortie, this.valeurEntree2);
    this.valeurSortie2 = majPrecision(this.valeurSortie2, this.nbPrecisions);

    this.valeurEntree_2 = this.valeurEntree1 * this.valeurEntree2;
    this.valeurEntree_2 = majPrecision(this.valeurEntree_2, this.nbPrecisions);

    this.valeurSortie_2 = convertir2D(this.uniteEntree, this.uniteSortie, this.valeurEntree_2);
    this.valeurSortie_2 = majPrecision(this.valeurSortie_2, this.nbPrecisions);
    
    //Calcul du résultat de la troisième dimension
    this.valeurSortie3 = convertir1D(this.uniteEntree, this.uniteSortie, this.valeurEntree3);
    this.valeurSortie3 = majPrecision(this.valeurSortie3, this.nbPrecisions);
    
    this.valeurEntree_3 = (this.valeurEntree1 * this.valeurEntree2) * this.valeurEntree3;
    this.valeurEntree_3 = majPrecision(this.valeurEntree_3, this.nbPrecisions);

    this.valeurSortie_3 = convertir3D(this.uniteEntree, this.uniteSortie, this.valeurEntree_3);
    this.valeurSortie_3 = majPrecision(this.valeurSortie_3, this.nbPrecisions);
  }
}