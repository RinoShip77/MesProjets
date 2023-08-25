//----------------------------------------
//  Fichier: journal.component.ts
//  Développeur: Olivier Bourgault
//  Date: 2022-12-14
//  Projet: Jourvie
//-----------------------------------------

import { Component, Input, Output, EventEmitter, OnInit } from '@angular/core';
import { Developpeur } from '../modeles/Developpeur';
import { SessionTravail } from '../modeles/SessionTravail';
import { Tache } from './../modeles/Tache';
import { Fait } from './../modeles/Fait';
import { Commentaire } from '../modeles/Commentaire';
import { JvService } from '../jv.service';

@Component({
  selector: 'app-journal',
  templateUrl: './journal.component.html',
  styleUrls: ['./journal.component.css']
})
export class JournalComponent implements OnInit {
  @Input() dev: Developpeur = new Developpeur();
  @Output() changementTache: EventEmitter<Developpeur> = new EventEmitter<Developpeur>();
  visible = false;
  commentaireVisible = false;
  btnCommentaireVisible = false;
  btnArreterSessionVisible = false;
  btnChangerTacheVisible = true;
  btnConsulterTachesVisible = false;
  btnStatsVisible = true;
  tacheCourante: Tache = new Tache();
  sessTravCourante: SessionTravail = new SessionTravail();
  tabSessionsTravail: SessionTravail[] = Array();
  tabFaits: Fait[] = new Array();
  commentaireCourant: Commentaire = new Commentaire();
  tabComment: Commentaire[] = new Array();

  //Déclaration de variables pour les accumulateurs de temps
  intervalActif: any;
  accumulateurTempsActif: number = 0;
  accumulateurUniteActif: string = 'secondes';
  intervalInactif: any;
  accumulateurTempsInactif: number = 0;
  accumulateurUniteInactif: string = 'secondes';

  //-------------------------------------------
  // Déclaration du constructeur de la classe en ajoutant un attribut pour communiquer avec des données externes
  //-------------------------------------------
  constructor(private jvSrv: JvService) { }

  //---------------------------------
  // Sera appelé au début de l'exécution
  //---------------------------------
  ngOnInit(): void { }

  //---------------------------------
  // Quand on démarre une session de travail
  //---------------------------------
  onDemarrerSessTrav(tac: Tache) {
    this.tacheCourante = tac;
    this.dev.Etat = 'actif';
    this.visible = true;
    this.btnCommentaireVisible = true;
    this.jvSrv.postSessionTravail(tac, this.dev).subscribe(idSessTrav => {
      this.jvSrv.getSessionsTravail(this.dev.Id).subscribe(tabSessTrav => {
        this.tabSessionsTravail = tabSessTrav;
        this.jvSrv.getCommentaires(this.dev.Id).subscribe(tabComms => {
          this.tabComment = tabComms;
          this.rafraichirJournal();
          let indice = this.tabSessionsTravail.length - 1;
          this.sessTravCourante = this.tabSessionsTravail[indice];
        })
        this.btnArreterSessionVisible = true;
        this.btnCommentaireVisible = true;
        this.btnStatsVisible = true;
      })
    });
    this.incrementeTempsActif();
    this.arreterAccumulateurInactif();
  }

  //---------------------------------
  // Lorsqu'on met fin à une session de travail
  //---------------------------------
  arreterSessTrav() {
    this.jvSrv.putSessionTravail(this.sessTravCourante.Id).subscribe(sessTrav => {
      this.sessTravCourante = sessTrav;
      this.jvSrv.getSessionsTravail(this.dev.Id).subscribe(tabSesTrav => {
        this.tabSessionsTravail = tabSesTrav;
        this.rafraichirJournal();
        this.btnCommentaireVisible = false;
        this.btnArreterSessionVisible = false;
        this.dev.Etat = "inactif";
      })
    })
    this.arreterAccumulateurActif();
    this.incrementeTempsInactif();
  }

