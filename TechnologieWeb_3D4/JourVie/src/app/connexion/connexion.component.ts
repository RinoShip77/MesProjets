// ----------------------------------------
//  Fichier: connexion.component.ts
//  Développeur: Olivier Bourgault
//  Date: 2022-12-14
//  Projet: Jourvie
// -----------------------------------------

import { Component, EventEmitter, OnInit, Output } from '@angular/core';
import { Developpeur } from './../modeles/Developpeur';
import { JvService } from '../jv.service';

@Component({
  selector: 'app-connexion',
  templateUrl: './connexion.component.html',
  styleUrls: ['./connexion.component.css']
})
export class ConnexionComponent implements OnInit {
  @Output() connexionReussie: EventEmitter<Developpeur> = new EventEmitter<Developpeur>();
  developpeurConnecte: Developpeur = new Developpeur();
  Matricule: string = "";
  MotDePasse: string = "";

  // Variables pour assurer l'affichage et le fonctionnement de la connexion administrateur
  @Output() connexionAdmin: EventEmitter<any> = new EventEmitter<any>();
  visible: boolean = true;

  // Variables pour les informations de connexions à l'utilisateur
  message: string = "";
  classe: string = "";

  //-------------------------------------------
  // Déclaration du constructeur de la classe en ajoutant un attribut pour communiquer avec des données externes
  //-------------------------------------------
  constructor(private jvSrv: JvService) { }

  //-------------------------------------------
  // Sera appelé au début de l'exécution
  //-------------------------------------------
  ngOnInit(): void { }

  //-------------------------------------------
  // Fonction qui sera appelé lors du clique sur le bouton de connexion
  //-------------------------------------------
  verifierConnexion() {
    if (this.Matricule.length == 0) {
      // Forcer une connexion triche
      this.Matricule = '1111111';
      this.MotDePasse = '11';
    }
    this.jvSrv.getDevelppeur(this.Matricule, this.MotDePasse).subscribe(dev => {
      let to = typeof (dev);
      if (to === 'string' && !(this.Matricule == 'admin' && this.MotDePasse == '11')) {
        // Affichera le message à l'utilisateur
        this.message = "Erreur de connexion.";
        this.classe = "affiche";
      }
      else {
        if (this.Matricule == 'admin' && this.MotDePasse == '11') {
          // Forcer une connexion en tant qu'un administrateur
          // Affichera le message à l'utilisateur
          this.message = "Connecté en tan qu'administrateur.";
          this.classe = "affiche";
          // Retarde la connexion d'une demi seconde
          setTimeout(() => {
            this.connexionAdmin.emit();
            this.visible = false;
          }, 500);
        } else {
          // Affichera le message à l'utilisateur
          this.message = "Bienvenue " + dev.Nom + " " + dev.Prenom + ".";
          this.classe = "affiche";
          // Retarde la connexion d'une demi seconde
          setTimeout(() => { this.connexionReussie.emit(dev); }, 500);1
        }
      }
    })
    this.classe = ""; // Réinitialise la classe du bloc pour le message à l'utilisateur
  }
}