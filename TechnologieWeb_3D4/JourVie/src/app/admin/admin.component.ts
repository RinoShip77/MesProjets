//----------------------------------------
//  Fichier: admin.component.ts
//  Développeur: Olivier Bourgault
//  Date: 2022-12-14
//  Projet: Jourvie
//-----------------------------------------

import { Component, OnInit } from '@angular/core';
import { JvService } from '../jv.service';
import { Developpeur } from '../modeles/Developpeur';
import { SessionTravail } from '../modeles/SessionTravail';

@Component({
  selector: 'app-admin',
  templateUrl: './admin.component.html',
  styleUrls: ['./admin.component.css']
})
export class AdminComponent implements OnInit {
  visible: boolean = false;
  boutonSessions: boolean = false;
  afficherSessions: boolean = false;
  boutonSommaire: boolean = true;
  afficherSommaire: boolean = true;
  afficherDetail: boolean = false;
  titre: string = '';

  //Pour voir les sessions en cours
  tabSessions: SessionTravail[] = new Array();
  tabMinutesSession: string[] = new Array();
  tabHeuresSession: string[] = new Array();

  //Pour voir les développeurs
  tabDeveloppeurs: Developpeur[] = new Array();
  tabNbSessionsDev: number[] = new Array();
  tabHeuresDev: string[] = new Array();
  tempsSessionDev: number = 0;

  //Pour voir les détails d'un développeur
  tabDetails: SessionTravail[] = new Array();
  tabMinutesDetails: string[] = new Array();
  tabHeuresDetails: string[] = new Array();


  //-------------------------------------------
  // Déclaration du constructeur de la classe en ajoutant un attribut pour communiquer avec des données externes
  //-------------------------------------------
  constructor(private jvSrv: JvService) { }

  //-------------------------------------------
  // Fonction qui s'exécutera au démarrage
  //-------------------------------------------
  ngOnInit(): void { }

  //-------------------------------------------
  // Fonction qui est appelé lorsqu'on se connecte en tant qu'administrateur
  //-------------------------------------------
  onConnexionAdmin() {
    this.visible = true;
    this.sessionsEnCours();
  }

  //-------------------------------------------
  // Fonction qui affiche toutes les sessions de travails en cours dans l'application
  //-------------------------------------------
  sessionsEnCours() {
    this.tabMinutesSession = new Array();
    this.tabHeuresSession = new Array();
    this.boutonSessions = false;
    this.afficherSessions = false;
    this.boutonSommaire = true;
    this.afficherSommaire = true;
    this.afficherDetail = false;
    this.titre = 'Sessions en cours';
    //On va chercher des données dans la base de données
    this.jvSrv.getSessionsTravailEnCours().subscribe(sessions => {
      this.tabSessions = sessions;
      this.tabSessions.forEach(session => {
        //On va chercher des données dans la base de données
        this.jvSrv.getSessionTravail(session.Id).subscribe(session => {
          this.CalculerTempsSession(session);
          //Va trier le tableau en ordre décroisant
          this.tabMinutesSession.sort((a, b) => parseFloat(b) - parseFloat(a));
          this.tabHeuresSession.sort((a, b) => parseFloat(b) - parseFloat(a));
        });
        //On va chercher des données dans la base de données
        this.jvSrv.getCommentairesSession(session.Id).subscribe(commentaires => {
          session.NbCommentaires = commentaires.length; //Assigne la longueur du tableau de commentaires à la bonne propriétée
        });
      });
    });
  }

  //-------------------------------------------
  // Fonction qui affiche tous les développeurs
  //-------------------------------------------
  sommaireDeveloppeurs() {
    this.boutonSommaire = false;
    this.afficherSommaire = false;
    this.boutonSessions = true;
    this.afficherSessions = true;
    this.afficherDetail = false;
    this.titre = 'Sommaire développeurs';
    //On va chercher des données dans la base de données
    this.jvSrv.getDeveloppeurs().subscribe(developpeurs => {
      this.tabDeveloppeurs = developpeurs;
      this.tabDeveloppeurs.forEach(developpeur => {
        //On va chercher des données dans la base de données
        this.jvSrv.getProjet(developpeur.IdProjet).subscribe(projet => {
          developpeur.NomProjet = projet.Nom;
        });
        //On va chercher des données dans la base de données
        this.jvSrv.getSessionsTravail(developpeur.Id).subscribe(sessions => {
          developpeur.NbSessions = sessions.length;
          //Va trier le tableau en ordre décroisant
          this.CalculerTempsSessionsDev(developpeur, sessions);
          //Va trier le tableau en ordre décroisant du nombre d'heures
          this.tabDeveloppeurs.sort((a, b) => parseFloat(b.Duree) - parseFloat(a.Duree));
        });
        //On va chercher des données dans la base de données
        this.jvSrv.getCommentaires(developpeur.Id).subscribe(commentaires => {
          developpeur.NbCommentaires = commentaires.length; //Assigne la longueur du tableau de commentaires à la bonne propriétée
        });
      });
    });
  }