  //---------------------------------
  // Fonction qui est appelé quand un développeur se connecte
  //---------------------------------
  onConnexionDevActif(dev: Developpeur) {
    this.onDemarrerSessTrav(this.tacheCourante);
    this.visible = true;
    this.dev = dev;
    this.jvSrv.getSessionsTravail(this.dev.Id).subscribe(tabSessTrav => {
      this.tabSessionsTravail = tabSessTrav;
      this.jvSrv.getCommentaires(dev.Id).subscribe(tabComms => {
        this.tabComment = tabComms;
        this.rafraichirJournal();
        let indice = this.tabSessionsTravail.length - 1;
        this.sessTravCourante = tabSessTrav[indice];
        this.tacheCourante.Id = this.sessTravCourante.IdTache;
        this.tacheCourante.Numero = this.sessTravCourante.TacheNumero;
      })
      this.btnArreterSessionVisible = true;
      this.btnCommentaireVisible = true;
      this.btnStatsVisible = true;
    })
  }

  //---------------------------------
  // Lorsqu'on désire ajouter un commentaire, on cache les boutons de base
  //---------------------------------
  commenter() {
    // Activer le formulaire de saisie
    this.commentaireVisible = true;
    this.btnCommentaireVisible = false;
    this.btnChangerTacheVisible = false;
    this.btnStatsVisible = false;
    this.btnConsulterTachesVisible = false;
    this.btnArreterSessionVisible = false;
  }

  //---------------------------------
  // Va émettre un événement pour changer de tâche
  //---------------------------------
  changerTache() {
    if (this.sessTravCourante.Fin === null) {
      this.arreterSessTrav();
    }
    this.visible = false;
    this.changementTache.emit(this.dev);
  }

  //---------------------------------
  // Va afficher les tâches disponibles
  //---------------------------------
  tacheReadOnly() {
    alert('Cette fonctionnalité est encore en développement.');
  }

  //---------------------------------
  // Va afficher les statistiques du journal
  //---------------------------------
  statistiques() {
    alert('Cette fonctionnalité est encore en développement.');
  }

  //---------------------------------
  // Actualise l'entièreté du journal
  //---------------------------------
  rafraichirJournal() {
    this.tabFaits = Array();
    this.rafraichirFaitsDeSessions();
    this.tabFaits.sort(this.compareDate);
    this.enleverDatesRedondantes();
  }

  //---------------------------------
  // Actualise tous les faits de la sessions
  //---------------------------------
  rafraichirFaitsDeSessions() {
    let compteur = 0;
    this.tabSessionsTravail.forEach(sessTrav => {
      this.tabFaits.push(new Fait(++compteur, sessTrav));
      if (sessTrav.Fin !== null) {
        this.tabFaits.push(new Fait(++compteur, sessTrav, false));
      }
    })

    // Initialise le tableau de commentaires (de faits)
    this.tabComment.forEach(comm => {
      this.tabFaits.push(new Fait(++compteur, this.sessTravCourante, false, comm))
    })
  }

  //---------------------------------
  // Va retirer les dates qui se répètent
  //---------------------------------
  enleverDatesRedondantes() {
    let dateUnique = this.tabFaits[0].Date;
    for (let i = 1; i < this.tabFaits.length; i++) {
      if (this.tabFaits[i].Date === dateUnique) {
        this.tabFaits[i].Date = '';
      }
      else {
        dateUnique = this.tabFaits[i].Date;
      }
    }
  }

  //---------------------------------
  // Va trier les faits selon les dates les plus récentes
  //---------------------------------
  compareDate(f1: Fait, f2: Fait) {
    if (f1.Date > f2.Date) {
      return -1;
    }
    if (f1.Date < f2.Date) {
      return 1;
    }
    if (f1.Date === f2.Date) {
      if (f1.Heure > f2.Heure) {
        return -1;
      }
      if (f1.Heure < f2.Heure) {
        return 1;
      }
    }
    return 0;
  }

  //---------------------------------
  // Lorsqu'on annule un commentaire, on affiche les boutons de base
  //---------------------------------
  annulerCommentaire() {
    this.commentaireVisible = false;
    this.btnCommentaireVisible = true;
    this.btnChangerTacheVisible = true;
    this.btnStatsVisible = true;
    this.btnConsulterTachesVisible = true;
    this.btnArreterSessionVisible = true;
  }

