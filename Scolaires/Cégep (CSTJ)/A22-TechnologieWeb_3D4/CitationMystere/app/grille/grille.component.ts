//----------------------------------------
//  Fichier : grille.component.ts
//  Développeur: Olivier Bourgault
//  Date: 2022-10-06
//-----------------------------------------

import { Component, OnInit } from '@angular/core';
import { Caractere } from '../modeles/caractere';

@Component({
  selector: 'app-grille',
  templateUrl: './grille.component.html',
  styleUrls: ['./grille.component.css']
})
export class GrilleComponent implements OnInit {
  //CONSTANTES
  NOMBRE_LIGNES: number = 6; //Définit le nombre de lignes du tableau
  NOMBRE_COLONNES: number = 15; //Définit le nombre de colonnes du tableau

  //VARIABLES
  visible: boolean = false; //Indique la visibilité des grilles
  citation: string = ""; //Elle va conserver la phrase de l'utilisateur

  grille1: Array<Caractere> = []; //Va contenir chaque Caracteres de la citation
  grille1LignesDebut: Array<Array<Caractere>> = []; //Va contenir les lignes de la citation
  grille1LignesFin: Array<Array<Caractere>> = []; //Va contenir les lignes de la citation
  //Déclare les colonnes du tableau
  grille1Colonne1: Array<Caractere> = [];
  grille1Colonne2: Array<Caractere> = [];
  grille1Colonne3: Array<Caractere> = [];
  grille1Colonne4: Array<Caractere> = [];
  grille1Colonne5: Array<Caractere> = [];
  grille1Colonne6: Array<Caractere> = [];
  grille1Colonne7: Array<Caractere> = [];
  grille1Colonne8: Array<Caractere> = [];
  grille1Colonne9: Array<Caractere> = [];
  grille1Colonne10: Array<Caractere> = [];
  grille1Colonne11: Array<Caractere> = [];
  grille1Colonne12: Array<Caractere> = [];
  grille1Colonne13: Array<Caractere> = [];
  grille1Colonne14: Array<Caractere> = [];
  grille1Colonne15: Array<Caractere> = [];

  grille2: Array<Caractere> = []; //Va contenir chaque Caracteres de la citation
  grille2LignesDebut: Array<Array<Caractere>> = []; //Va contenir les lignes de la citation

  //--------------------------------------------
  //Constructeur du module
  //--------------------------------------------
  constructor() { }

  //--------------------------------------------
  //Fonction pour le démarrage du module
  //--------------------------------------------
  ngOnInit(): void {
  }

  //--------------------------------------------
  //Fonction qui va générer les deux grilles du module lorsque la citation est conforme
  //--------------------------------------------
  onCitationValide(citation: string) {
    this.visible = true; //Rend le module visible par l'utilisateur
    this.citation = citation; //Conserve la citation de l'utilisateur dans une variable du programme
    this.creationGrille1(citation); //Appelle la fonction pour créer la première grille
    this.creationGrille2(citation); //Appelle la fonction pour créer la deuxième grille
  }

  //--------------------------------------------
  //Fonction qui appelle plusieurs fonctions internes pour initialiser la première grille
  //--------------------------------------------
  creationGrille1(citation: string) {
    this.creerSeparateur(this.grille1, citation); //Appelle un autre fonction pour établir l'état d'un caractère
    this.creerLignesDebut(this.grille1LignesDebut, this.grille1); //Appelle un autre fonction pour produire les différentes lignes
    this.creerColonnes(this.grille1); //Appelle un autre fonction pour modeler les multiples colonnes
    this.melangerColonnes(); //Appelle un autre fonction pour effectuer un mélange des caractère
    this.creerLignesFin(this.grille1LignesFin); //Appelle un autre fonction pour faire les lignes finale
  }

  //--------------------------------------------
  //Fonction pour matérialiser la deuxième grille
  //--------------------------------------------
  creationGrille2(citation: string) {
    this.creerSeparateur(this.grille2, citation); //Va définir la fonction du caractère
    this.creerLignesDebut(this.grille2LignesDebut, this.grille2); //Ajuste la taille pour avoir les même proportions que l'autre grille
  }

  //--------------------------------------------
  //Fonction pour créer les lignes initiales
  //--------------------------------------------
  creerLignesDebut(lignesDebut: Array<Array<Caractere>>, grilleDebut: Array<Caractere>) {
    for (let ligne = 0; ligne <= this.NOMBRE_LIGNES; ligne++) { //Va itérer selon le nombre de lignes
      let debut = this.NOMBRE_COLONNES * ligne; //Définit l'indice de départ
      let fin = this.NOMBRE_COLONNES * (ligne + 1); //Déclare la position à laquelle on doit s'arrêter

      if (grilleDebut.slice(debut, fin).length !== 0) { //Si la longueur du segment est de zéro, ...
        lignesDebut.push(grilleDebut.slice(debut, fin)); //On ajoute ce segment dans le tableau des ligne initiales
      }
    }
  }

