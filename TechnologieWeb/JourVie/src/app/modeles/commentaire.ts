//------------------------------------------
//   fichier : commentaire.ts
//   Dev : Olivier Bourgault
//   Date: 2021-11-21
//   Projet: JourVie
//------------------------------------------

import { fusoMTL } from './../outils';

export class Commentaire {
    Id = 0;
    SessionId = 0;
    DevId = 0;
    Horodateur = '';
    Contenu = '';

    //-------------------------------------
    //
    //-------------------------------------
    
    constructor(sessionId = 0, devid = 0, contenu = '', id = 0) {
        this.Id = id;
        this.SessionId = sessionId;
        this.DevId = devid;
        this.Contenu = contenu;
        this.Horodateur = new Date(fusoMTL()).toISOString();
    }
}