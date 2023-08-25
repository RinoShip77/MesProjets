//------------------------------------------
//   fichier :journal.component.ts
//   Dev : Olivier Bourgault
//   Date: 2021-11-21
//   Projet: JourVie
//------------------------------------------

import { Component, Input, OnInit, Output, EventEmitter } from '@angular/core';
import { tr, fusoMTL } from '../outils';
import { Tache } from '../modeles/tache';
import { SessionTravail } from '../modeles/sessionTravail';
import { Evenement } from '../modeles/evenement';
import { Developpeur } from '../modeles/developpeur';
import { Commentaire } from '../modeles/commentaire';
import { JourvieService } from './../jourvie.service';


@Component({
   selector: 'app-journal',
   templateUrl: './journal.component.html',
   styleUrls: ['./journal.component.css']
})
export class JournalComponent implements OnInit {
   @Input() developpeur: Developpeur = new Developpeur();
   @Output() changementTache: EventEmitter<Developpeur> = new EventEmitter<Developpeur>();
   visible: boolean = false;

   sessionCouranteId: number = -1;
   commentaireCourantIdx = 0;
   sessionsTravail: SessionTravail[] = Array();
   btnCommentaireVisible: boolean = true;
   changerTacheVisible: boolean = true;
   arreterSessionVisible: boolean = true;
   formComVisible = false;
   statsVisible: boolean = true;
   evenements: Evenement[] = Array();
   couleurStatut = '';
   statutJournal = '';
   commentaire: Commentaire = new Commentaire();
   commentaires: Commentaire[] = new Array();
   accumulateurTemps: number = 0;
   accumulateurUnite: string = 'secondes';
   tabContenuCommentaire: string[] = new Array();

   constructor(private jvSrv: JourvieService) { }

   //----------------------------
   //
   //----------------------------

   ngOnInit(): void {
   }

   //----------------------------
   //
   //----------------------------

   ouvrirDialogCommentaire() {
      this.btnCommentaireVisible = false;
      this.changerTacheVisible = false;
      this.arreterSessionVisible = false;
      this.statsVisible = false;
      this.formComVisible = true;
   }

   //----------------------------
   //
   //----------------------------

   saisirCommentaire(event: any) {
      this.commentaire.Contenu = event.target.value;
   }

   //----------------------------
   //
   //----------------------------

   enregistrerCommentaire() {
      tr(this.commentaire.Contenu);

      if (this.commentaire.Contenu === '')
         return;

      this.jvSrv.postCommentaire(this.developpeur.Id, this.sessionCouranteId, this.commentaire.Contenu).subscribe(
         res => {
            tr('Commentaire ajouté', true, false);
            this.commentaires.push(new Commentaire(this.sessionCouranteId, this.developpeur.Id, this.commentaire.Contenu))

         },
         () => {
            tr('Erreur 89');
         }
      );

      console.log(this.commentaires);
      this.preparerJournal();
      this.reactiverContextePrincipal();
   }

   //----------------------------
   //
   //----------------------------

   annulerCommentaire() {
      this.reactiverContextePrincipal();
   }

   //----------------------------
   //
   //----------------------------

   afficherCommentaire() {
      this.commentaires.forEach(comm =>
         this.jvSrv.getCommentairesDeveloppeur(comm.DevId).subscribe(
            comms => {
               this.tabContenuCommentaire.push(comms[comm.DevId].Contenu)
            }
         )
      )
   }

   //----------------------------
   //
   //----------------------------


   changerDeTache() {
      tr('changer tache');
      this.visible = false;

      this.jvSrv.putSessionTravail(this.sessionCouranteId).subscribe(
         nbMaj => {
            this.developpeur.Etat = 'inactif';
            this.sessionCouranteId = -1;
            this.changementTache.emit(this.developpeur);
         },
         () => { tr("Erreur 113", true, true); }
      );
   }

   //----------------------------
   //
   //----------------------------

   arreterSession() {
      this.btnCommentaireVisible = false;
      this.arreterSessionVisible = false;
      this.statutJournal = 'Inactif';
      this.couleurStatut = 'jaune';

      this.jvSrv.putSessionTravail(this.sessionCouranteId).subscribe(
         nbMaj => {
            this.jvSrv.getSessionsTravail(this.developpeur.Id).subscribe(
               tabSess => {
                  this.sessionsTravail = tabSess;
                  this.preparerJournal();
               },
               () => { tr("erreur 133", true, true); }
            );
         },
         () => { tr("Erreur 136", true, true); }
      );
   }

   //----------------------------
   //
   //----------------------------

