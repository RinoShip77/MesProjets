//----------------------------------------
//  Fichier: SessionTravail.ts
//  Développeur: Olivier Bourgault
//  Date: 2022-12-14
//  Projet: Jourvie
//-----------------------------------------

import { Tache } from "./Tache";

export class SessionTravail {
  Id: number = 0;
  IdTache: number = 0;
  TacheNumero: string = '';
  Etat: string = '';
  IdDev = 0;
  Debut = '';
  Fin: string = '';
  Duree = 0;
  DureeMinutes = "";
  DureeHeures = "";
  NbCommentaires = 0; //Ajout d'un attribut pour connaître le nombre totale de commentaires de la session de travail

  constructor(id = 0, tache: Tache = new Tache(), idDev = 0, maintenant: string = "1900-01-01 00:00:00") {
    this.Id = id;
    this.IdTache = tache.Id;
    this.TacheNumero = tache.Numero;
    this.Etat = 'actif';
    this.IdDev = idDev;
    this.Debut = maintenant;
  }
}