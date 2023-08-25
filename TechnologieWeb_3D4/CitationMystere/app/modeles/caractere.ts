//----------------------------------------
//  Fichier : caractere.ts
//  Développeur: Olivier Bourgault
//  Date: 2022-10-06
//-----------------------------------------

//--------------------------------------------
//Déclaration d'une classe locale au projet
//--------------------------------------------
export class Caractere { //Rend la classe accessible de l'extérieur
    Valeur: string; //Déclare un attribut pour savoir de quel lettre il s'agit
    Etat: string; //Attribut qui va indiquer si le caractère est un séparateur de mots ou non

    //--------------------------------------------
    //Définition du constructeur pour initialiser les attributs de l'objet lors d'une instance
    //--------------------------------------------
    constructor(valeur: string = "", etat: string = "") {
        this.Valeur = valeur; //Assigne la valeur passé en paramètre au caractère
        this.Etat = etat; //Donne l'état voulu au caractère
    }
}