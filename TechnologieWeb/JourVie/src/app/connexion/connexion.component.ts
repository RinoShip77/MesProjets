//------------------------------------------
//   fichier : connexion.component.ts
//   Dev : Olivier Bourgault
//   Date: 2021-11-21
//   Projet: JourVie
//------------------------------------------

import { Component, OnInit, Output, EventEmitter } from '@angular/core';
import { tr, fusoMTL } from './../outils'
import { Developpeur } from './../modeles/developpeur';
import { InfoService } from './../info.service';
import { JourvieService } from '../jourvie.service';


@Component({
  selector: 'app-connexion',
  templateUrl: './connexion.component.html',
  styleUrls: ['./connexion.component.css']
})
export class ConnexionComponent implements OnInit {

  @Output() connexionAdmin: EventEmitter<any> = new EventEmitter<any>();
  @Output() connexionReussie: EventEmitter<Developpeur> = new EventEmitter<Developpeur>();
  devForm: Developpeur = new Developpeur();
  developpeur: Developpeur = new Developpeur();
  visible: boolean = true;

  //--------------------------------------
  //
  //--------------------------------------

  constructor(private infoSrv: InfoService, private jvSrv: JourvieService) { fusoMTL(); }

  //--------------------------------------
  //
  //--------------------------------------

  ngOnInit(): void {
  }

  //--------------------------------------
  //
  //--------------------------------------

  validerLogon() {
    tr('Tentative de connexion avec mat:' + this.devForm.Matricule, true, false);
    if (this.devForm.Matricule === 'admin' && this.devForm.MotDePasse === '11') {
      this.visible = false;
      this.connexionAdmin.emit();
    } else {
      this.jvSrv.getUnDeveloppeur(this.devForm.Matricule).subscribe(
        (dev) => {
          if (dev.MotDePasse == this.devForm.MotDePasse) {
            this.developpeur = dev;
            this.visible = false;
            this.connexionReussie.emit(this.developpeur);
          } else {
            tr("Erreur mauvais mot de passe", true, true);
          }
        },

        (erreur) => { tr('Erreur developpeur n existe pas', true, true) }
      )
    }
  }

  //--------------------------------------
  //
  //--------------------------------------
  
  tricher() {
    tr('Triche', false, false);
    this.devForm.Matricule = '1111111';
    this.devForm.MotDePasse = '11';
    this.validerLogon();
  }
}