  //--------------------------------------------
  //Foonction pour afficher la citation à l'écran
  //--------------------------------------------
  afficherCitation() {
    alert("Citation:\n" + this.citation); //Affiche la citation à l'écran
  }

  //--------------------------------------------
  //Fonction qui va recharger la page pour permettre de faire une nouvelle partie
  //--------------------------------------------
  rejouer() {
    window.location.reload(); //Va forcer la page à recharger pour ainsi saisir une nouvelle citation
  }

  //--------------------------------------------
  //Fonction qui va définir si le caractères est un séparateurs de mots et n'afficher qu'un seule séparateur s'il y en a deux de suite
  //--------------------------------------------
  creerSeparateur(grille: Array<Caractere>, citation: string) {
    this.separateurDeMots(grille, citation); //Appelle la fonction qui va définir l'état des caractère

    for (let caractere = 0; caractere < grille.length - 1; caractere++) { //Va itérer sur chaque élément de la grille
      if (grille[caractere].Etat === "separateur" && grille[caractere + 1].Etat === "separateur") { //Si le caractère courant et le suivant sont des séparateurs de mots, ...
        grille.splice(caractere + 1, 1); //Retire l'élément courant du tableau
      }
    }
  }

  //--------------------------------------------
  //Fonction qui va créer les colonnes pour la première grille
  //--------------------------------------------
  creerColonnes(grille: Array<Caractere>) {
    for (let ligne = 0; ligne < this.NOMBRE_LIGNES; ligne++) { //Boucle pour chaqu'une des lignes
      if ((this.citation.length - (this.NOMBRE_COLONNES * ligne)) > 0) { //S'il reste des caractères, ...
        //On appelle la fonction avec les bon paramètres
        this.creerColonne(this.grille1Colonne1, grille, ligne, 0);
        this.creerColonne(this.grille1Colonne2, grille, ligne, 1);
        this.creerColonne(this.grille1Colonne3, grille, ligne, 2);
        this.creerColonne(this.grille1Colonne4, grille, ligne, 3);
        this.creerColonne(this.grille1Colonne5, grille, ligne, 4);
        this.creerColonne(this.grille1Colonne6, grille, ligne, 5);
        this.creerColonne(this.grille1Colonne7, grille, ligne, 6);
        this.creerColonne(this.grille1Colonne8, grille, ligne, 7);
        this.creerColonne(this.grille1Colonne9, grille, ligne, 8);
        this.creerColonne(this.grille1Colonne10, grille, ligne, 9);
        this.creerColonne(this.grille1Colonne11, grille, ligne, 10);
        this.creerColonne(this.grille1Colonne12, grille, ligne, 11);
        this.creerColonne(this.grille1Colonne13, grille, ligne, 12);
        this.creerColonne(this.grille1Colonne14, grille, ligne, 13);
        this.creerColonne(this.grille1Colonne15, grille, ligne, 14);
      }
    }
  }

  //--------------------------------------------
  //Fonction qui va s'occuper de faire la colonne de départ
  //--------------------------------------------
  creerColonne(colonne: Array<Caractere>, grille: Array<Caractere>, ligne: number, position: number) {
    colonne.push(grille[(this.NOMBRE_COLONNES * ligne) + position]); //Initialise la colonne avec le bon segment

    if (colonne[ligne] === undefined) { //Si l'élément n'existe pas, ...
      colonne.splice(ligne, 1); //On retire l'élément
    }
  }

  //--------------------------------------------
  //Fonction qui va appeler une autre fonction pour mélanger
  //--------------------------------------------
  melangerColonnes() {
    //On appelle la fonction en passant la colonne correspondante en paramètre
    this.melangerColonne(this.grille1Colonne1);
    this.melangerColonne(this.grille1Colonne2);
    this.melangerColonne(this.grille1Colonne3);
    this.melangerColonne(this.grille1Colonne4);
    this.melangerColonne(this.grille1Colonne5);
    this.melangerColonne(this.grille1Colonne6);
    this.melangerColonne(this.grille1Colonne7);
    this.melangerColonne(this.grille1Colonne8);
    this.melangerColonne(this.grille1Colonne9);
    this.melangerColonne(this.grille1Colonne10);
    this.melangerColonne(this.grille1Colonne11);
    this.melangerColonne(this.grille1Colonne12);
    this.melangerColonne(this.grille1Colonne13);
    this.melangerColonne(this.grille1Colonne14);
    this.melangerColonne(this.grille1Colonne15);
  }

  //--------------------------------------------
  //Algorithme pour mélanger les caractèeres dans un tableau
  //--------------------------------------------
  melangerColonne(colonne: Array<Caractere>) {
    for (var i = colonne.length - 1; i > 0; i--) { //Va répéter le code sur la longueur de la citation
      var index = Math.floor(Math.random() * (i + 1)); //Va générer un nombre aléatoire
      [colonne[i], colonne[index]] = [colonne[index], colonne[i]]; //Attribut la nouvelle position à l'ancienne élément
    }
  }

