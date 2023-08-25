//----------------------------------------
//  Fichier: Developpeur.ts
//  Développeur: Olivier Bourgault
//  Date: 2022-12-14
//  Projet: Jourvie
//-----------------------------------------

export class Developpeur {
    Id: number;
    Nom: string;
    Prenom: string;
    Matricule: string;
    MotDePasse: string;
    Etat: string;
    IdProjet: number;
    NomProjet: string;
    NbSessions = 0; //Ajout d'un attribut pour connaître le nombre de sessions temps commencé par le développeur
    Duree = ""; //Ajout d'un attribut pour connaître le temps connecté du développeur
    NbCommentaires = 0; //Ajout d'un attribut pour connaître le nombre totale de commentaires du développeur

    constructor(id: number = 0, nom: string = "", prenom: string = "", matricule: string = "", motDePasse: string = "", etat: string = "", IdProjet: number = 0, nomProjet: string = "") {
        this.Id = id;
        this.Nom = nom;
        this.Prenom = prenom;
        this.Matricule = matricule;
        this.MotDePasse = motDePasse;
        this.Etat = etat;
        this.IdProjet = IdProjet;
        this.NomProjet = nomProjet;
    }
}