  //---------------------------------
  // Fontion qui s'exécute lors de l'enregistrement d'un commentaire
  //---------------------------------
  enregistrerCommentaire() {
    if (this.commentaireCourant.Contenu.length > 0) {
      this.commentaireCourant.IdSession = this.sessTravCourante.Id;
      this.commentaireCourant.IdDev = this.dev.Id;

      this.jvSrv.postCommentaire(this.commentaireCourant).subscribe(idComm => {
        alert("Votre commentaire\n" + "« " + this.commentaireCourant.Contenu + ". »" + " (" + idComm + ")\n" + "a bien enregistré.");

        // Actualise le tableau de commentaires
        this.jvSrv.getCommentaires(this.dev.Id).subscribe(tabComms => {
          this.tabComment = tabComms;
          this.commentaireCourant = new Commentaire();
          this.rafraichirJournal();
        })
      })
      // Ce n'est pas un vrai annuler() j'utilise juste la fonctionnalité
      this.annulerCommentaire();
    }
    else {
      // Ce n'est pas un vrai annuler() j'utilise juste la fonctionnalité
      this.annulerCommentaire();
    }
  }

  //---------------------------------
  // Va afficher le journal du développeur sans lui permettre d'interagir avec celui-ci
  //---------------------------------
  onLectureJournal(dev: Developpeur) {
    this.dev = dev;
    this.visible = true;
    this.jvSrv.getSessionsTravail(this.dev.Id).subscribe(sessTrav => {
      this.tabSessionsTravail = sessTrav;
      this.rafraichirJournal();
      this.tabFaits.forEach(fait => {
        fait.Contenu = "";
      });
    })
  }

  //---------------------------------
  // Fonction qui enclancher l'incrémentation du minuteur d'activité
  //---------------------------------
  incrementeTempsActif() {
    this.intervalActif = setInterval(() => {
      switch (this.accumulateurUniteActif) {
        case "secondes":
          this.accumulateurTempsActif += 2.0;
          break;
        case "minutes":
          this.accumulateurTempsActif += 0.2;
          break;
        case "heures":
          this.accumulateurTempsActif += 0.2;
          break;
      }

      if (this.accumulateurTempsActif == 180 && this.accumulateurUniteActif == 'secondes') {
        this.accumulateurTempsActif = 0;
        this.accumulateurUniteActif = 'minutes';
      }
      if (this.accumulateurTempsActif > 180 && this.accumulateurUniteActif == 'minutes') {
        this.accumulateurTempsActif = 0;
        this.accumulateurUniteActif = 'heures';
      }
    }, 2000);
    this.accumulateurTempsActif = 0;
    this.accumulateurUniteActif = 'secondes';
  }

  //---------------------------------
  // Fonction qui va arrêter l'incrémentation du minuteur d'activité
  //---------------------------------
  arreterAccumulateurActif() {
    clearInterval(this.intervalActif);
  }

  //---------------------------------
  // Fonction qui va enclancher l'incrémentation du minuteur d'inactivité
  //---------------------------------
  incrementeTempsInactif() {
    this.intervalInactif = setInterval(() => {
      switch (this.accumulateurUniteInactif) {
        case "secondes":
          this.accumulateurTempsInactif += 2.0;
          break;
        case "minutes":
          this.accumulateurTempsInactif += 0.2;
          break;
        case "heures":
          this.accumulateurTempsInactif += 0.2;
          break;
      }

      if (this.accumulateurTempsInactif == 180 && this.accumulateurUniteInactif == 'secondes') {
        this.accumulateurTempsInactif = 0;
        this.accumulateurUniteInactif = 'minutes';
      }
      if (this.accumulateurTempsInactif > 180 && this.accumulateurUniteInactif == 'minutes') {
        this.accumulateurTempsInactif = 0;
        this.accumulateurUniteInactif = 'heures';
      }
    }, 2000);
    this.accumulateurTempsInactif = 0;
    this.accumulateurUniteInactif = 'secondes';
  }

  //---------------------------------
  // Fonction qui va arrêter l'incrémentation du minuteur d'inactivité
  //---------------------------------
  arreterAccumulateurInactif() {
    clearInterval(this.intervalInactif);
  }

  //-------------------------------------------
  //Est appelé lorsqu'on clique pour revenir à l'écran de connexion
  //-------------------------------------------
  retourConnexion() {
    window.location.reload();
  }
}