  //--------------------------------------------
  //Fonction qui appelle une autre fonction pour les lignes finales
  //--------------------------------------------
  creerLignesFin(lignesFin: Array<Array<Caractere>>) {
    for (let ligne = 0; ligne < this.NOMBRE_LIGNES; ligne++) { //Va s'exécuter selon le nombre de lignes
      this.creerLigneFin(ligne, lignesFin) //Appelle la fonction dédiée
    }

    this.casesLignesNulle(lignesFin); //Appelle une seconde fonction
  }

  //--------------------------------------------
  //Fonction qui va assembler les lignes finales
  //--------------------------------------------
  creerLigneFin(ligne: number, lignesFin: Array<Array<Caractere>>) {
    let ligneFin: Caractere[] = new Array(); //Déclare et initialise un tableau temporaire

    //On met l'élément de la colonne correspondante dans le tableau temporaire
    ligneFin.push(this.grille1Colonne1[ligne]);
    ligneFin.push(this.grille1Colonne2[ligne]);
    ligneFin.push(this.grille1Colonne3[ligne]);
    ligneFin.push(this.grille1Colonne4[ligne]);
    ligneFin.push(this.grille1Colonne5[ligne]);
    ligneFin.push(this.grille1Colonne6[ligne]);
    ligneFin.push(this.grille1Colonne7[ligne]);
    ligneFin.push(this.grille1Colonne8[ligne]);
    ligneFin.push(this.grille1Colonne9[ligne]);
    ligneFin.push(this.grille1Colonne10[ligne]);
    ligneFin.push(this.grille1Colonne11[ligne]);
    ligneFin.push(this.grille1Colonne12[ligne]);
    ligneFin.push(this.grille1Colonne13[ligne]);
    ligneFin.push(this.grille1Colonne14[ligne]);
    ligneFin.push(this.grille1Colonne15[ligne]);

    lignesFin.push(ligneFin); //On finit par ajouter le tableau temporaire au tableau passée en paramètre
  }

  //--------------------------------------------
  //Fonction qui va s'occuper des caractères qui ne sont pas encore identifiés
  //--------------------------------------------
  casesLignesNulle(lignesFin: Array<Array<Caractere>>) {
    for (let ligne = 0; ligne < this.NOMBRE_LIGNES; ligne++) { //Itère sur chaque lignes
      for (let colonne = 0; colonne < this.NOMBRE_COLONNES; colonne++) { //Itère sur chaque colonnes
        if (lignesFin[ligne][colonne] === undefined) { //Si l'élément donné n'est pas définit, ... 
          lignesFin[ligne][colonne] = new Caractere(); //On initialise cet élément comme étant un nouveau caractère vide
        }
      }
    }
  }

  //--------------------------------------------
  //Fontion qui va déterminer l'état de chaque caractère pour savoir si c'est un séparateur de mots ou non
  //--------------------------------------------
  separateurDeMots(grille: Array<Caractere>, citation: string) {
    for (let caractere = 0; caractere < citation.length; caractere++) { //Va boucler sur chaque lettre de la citation
      grille.push(new Caractere(citation[caractere].toUpperCase())); //Initialise le tableau locale avec les caractères de la citation et en les mettant en majuscules

      //Va exécuter un bout de code selon la valeur du caractère courant
      switch (grille[caractere].Valeur) {  //Définit l'état du caractère selon la valeur de celui-ci, ...
        case " ": //Un espace
          grille[caractere].Etat = "separateur";
          break;
        case "'": //Un apostrophe
          grille[caractere].Etat = "separateur";
          break;
        case "-": //Un trait d'union
          grille[caractere].Etat = "separateur";
          break;
        case ".": //Un point final
          grille[caractere].Etat = "separateur";
          break;
        case "!": //Un point d'exclamation
          grille[caractere].Etat = "separateur";
          break;
        case "?": //Un point d'interrogation
          grille[caractere].Etat = "separateur";
          break;
        case ":": //Des deux-points
          grille[caractere].Etat = "separateur";
          break;
        case "...": //Des points de suspension
          grille[caractere].Etat = "separateur";
          break;
        case ";": //Un point-virgule
          grille[caractere].Etat = "separateur";
          break;
        case ",": //Une virgule
          grille[caractere].Etat = "separateur";
          break;
        case "’": //Un guillemet simple
          grille[caractere].Etat = "separateur";
          break;
        case '"': //Des guillemets doubles
          grille[caractere].Etat = "separateur";
          break;
        case "*": //Un astérisque
          grille[caractere].Etat = "separateur";
          break;
        case "~": //Un tilde
          grille[caractere].Etat = "separateur";
          break;
        default: //Si la valeur du caractère ne correspond à aucun des cas précédents, on fait le cas par défaut
          grille[caractere].Etat = "nonSeparateur";
      }
    }
  }
}