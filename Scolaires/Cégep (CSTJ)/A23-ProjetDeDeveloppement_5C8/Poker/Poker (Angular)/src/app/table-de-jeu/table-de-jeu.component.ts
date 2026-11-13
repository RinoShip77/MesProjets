import { Component, Output, EventEmitter } from '@angular/core';
import { Joueur } from '../modele/joueur';
import { tr, urlServeur } from '../utile';
import { Poker420Service } from '../poker420.service';
import { InfoPartie } from '../modele/infoPartie';

@Component({
  selector: 'app-table-de-jeu',
  templateUrl: './table-de-jeu.component.html',
  styleUrls: ['./table-de-jeu.component.css'],
})
export class TableDeJeuComponent {
  visible = false;
  joueur: Joueur = new Joueur();
  infoPartie: InfoPartie = new InfoPartie();
  srvURL = urlServeur;

  @Output() quitterTableJeu = new EventEmitter<Joueur>();

  //--------------------------------
  //
  //--------------------------------
  constructor(private pk420Srv: Poker420Service) { }

  //--------------------------------
  //
  //--------------------------------
  onDemarrerPartie(lesJoueurs: Joueur[]) {
    this.visible = true;
    this.joueur = lesJoueurs[0];
    this.pk420Srv.creationPartie(lesJoueurs).subscribe((infPar) => {
      this.infoPartie = infPar;
    });
  }

  //------------------------------------
  //
  //------------------------------------
  onOuvrirPartieEnCours(eventData: { arg1: number; arg2: Joueur }) {
    this.joueur = eventData.arg2;
    this.pk420Srv.getInfoPartieEnCours(eventData.arg1, eventData.arg2).subscribe((infPar) => {
      this.infoPartie = infPar;
      tr('info de la partie ' + this.infoPartie.id);

      this.visible = true;
    });
  }

  //--------------------------------
  //
  //--------------------------------
  quitterPartie() {
    this.visible = false;
    this.quitterTableJeu.emit(this.joueur);
  }
}
