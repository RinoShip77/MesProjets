//----------------------------------------------
// fichier: joueur.ts
// Dev: Olivier Bourgault
// Date: 2021-11-08
// Projet: Poker
//----------------------------------------------

import { Carte } from "./carte"; //On importe la classe externe

export class Joueur
{
    //Déclaration d'attributs
    numero:number = 1;
    cartes:Carte[] = [];
    valeur = 0; //Valeur de la meilleure main possible de 5 cartes avec les sept cartes disponibles

    //----------------------------------------------
    //
    //----------------------------------------------

    constructor(numero:number = 1, cartes:Carte[] = [])
    {
        this.numero = numero;
        this.cartes = cartes;
    }

    //----------------------------------------------
    //
    //----------------------------------------------

    valeurEnFrancais() //Conversion en français de la valeur de la main du joueur
    {
        let valeurEnFrancais = ''; 

        switch(this.valeur) //Ajoute la valeur de la carte
        {
            case 371292:
                valeurEnFrancais += 'une quinte flush';
                break;
            case 342731:
                valeurEnFrancais += 'un carré';
                break;
            case 340534:
                valeurEnFrancais += 'une full';
                break;
            case 330010:
                valeurEnFrancais += 'une couleur';
                break;
            case 325682:
                valeurEnFrancais += 'une quinte';
                break;
            case 311973:
                valeurEnFrancais += 'un brelan';
                break;
            case 301804:
                valeurEnFrancais += 'une doubles paires';
                break;
            case 281046:
                valeurEnFrancais += 'une paire';
                break;
            default:
                valeurEnFrancais += 'la carte la plus forte';
                break;
        }
    
        return valeurEnFrancais;
    }
}