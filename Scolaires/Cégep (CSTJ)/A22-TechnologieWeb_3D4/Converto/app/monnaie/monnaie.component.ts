//----------------------------------------
//  Fichier : monnaie.component.ts
//  Développeur: Olivier Bourgault
//  Date: 2022-11-07
//-----------------------------------------

import { Component, OnInit } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { majPrecision } from '../outils';
import { convertir } from './conversion';

@Component({
  selector: 'app-monnaie',
  templateUrl: './monnaie.component.html',
  styleUrls: ['./monnaie.component.css']
})
export class MonnaieComponent implements OnInit {
  //On déclare et on initialise quelques variables locales pour l'affichage de base
  titre = "monnaie";
  anneeEntree: number = 1971;
  anneeSortie: number = 2021;
  nbPrecisions: number = 2;
  valeurEntree: number = 100;
  valeurSortie: any = 709.32;

  //Déclaration d'une variable pour contenir les données que l'on va recevoir du serveur 
  IPCAnnuels: Array<any> = [];

  constructor(private http: HttpClient) { } //Déclarations d'un attribut pour communiquer avec le serveur externe

  //--------------------------------------------
  //C'est la fonction qui sera appelée lors de l'affichage du domaine de conversion de monnaie
  //--------------------------------------------
  ngOnInit(): void {
    //Ces lignes de code vont récupérer des données sur une page web en sabonnant à celle-ci pour ensuite sauvegarder ces données localement
    this.http.get<any>("https://amartel.techinfo-cstj.ca/getIPC.php").subscribe(ipc => {
      this.IPCAnnuels = ipc;
    })

    this.majResultat();
  }

  //--------------------------------------------
  //Fonction qui prend la valeur initiale en paramètre, affiche la conversion de cette valeur avec la précision sélectrionnée par l'utilisateur et elle sera appelée à chaque modification de valeur
  //--------------------------------------------
  majResultat() {
    this.valeurSortie = convertir(this.IPCAnnuels, this.anneeEntree, this.anneeSortie, this.valeurEntree);
    this.valeurSortie = majPrecision(this.valeurSortie, this.nbPrecisions);
  }
}