  //-------------------------------------------
  // Fonction qui affiche les détails d'un développeur dans un tableau
  //-------------------------------------------
  ouvrirDetails(numDev: number) {
    this.tabMinutesDetails = new Array();
    this.tabHeuresDetails = new Array();
    this.boutonSessions = true;
    this.afficherSessions = false;
    this.boutonSommaire = true;
    this.afficherSommaire = false;
    this.afficherDetail = true;
    this.titre = 'Détails de ' + this.tabDeveloppeurs[numDev].Prenom + ' ' + this.tabDeveloppeurs[numDev].Nom;
    //On va chercher des données dans la base de données
    this.jvSrv.getSessionsTravail(this.tabDeveloppeurs[numDev].Id).subscribe(session => {
      this.tabDetails = session.sort(this.compareDate);
      this.tabDetails.forEach(session => {
        this.CalculerTempsDetail(session);
        //On va chercher des données dans la base de données
        this.jvSrv.getCommentairesSession(session.Id).subscribe(commmentaires => {
          session.NbCommentaires = commmentaires.length; //Assigne la longueur du tableau de commentaires à la bonne propriétée
        })
      });
    });
  }

  //-------------------------------------------
  // Fonction qui va calculer le temps qui s'est écoulé pandant une session donnée
  //-------------------------------------------
  CalculerTempsSession(session: SessionTravail) {
    //Calcul la durée en minute
    this.tabMinutesSession.push((((new Date().getTime()) - (new Date(session.Debut).getTime())) / 60000).toFixed(1));
    //Calcul la durée en heure
    this.tabHeuresSession.push((((new Date().getTime()) - (new Date(session.Debut).getTime())) / 3600000).toFixed(1));
  }

  //-------------------------------------------
  // Fonction qui va calculer le temps qui s'est écoulé durant toutes les sessions d'un développeur
  //-------------------------------------------
  CalculerTempsSessionsDev(dev: Developpeur, sessions: SessionTravail[]) {
    let duree = 0;
    sessions.forEach(session => {
      if (session.Fin != null) {
        //Calcul la durée selon la date de fin
        duree += (new Date(session.Fin).getTime()) - (new Date(session.Debut).getTime());
      } else {
        //Calcul la durée selon la date actuelle
        duree += (new Date().getTime()) - (new Date(session.Debut).getTime());
      }
    });
    dev.Duree = (duree / 3600000).toFixed(1); //Ajustement pour avoir la valeur au dixième près
  }

  //-------------------------------------------
  // Fonction qui va calculer le temps qui s'est écoulé pandant les sessions d'un développeur
  //-------------------------------------------
  CalculerTempsDetail(session: SessionTravail) {
    if (session.Fin != null) {
      //Calcul la durée selon la date de fin
      session.Duree = (new Date(session.Fin).getTime()) - (new Date(session.Debut).getTime());
    } else {
      //Calcul la durée selon la date actuelle
      session.Duree = (new Date().getTime()) - (new Date(session.Debut).getTime());
    }
    this.tabMinutesDetails.push((session.Duree / 60000).toFixed(1));
    this.tabHeuresDetails.push((session.Duree / 3600000).toFixed(1));
  }

  //---------------------------------
  // Va trier les sessions selon les dates les plus récentes
  //---------------------------------
  compareDate(s1: SessionTravail, s2: SessionTravail) {
    if (s1.Debut > s2.Debut) {
      return -1;
    }
    if (s1.Debut < s2.Debut) {
      return 1;
    }
    return 0;
  }

  //-------------------------------------------
  // Est appelé lorsqu'on clique pour revenir à l'écran de connexion
  //-------------------------------------------
  retourConnexion() {
    window.location.reload();
  }
}