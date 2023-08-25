//------------------------------------------
//   fichier : tache.ts
//   Dev : Olivier Bourgault
//   Date: 2021-11-21
//   Projet: JourVie
//------------------------------------------

export class Tache {
    Id: number;
    ProjetAssocie_Id: number;
    Numero: string;
    Titre: string;
    Statut: string;
    DateDebut: string;
    DerniereModif: string;

    //-------------------------------------
    //
    //-------------------------------------
    
    constructor() {
        this.Id = 0;
        this.ProjetAssocie_Id = 0;
        this.Numero = '0';
        this.Titre = 'inconnu';
        this.Statut = '';
        this.DateDebut = '0000-00-00';
        this.DerniereModif = '0000-00-00';
    }
}