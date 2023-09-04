//----------------------------------------
//  Fichier: jv.service.ts
//  Développeur: Olivier Bourgault
//  Date: 2022-12-14
//  Projet: Jourvie
//-----------------------------------------

import { Injectable } from '@angular/core';
import { HttpClient, HttpParams } from '@angular/common/http';
import { SERVEUR_URL } from './outils';
import { Developpeur } from './modeles/Developpeur';
import { Tache } from './modeles/Tache';
import { SessionTravail } from './modeles/SessionTravail';
import { Commentaire } from './modeles/Commentaire';

@Injectable({
  providedIn: 'root'
})
export class JvService {

  //-------------------------------------------
  // Déclaration du constructeur de la classe en ajoutant un attribut pour communiquer avec la base de données
  //-------------------------------------------
  constructor(private http: HttpClient) { }

  //-------------------------------------------
  // Permet d'obtenir les commentaires rédigées par un développeur
  //-------------------------------------------
  getCommentaires(id: number) {
    return this.http.get<Commentaire[]>(SERVEUR_URL + 'getCommentaires.php?idDev=' + id);
  }

  //-------------------------------------------
  // Permet d'obtenir les commentaires rédigées pendant un session
  //-------------------------------------------
  getCommentairesSession(id: number) {
    return this.http.get<Commentaire[]>(SERVEUR_URL + 'getCommentairesSessions.php?idSess=' + id);
  }

  //-------------------------------------------
  // Permet d'obtenir les identifiants d'un développeur
  //-------------------------------------------
  getDevelppeur(matricule: string, motDePasse: string) {
    return this.http.get<Developpeur>(SERVEUR_URL + 'getDeveloppeur.php?mat=' + matricule + "&mdp=" + motDePasse);
  }

  //-------------------------------------------
  // Permet d'obtenir tous les développeur de l'application
  //-------------------------------------------
  getDeveloppeurs() {
    return this.http.get<Developpeur[]>(SERVEUR_URL + 'getDeveloppeurs.php');
  }

  //-------------------------------------------
  // Permet d'obtenir un projet
  //-------------------------------------------
  getProjet(id: number) {
    return this.http.get<any>(SERVEUR_URL + 'getProjet.php?idProj=' + id);
  }

  //-------------------------------------------
  // Permet d'obtenir les sessions de travail d'un développeur
  //-------------------------------------------
  getSessionsTravail(id: number) {
    return this.http.get<SessionTravail[]>(SERVEUR_URL + 'getSessionsTravail.php?idDev=' + id);
  }

  //-------------------------------------------
  // Permet d'obtenir les sessions de travails dont la date de fin n'estpas défini
  //-------------------------------------------
  getSessionsTravailEnCours() {
    return this.http.get<SessionTravail[]>(SERVEUR_URL + 'getSessionsTravailEnCours.php');
  }

  //-------------------------------------------
  // Permet d'obtenir une session de travail
  //-------------------------------------------
  getSessionTravail(id: number) {
    return this.http.get<SessionTravail>(SERVEUR_URL + 'getSessionTravail.php?idSessTrav=' + id);
  }

  //-------------------------------------------
  // Permet d'obtenir les tâches de l'application
  //-------------------------------------------
  getTaches(id: number) {
    return this.http.get<Tache[]>(SERVEUR_URL + 'getTaches.php?idProj=' + id);
  }

  //-------------------------------------------
  // Permet d'ajouter un commentaire dans la base de données
  //-------------------------------------------
  postCommentaire(commentaire: Commentaire) {
    let url = SERVEUR_URL + 'postCommentaire.php';

    const params = new HttpParams({
      fromObject: {
        idSession: commentaire.IdSession,
        idDev: commentaire.IdDev,
        contenu: commentaire.Contenu
      }
    })

    return this.http.post<Number>(url, params);
  }

  //-------------------------------------------
  // Permet d'ajouter une session de travail dans la base de données
  //-------------------------------------------
  postSessionTravail(tache: Tache, developpeur: Developpeur) {
    let url = SERVEUR_URL + 'postSessionTravail.php';

    const params = new HttpParams({
      fromObject: {
        idTac: tache.Id,
        tacNum: tache.Numero,
        idDev: developpeur.Id
      }
    })

    return this.http.post<number>(url, params);
  }

  //-------------------------------------------
  // Permet de mettre à jour une session de travail dans la base de données
  //-------------------------------------------
  putSessionTravail(id: number) {
    return this.http.get<SessionTravail>(SERVEUR_URL + 'putSessionTravail.php?id=' + id);
  }
}