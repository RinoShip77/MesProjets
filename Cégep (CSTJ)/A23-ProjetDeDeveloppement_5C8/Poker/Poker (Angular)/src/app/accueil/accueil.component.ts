import { Component, EventEmitter, Output } from '@angular/core';
import { Joueur } from '../modele/joueur';
import { Poker420Service } from '../poker420.service';
import { getURLAvatar, tr } from '../utile';

@Component({
  selector: 'app-accueil',
  templateUrl: './accueil.component.html',
  styleUrls: ['./accueil.component.css'],
})
export class AccueilComponent {
  visible = false;
  joueurConnecte = new Joueur();
  tabNumPartiesEnCours: number[] = new Array();
  ouvrirListePartiesEnCours = false;

  @Output() ouvrirCreationPartie = new EventEmitter<Joueur>();
  @Output() ouvrirPartieEnCours = new EventEmitter<{ arg1: number; arg2: Joueur; }>();
  @Output() ouvrirParametres = new EventEmitter<Joueur>();
  @Output() quitterAccueil = new EventEmitter<Joueur>();

  //--------------------------------
  //
  //--------------------------------
  constructor(private pkrSrv: Poker420Service) { }

  //--------------------------------
  //
  //--------------------------------
  quitter() {
    this.visible = false;
    this.quitterAccueil.emit(this.joueurConnecte);
  }

  //--------------------------------
  //
  //--------------------------------
  onConnexionReussie(j: Joueur) {
    this.visible = true;
    this.joueurConnecte = j;
    this.pkrSrv.getPartiesDUnJoueur(j).subscribe((toto) => {
      this.tabNumPartiesEnCours = toto;
    });
  }

  //--------------------------------
  //
  //--------------------------------
  basculePartiesEncours() {
    this.ouvrirListePartiesEnCours = !this.ouvrirListePartiesEnCours;
  }

  //--------------------------------
  //
  //--------------------------------
  creationPartie() {
    this.visible = false;
    this.ouvrirCreationPartie.emit(this.joueurConnecte);
  }

  //--------------------------------
  //
  //--------------------------------
  onQuitterCreationPartie(j: Joueur) {
    this.visible = true;
    this.joueurConnecte = j;
  }

  //--------------------------------
  //
  //--------------------------------
  ouvrirPartie(idPartie: number) {
    tr('Ouverture de la partie ' + idPartie);

    this.visible = false;
    this.ouvrirListePartiesEnCours = false;
    this.ouvrirPartieEnCours.emit({ arg1: idPartie, arg2: this.joueurConnecte });
  }

  //--------------------------------
  //
  //--------------------------------
  getAvatar() {
    return getURLAvatar(this.joueurConnecte.id);
  }

  //--------------------------------
  //
  //--------------------------------
  parametres() {
    this.visible = false;
    this.ouvrirParametres.emit(this.joueurConnecte);
  }
}