   ouvrirStatistiques() {
      tr('stats', true, true);
   }

   //----------------------------
   //
   //----------------------------

   onDemarrerSession(tac: Tache) {
      tr('Ouverture du journal ' + tac.Numero + " " + tac.Titre);
      this.visible = true;
      this.btnCommentaireVisible = true;
      this.arreterSessionVisible = true;
      this.statutJournal = 'Actif sur ' + tac.Numero + ', (' + tac.Titre + ')';
      this.couleurStatut = 'vert';
      this.accumulateurTemps = 0;
      this.accumulateurTemps = setInterval(() => { this.incrementeTemps(); }, 2000) as unknown as number;

      this.jvSrv.postSessionTravail(tac.Id, tac.Numero, this.developpeur.Id).subscribe(
         idSess => {
            this.sessionCouranteId = idSess;
            this.jvSrv.getSessionsTravail(this.developpeur.Id).subscribe(
               tabSess => {
                  this.sessionsTravail = tabSess;
                  this.preparerJournal();
               },
               () => {
                  tr('erreur 160 de get session', true, true);
               }

            );
         },
         () => {
            tr("erreur 155 du post session de tracvail", true, true);
         }
      );
   }

   //----------------------------
   //
   //----------------------------

   preparerJournal() {
      this.evenements = new Array();
      for (let i = 0; i < this.sessionsTravail.length; i++) {
         if (this.sessionsTravail[i].Fin !== null) {
            this.evenements.push(new Evenement(this.sessionsTravail[i]));
            this.evenements.push(new Evenement(this.sessionsTravail[i], false));
         }
         else {
            this.evenements.push(new Evenement(this.sessionsTravail[i]));
         }
      }

      this.evenements.sort(this.comparaisonDate);
      this.enleverDatesRedondantes();
   }

   //----------------------------
   //
   //----------------------------

   enleverDatesRedondantes() {
      let dateCourante = this.evenements[0].Date;
      for (let i = 1; i < this.evenements.length; i++) {
         if (this.evenements[i].Date == dateCourante)
            this.evenements[i].Date = '';
         else
            dateCourante = this.evenements[i].Date
      }
   }

   //----------------------------
   //
   //----------------------------

   comparaisonDate(a: Evenement, b: Evenement) {
      if (a.Date > b.Date)
         return -1;
      if (a.Date < b.Date)
         return 1;
      if (a.Date === b.Date) {
         if (a.Heure > b.Heure)
            return -1;
         if (a.Heure < b.Heure)
            return 1;
      }
      return 0;
   }

   //----------------------------
   //
   //----------------------------

   reactiverContextePrincipal() {
      this.btnCommentaireVisible = true;
      this.changerTacheVisible = true;
      this.arreterSessionVisible = true;
      this.statsVisible = true;
      this.formComVisible = false;
   }

   //----------------------------
   //
   //----------------------------

   onLectureJournal(dev: Developpeur) {
      this.developpeur = dev;
      this.visible = true;

      this.jvSrv.getSessionsTravail(this.developpeur.Id).subscribe(
         sessTrav => {
            this.sessionsTravail = sessTrav;
            this.preparerJournal();

            if (this.developpeur.Etat == 'actif') {
               this.btnCommentaireVisible = true;
               this.arreterSessionVisible = true;
               this.statutJournal = 'Actif';
               this.couleurStatut = 'vert';
               this.sessionCouranteId = this.sessionsTravail[0].Id;
               this.jvSrv.getUneTache(this.sessionCouranteId).subscribe(
                  tac => {
                     this.statutJournal += " sur " + tac.Numero + " (" + tac.Titre + ")";
                  },
                  () => {
                     tr("Erreur 283", true, true);
                  }
               )
            }
            else {
               this.btnCommentaireVisible = false;
               this.arreterSessionVisible = false;
               this.statutJournal = 'Inactif';
               this.couleurStatut = 'jaune';
            }
         }
      )
   }

   //----------------------------
   //
   //----------------------------

   incrementeTemps() {
      if (this.statutJournal === 'Inactif') {
         this.accumulateurTemps = 0;
      }
      else {
         if (this.accumulateurTemps >= 180 && this.accumulateurUnite === 'secondes') {
            this.accumulateurTemps = 0;
            this.accumulateurUnite = 'minutes';
         }

         if (this.accumulateurTemps >= 180 && this.accumulateurUnite === 'minutes') {
            this.accumulateurTemps = 0;
            this.accumulateurUnite = 'heures';
         }
      }

      this.accumulateurTemps += 2;
   }
}