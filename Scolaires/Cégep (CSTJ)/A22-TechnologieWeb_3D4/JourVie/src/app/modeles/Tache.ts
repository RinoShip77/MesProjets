//----------------------------------------
//  Fichier: Tache.ts
//  Développeur: Olivier Bourgault
//  Date: 2022-12-14
//  Projet: Jourvie
//-----------------------------------------

export class Tache {
    Id: number;
    IdProjet: number;
    Numero: string;
    Titre: string;
    Description: string;

    constructor(id: number = 0, IdProjet: number = 0, numero: string = "", titre: string = "", description: string = "") {
        this.Id = id;
        this.IdProjet = IdProjet;
        this.Numero = numero;
        this.Titre = titre;
        this.Description = description;
    }
}