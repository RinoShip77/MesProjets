//------------------------------------------
//   fichier : evenement.ts
//   Dev : Olivier Bourgault
//   Date: 2021-11-21
//   Projet: JourVie
//------------------------------------------

import { tr } from '../outils';
import { Commentaire } from './commentaire';
import { SessionTravail } from './sessionTravail';

export class Evenement {
    Id: number = 0;
    TacheId: number = 0;
    TacheNumero: string = '';
    DevId: number = 0;
    Date: string = '';
    Heure: string = '';
    Type: string = '';
    Contenu: string = '';

    //-------------------------------------
    //
    //-------------------------------------
    
    constructor(st: SessionTravail, traiterDebut = true, commentaire: Commentaire = new Commentaire()) {
        this.TacheId = st.TacheId;
        this.DevId = st.DevId;
        this.TacheNumero = st.TacheNumero;

        if (commentaire.Id === 0) {

            if (traiterDebut) {
                const dateHoro = st.Debut.split(" ");
                this.Date = dateHoro[0];
                this.Heure = dateHoro[1];
                this.Type = 'debut';
            }
            else {
                if (st.Fin === null)
                    return;
                const dateHoro = st.Fin.split(" ");
                this.Date = dateHoro[0];
                this.Heure = dateHoro[1];
                this.Type = 'fin';
            }
        }
        else {
            const dateHoro = commentaire.Horodateur.split(" ");
            this.Date = dateHoro[0];
            this.Heure = dateHoro[1];

            this.Type = 'commentaire';
            this.Contenu = commentaire.Contenu;
        }
    }
}