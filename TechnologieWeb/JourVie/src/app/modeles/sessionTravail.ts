//------------------------------------------
//   fichier : sessionTravail.ts
//   Dev : Olivier Bourgault
//   Date: 2021-11-21
//   Projet: JourVie
//------------------------------------------
import { Tache } from './tache';
import { fusoMTL } from './../outils';

export class SessionTravail {
    Id: number = 0;
    TacheId: number = 0;
    TacheNumero: string = '';
    Etat: string = '';
    DevId: number = 0;
    Debut: string = '';
    Fin: string = '';

    //-------------------------------------
    //
    //-------------------------------------

    constructor(tac: Tache, devId: number = 0) {
        this.TacheId = tac.Id;
        this.TacheNumero = tac.Numero;
        this.DevId = devId;
        this.Debut = new Date(fusoMTL()).toISOString();
    }
}