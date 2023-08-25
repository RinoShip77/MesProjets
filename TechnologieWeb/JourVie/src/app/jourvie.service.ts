//------------------------------------------
//   fichier : jourvie.service.component.ts
//   Dev : Olivier Bourgault
//   Date: 2021-11-21
//   Projet: JourVie
//------------------------------------------

import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { serveurURL } from './outils';
import { Developpeur } from './modeles/developpeur';
import { SessionTravail } from './modeles/sessionTravail';
import { Tache } from './modeles/tache';
import { Commentaire } from './modeles/commentaire';

@Injectable({
  providedIn: 'root'
})
export class JourvieService {

  //----------------------------------
  //
  //----------------------------------
  
  constructor(private http: HttpClient) { }

  getUnProjet(projetId:number)
  {
    return this.http.get<any>( serveurURL + 'getUnProjet.php?projetId=' + projetId);
  }

  //----------------------------------
  //
  //----------------------------------

  getDeveloppeurs()
  {
    return this.http.get<Developpeur[]>( serveurURL + 'getDeveloppeurs.php');
  }

  //----------------------------------
  //
  //----------------------------------

  getCommentairesDeveloppeur(devId:number)
  {
    return this.http.get<Commentaire[]>( serveurURL + 'getCommentairesDeveloppeur.php?devId=' + devId);
  }

  //----------------------------------
  //
  //----------------------------------
  
  getCommentairesSesion(sessId:number)
  {
    return this.http.get<Commentaire[]>( serveurURL + 'getCommentairesSession.php?sessId=' + sessId);
  }

  //----------------------------------
  //
  //----------------------------------
  
  getCommentairesDetails(sessId:number)
  {
    return this.http.get<Commentaire[]>( serveurURL + 'getCommentairesDetails.php?sessId=' + sessId);
  }

  //----------------------------------
  //
  //----------------------------------

  getSessionsTravail(devId: number) {
    return this.http.get<SessionTravail[]>(serveurURL + 'getSessionsTravail.php?devId=' + devId);
  }

  //----------------------------------
  //
  //----------------------------------
  getTaches(projetID: number) {
    return this.http.get<Tache[]>(serveurURL + 'getTaches.php?projetID=' + projetID);
  }

  //----------------------------------
  //
  //----------------------------------

  getNbSessionsTravail(devId:number) {
    return this.http.get<any[]>(serveurURL + 'getNbSessionsTravail.php?devId=' + devId);
  }

  //----------------------------------
  //
  //----------------------------------

  getSessionsTravailEnCours() {
    return this.http.get<SessionTravail[]>(serveurURL + 'getSessionsTravailEnCours.php');
  }

  //----------------------------------
  //
  //----------------------------------

  getUnDeveloppeur(mat: string) {
    return this.http.get<Developpeur>(serveurURL + 'getUnDeveloppeur.php?matricule=' + mat);
  }

  //----------------------------------
  //
  //----------------------------------
  getUneTache(sessId: number) {
    return this.http.get<Tache>(serveurURL + 'getUneTache.php?sessId=' + sessId);
  }

  //----------------------------------
  //
  //----------------------------------
  postCommentaire(devId: number, sessId: number, contenu: string) {
    return this.http.get<number>(serveurURL + 'postCommentaire.php?devId=' + devId + '&sessId=' + sessId + "&contenu=" + contenu);
  }

  //----------------------------------
  //
  //----------------------------------
  postSessionTravail(tacId: number, tacNum: string, devId: number) {
    return this.http.get<number>(serveurURL + 'postSessionTravail.php?tacId=' + tacId + "&tacNum=" + tacNum + "&devId=" + devId);
  }

  //----------------------------------
  //
  //----------------------------------
  putSessionTravail(sessId: number) {
    return this.http.get<number>(serveurURL + 'putSessionTravail.php?sessId=' + sessId);
  }

}
