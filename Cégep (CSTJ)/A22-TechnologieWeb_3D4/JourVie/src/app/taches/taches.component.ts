//----------------------------------------
//  Fichier: taches.component.ts
//  Développeur: Olivier Bourgault
//  Date: 2022-12-14
//  Projet: Jourvie
//-----------------------------------------

import { Component, OnInit, Output, EventEmitter } from '@angular/core';
import { Tache } from './../modeles/Tache';
import { Developpeur } from './../modeles/Developpeur';
import { tr } from '../outils';
import { JvService } from '../jv.service';

@Component({
  selector: 'app-taches',
  templateUrl: './taches.component.html',
  styleUrls: ['./taches.component.css']
})
export class TachesComponent implements OnInit {
  @Output() demarrerSessionTravail: EventEmitter<Tache> = new EventEmitter<Tache>();
  @Output() connexionDevActif: EventEmitter<Developpeur> = new EventEmitter<Developpeur>();
  @Output() ouvrirJournalDeveloppeur: EventEmitter<Developpeur> = new EventEmitter<Developpeur>();
  visible = false;
  ListeTaches: Tache[] = [];
  dev: Developpeur = new Developpeur();

  //-------------------------------------------
  // Déclaration du constructeur de la classe en ajoutant un attribut pour communiquer avec des données externes
  //-------------------------------------------
  constructor(private jvSrv: JvService) { }

  //-------------------------------------------
  // Sera appelé au début de l'exécution
  //-------------------------------------------
  ngOnInit(): void { }

  //-------------------------------------------
  // Quand un développeur se connecte avec succès
  //-------------------------------------------
  onConnexionReussie(dev: Developpeur) {
    this.dev = dev;
    if (dev.Etat == "actif") {
      this.visible = false;
      this.connexionDevActif.emit(dev);
    }
    else {
      this.jvSrv.getTaches(dev.IdProjet).subscribe(tabTaches => {
        this.ListeTaches = tabTaches;
      })
      this.visible = true;
    }
  }

  //-------------------------------------------
  // Va afficher les statistiques du journal
  //-------------------------------------------
  ouvrirStatistiques() {
    tr('Cette fonctionnalité est encore en développement.');
  }

  //-------------------------------------------
  // Va émettre l'événement pour ouvrir le journal
  //-------------------------------------------
  ouvrirJournal() {
    this.visible = false;
    this.ouvrirJournalDeveloppeur.emit(this.dev);
  }

  //-------------------------------------------
  // Va émettre l'événement pour démarrer une session de travail
  //-------------------------------------------
  demarrerSessTrav(tac: Tache) {
    this.visible = false;
    this.demarrerSessionTravail.emit(tac);
  }

  //-------------------------------------------
  // Va afficher les différentes tâches disponibles
  //-------------------------------------------
  onChangementTache(dev: Developpeur) {
    this.dev = dev;
    this.jvSrv.getTaches(dev.IdProjet).subscribe(tabTaches => {
      this.ListeTaches = tabTaches;
    })
    this.visible = true;
  }

  //-------------------------------------------
  //Est appelé lorsqu'on clique pour revenir à l'écran de connexion
  //-------------------------------------------
  retourConnexion() {
    window.location.reload();
  }
}