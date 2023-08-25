//------------------------------------------
//   fichier : admin.component.ts
//   Dev : Olivier Bourgault
//   Date: 2021-11-21
//   Projet: JourVie
//------------------------------------------

import { Component, OnInit } from '@angular/core';
import { Developpeur } from '../modeles/developpeur';
import { SessionTravail } from '../modeles/sessionTravail';
import { JourvieService } from './../jourvie.service';

@Component({
  selector: 'app-admin',
  templateUrl: './admin.component.html',
  styleUrls: ['./admin.component.css']
})
export class AdminComponent implements OnInit {
  titre: string = '';
  tabSessions: SessionTravail[] = new Array();
  tabDeveloppeurs: Developpeur[] = new Array();
  boutonSommaire: boolean = true;
  afficherSommaire: boolean = true;
  boutonSessions: boolean = false;
  afficherSessions: boolean = false;
  afficherDetail: boolean = false;
  visible: boolean = false;
  tabMinutesSession: string[] = new Array();
  tabHeuresSession: string[] = new Array();
  tabHeuresDev: string[] = new Array();
  tabMinutesDetails: string[] = new Array();
  tabHeuresDetails: string[] = new Array();
  tabNbCommentairesSession: number[] = new Array();
  tabNbCommentairesDev: number[] = new Array();
  nbSessions: number = 0;
  tabNbSessionsDev: number[] = new Array();
  tempsSession: number = 0;
  tempsSessionDev: number = 0;
  tempsDetails: number = 0;
  tabNom: string[] = new Array();
  tabIdsProjets: string[] = new Array();
  tabDetails: SessionTravail[] = new Array();
  tabCommentairesDetails: number[] = new Array();

  //----------------------------
  //
  //----------------------------

  constructor(private jvSrv: JourvieService) { }

  //----------------------------
  //
  //----------------------------

  ngOnInit(): void {
  }

  //----------------------------
  //
  //----------------------------

  onConnexionAdmin() {
    this.visible = true;
    this.titre = 'Sessions en cours';
  }

  //----------------------------
  //
  //----------------------------

  sommaireDeveloppeur() {
    this.boutonSommaire = false;
    this.afficherSommaire = false;
    this.boutonSessions = true;
    this.afficherSessions = true;
    this.afficherDetail = false;
    this.titre = 'Sommaire développeur';

    this.jvSrv.getDeveloppeurs().subscribe(
      developpeurs => {
        this.tabDeveloppeurs = developpeurs;
        this.tabDeveloppeurs.forEach(dev =>
          this.tabNom.push(dev.Matricule + ' , ' + dev.Prenom + ' ' + dev.Nom)
        )
        this.tabDeveloppeurs.forEach(dev =>
          this.jvSrv.getUnProjet(dev.ProjetAssigne_Id).subscribe(
            projet => {
              this.tabIdsProjets.push(projet[0].Nom + ' ( ' + projet[0].Id + ' ) ')
            }
          )
        )
        this.tabDeveloppeurs.forEach(dev =>
          this.jvSrv.getNbSessionsTravail(dev.Id).subscribe(
            nbSessions => {
              this.tabNbSessionsDev.push(nbSessions.length);
            }
          )
        )
        this.tabDeveloppeurs.forEach(dev =>
          this.jvSrv.getSessionsTravail(dev.Id).subscribe(
            sess => {
              this.CalculerTempsSessionDev(sess)
            }
          )
        )
        this.tabDeveloppeurs.forEach(dev =>
          this.jvSrv.getCommentairesDeveloppeur(dev.Id).subscribe(
            comms => {
              this.tabNbCommentairesDev.push(comms.length)
            }
          )
        )
      }
    )
  }

  //----------------------------
  //
  //----------------------------

  sessionsEnCours() {
    this.boutonSessions = false;
    this.afficherSessions = false;
    this.boutonSommaire = true;
    this.afficherSommaire = true;
    this.afficherDetail = false;
    this.titre = 'Sessions en cours';

    this.jvSrv.getSessionsTravailEnCours().subscribe(
      sessions => {
        this.tabSessions = sessions;
        this.tabSessions.forEach(session =>
          this.jvSrv.getSessionsTravail(session.DevId).subscribe(
            sess => {
              this.CalculerTempsSession(sess)
            }
          )
        )
        this.tabSessions.forEach(session =>
          this.jvSrv.getCommentairesSesion(session.Id).subscribe(
            comms => {
              this.tabNbCommentairesSession.push(comms.length)
            }
          )
        )
      }
    )
  }

  //----------------------------
  //
  //----------------------------

  ouvrirDetails(numDev: number) {
    this.boutonSessions = true;
    this.afficherSessions = false;
    this.boutonSommaire = true;
    this.afficherSommaire = false;
    this.afficherDetail = true;
    this.titre = 'Détails de ' + this.tabDeveloppeurs[numDev].Prenom + ' ' + this.tabDeveloppeurs[numDev].Nom;

    this.jvSrv.getSessionsTravail(this.tabDeveloppeurs[numDev].Id).subscribe(
      sess => {
        console.log(sess);
        
        this.tabDetails = sess;
        this.CalculerTempsDetails(sess);
        this.tabDetails.forEach(session =>
          this.jvSrv.getCommentairesDetails(session.Id).subscribe(
            comms => {
              this.tabCommentairesDetails.push(comms.length)
            }
          )
        )
      }
    )
  }

  //----------------------------
  //
  //----------------------------

  CalculerTempsSession(sess:SessionTravail[]) {
    sess.forEach(sess => {
      if (sess.Fin != null) {
        let epochFin = new Date(sess.Fin).getTime();
        let epochDebut = new Date(sess.Debut).getTime();
        this.tempsSession += epochFin - epochDebut;
      }
      this.tabMinutesSession.push((this.tempsSession / 6000).toFixed(1));
      this.tabHeuresSession.push((this.tempsSession / 3600000).toFixed(1));
    });
  }
  
  //----------------------------
  //
  //----------------------------
  
  CalculerTempsSessionDev(sess: SessionTravail[]) {
    sess.forEach(session => {
      if (session.Fin != null) {
        let epochFin = new Date(session.Fin).getTime();
        let epochDebut = new Date(session.Debut).getTime();
        this.tempsSession += epochFin - epochDebut;
      }
      this.tabHeuresDev.push((this.tempsSession / 3600000).toFixed(1));
    });
  }
  
  //----------------------------
  //
  //----------------------------
  
  CalculerTempsDetails(sess:SessionTravail[]) {
    sess.forEach(session => {
      if (session.Fin != null) {
        let epochFin = new Date(session.Fin).getTime();
        let epochDebut = new Date(session.Debut).getTime();
        this.tempsDetails += epochFin - epochDebut;
      }
      this.tabMinutesDetails.push((this.tempsDetails / 6000).toFixed(1));
      this.tabHeuresDetails.push((this.tempsDetails / 3600000).toFixed(1));
    });
  }
}