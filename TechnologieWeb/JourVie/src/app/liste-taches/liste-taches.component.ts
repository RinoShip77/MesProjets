//------------------------------------------
//   fichier : liste-taches.component.ts
//   Dev : Olivier Bourgault
//   Date: 2021-11-21
//   Projet: JourVie
//------------------------------------------

import { Component, OnInit, Output, EventEmitter } from '@angular/core';
import { Tache } from '../modeles/tache';
import { Developpeur } from '../modeles/developpeur';
import { tr } from '../outils';
import { InfoService } from '../info.service';
import { JourvieService } from '../jourvie.service';


@Component({
  selector: 'app-liste-taches',
  templateUrl: './liste-taches.component.html',
  styleUrls: ['./liste-taches.component.css']
})
export class ListeTachesComponent implements OnInit {
  @Output() demarrerSession: EventEmitter<Tache> = new EventEmitter<Tache>();
  @Output() lectureJournal: EventEmitter<Developpeur> = new EventEmitter<any>();
  developppeurConnecte: Developpeur = new Developpeur;
  visible: boolean = false;
  btnLireJournalVisible = true;
  btnStatsVisible = true;
  taches: Tache[] = new Array();

  constructor(private infoSrv: InfoService, private jvSrv: JourvieService) { }

  //----------------------------
  //
  //----------------------------

  ngOnInit(): void {
  }

  //----------------------------
  //
  //----------------------------

  onConnexionReussie(dev: Developpeur) {
    this.developppeurConnecte = dev;
    if (this.developppeurConnecte.ProjetAssigne_Id != 0) {
      this.visible = true;
      if (this.developppeurConnecte.Etat == 'actif') {
        this.lireJournal();
      }
      else {
        this.jvSrv.getTaches(dev.ProjetAssigne_Id).subscribe(
          tabTaches => {
            this.taches = tabTaches;
          },

          erreur => { tr('Erreur 65: ' + dev.ProjetAssigne_Id, true, true); }
        );
      }
    }
  }

  //----------------------------
  //
  //----------------------------

  demarrerSessionTravail(tache: Tache) {

    this.infoSrv.ajouter("Début session sur " + tache.Numero + " " + tache.Titre);
    this.visible = false;
    this.demarrerSession.emit(tache);
  }

  //----------------------------
  //
  //----------------------------

  onChangementTache(dev: Developpeur) {
    this.visible = true;
    this.jvSrv.getTaches(dev.ProjetAssigne_Id).subscribe(
      tabTaches => {
        this.taches = tabTaches;
      },

      erreur => { tr('Erreur 65: ' + dev.ProjetAssigne_Id, true, true); }
    );
  }

  //----------------------------
  //
  //----------------------------

  lireJournal() {
    this.visible = false;
    this.lectureJournal.emit(this.developppeurConnecte);
  }

  //----------------------------
  //
  //----------------------------
  
  ouvrirStatistiques() {
    tr('statistiques', true, true);
  }

}
