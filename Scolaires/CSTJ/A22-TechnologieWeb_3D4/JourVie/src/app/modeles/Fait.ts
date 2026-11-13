//----------------------------------------
//  Fichier: Fait.ts
//  Développeur: Olivier Bourgault
//  Date: 2022-12-14
//  Projet: Jourvie
//-----------------------------------------

import { Commentaire } from "./Commentaire";
import { SessionTravail } from "./SessionTravail";

export class Fait {
    Id = 0;
    IdTache = 0;
    TacheNumero = '';
    IdDev = 0;
    Date = '';
    Heure = '';
    Type = '';
    Contenu = '';

    constructor(id: number, sessTrav: SessionTravail, traiteDebut = true, comm: Commentaire = new Commentaire()) {
        this.Id = id;
        this.IdTache = sessTrav.IdTache;
        this.TacheNumero = sessTrav.TacheNumero;
        this.IdDev = sessTrav.IdDev;

        let horoDate;
        if (comm.Contenu.length > 0) {
            horoDate = comm.Horodateur.split(" ");
            this.Type = "commentaire";
            this.Contenu = comm.Contenu;
        }
        else {
            if (traiteDebut) {
                horoDate = sessTrav.Debut.split(" ");
                this.Type = "debut";
            }
            else {
                horoDate = sessTrav.Fin.split(" ");
                this.Type = "fin";
            }
        }
        this.Date = horoDate[0];
        this.Heure = horoDate[1];
    }
}