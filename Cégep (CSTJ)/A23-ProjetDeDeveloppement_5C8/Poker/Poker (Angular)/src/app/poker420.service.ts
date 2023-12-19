import { Injectable } from '@angular/core';
import { tr, urlServeur } from './utile';
import { Joueur } from './modele/joueur';
import { HttpClient, HttpParams } from '@angular/common/http';
import { InfoPartie } from './modele/infoPartie';

@Injectable({
  providedIn: 'root',
})
export class Poker420Service {
  //--------------------------------
  //
  //--------------------------------
  constructor(private http: HttpClient) {}

  //--------------------------------
  //
  //--------------------------------
  connexion(j: Joueur) {
    let url = urlServeur + 'connexion';

    const params = new HttpParams({
      fromObject: {
        nom: j.nom,
        mdp: j.motDePasse,
      },
    });

    return this.http.post<Joueur>(url, params);
  }

  //--------------------------------
  //
  //--------------------------------
  creationJoueur(j: Joueur) {
    let url = urlServeur + 'creationJoueur';

    const params = new HttpParams({
      fromObject: {
        nom: j.nom,
        mdp: j.motDePasse,
        courriel: j.courriel,
      },
    });

    return this.http.post<Joueur>(url, params);
  }

  //--------------------------------
  //
  //--------------------------------
  creationPartie(joueurs: Joueur[]) {
    let url = urlServeur + 'creationPartie';
    let joueursEnvoyes = new Array();

    tr("Création partie avec jwt:" + joueurs[0].jwt, true);

    for (let index = 0; index < 10; index++) {
      if (joueurs[index] === undefined) {
        joueursEnvoyes.push(0);
      } else {
        joueursEnvoyes.push(joueurs[index].id);
      }
    }

    const params = new HttpParams({
      fromObject: {
        jwt: joueursEnvoyes[0].jwt,
        idJ0: joueursEnvoyes[0],
        idJ1: joueursEnvoyes[1],
        idJ2: joueursEnvoyes[2],
        idJ3: joueursEnvoyes[3],
        idJ4: joueursEnvoyes[4],
        idJ5: joueursEnvoyes[5],
        idJ6: joueursEnvoyes[6],
        idJ7: joueursEnvoyes[7],
        idJ8: joueursEnvoyes[8],
        idJ9: joueursEnvoyes[9],
      },
    });

    return this.http.post<InfoPartie>(url, params);
  }

  //--------------------------------
  //
  //--------------------------------
  getJoueur(j: Joueur) {
    let url = urlServeur + 'getJoueurs?idJ=' + j.id;

    return this.http.get<Joueur[]>(url);
  }

  //--------------------------------
  //
  //--------------------------------
  getPartiesDUnJoueur(j: Joueur) {
    let url = urlServeur + 'getPartiesDUnJoueur';
    tr('joueur:' + j.id);

    const params = new HttpParams({
      fromObject: {
        idJ: j.id,
      },
    });

    return this.http.post<number[]>(url, params);
  }

  //--------------------------------
  //
  //--------------------------------
  getInfoPartieEnCours(idPartie: number, j: Joueur) {
    let url = urlServeur + 'getInfoPartieEnCours';
    tr('Info pour la partie ' + idPartie);

    const params = new HttpParams({
      fromObject: {
        idPartie: idPartie,
        idJConnecte: j.id,
      },
    });

    return this.http.post<InfoPartie>(url, params);
  }

  //--------------------------------
  //
  //--------------------------------
  televerseFichier(info: FormData) {
    let url = urlServeur + 'televerseAvatar';

    return this.http.post<string>(url, info);
  }
}
