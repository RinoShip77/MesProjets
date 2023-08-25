//------------------------------------------
//   fichier : developpeur.ts
//   Dev : Olivier Bourgault
//   Date: 2021-11-21
//   Projet: JourVie
//------------------------------------------
export class Developpeur {
    Id: number;
    Nom: string;
    Prenom: string;
    Matricule: string;
    MotDePasse: string;
    ProjetAssigne_Id: number;
    Etat: string;
    NomProjet: string;
    NbLogin: number;
    DateCreation: string;
    DateDernierLogon: string;

    //-------------------------------------
    //
    //-------------------------------------
    
    constructor() {
        this.Id = 0;
        this.Nom = '';
        this.Prenom = '';
        this.Matricule = '';
        this.MotDePasse = '';
        this.ProjetAssigne_Id = 0;
        this.Etat = '';
        this.NomProjet = '';
        this.NbLogin = 0;
        this.DateCreation = '0000-00-00 00:00:00';
        this.DateDernierLogon = '0000-00-00 00:00:00';
    }
}