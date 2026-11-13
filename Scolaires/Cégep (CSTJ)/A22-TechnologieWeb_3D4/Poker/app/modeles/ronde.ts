//----------------------------------------------
// fichier: ronde.ts
// Dev: Olivier Bourgault
// Date: 2021-11-08
// Projet: Poker
//----------------------------------------------

import { Carte } from "./carte"; //On importe la classe externe
import { Paquet } from "./paquet"; //On importe la classe externe
import { Joueur } from "./joueur"; //On importe la classe externe
import { Evaluateur } from "./evaluateur"; //On importe la classe externe

export class Ronde
{
    //Déclaration d'attributs
    evaluateur:Evaluateur = new Evaluateur;
    paquet:Paquet = new Paquet;
    joueurs:Joueur[] = [];
    joueurGagnant:Joueur = new Joueur;
    flop:Carte[] = [];
    turn:Carte = new Carte(Math.floor(Math.random() * 4), Math.floor(Math.random() * 13));
    river:Carte = new Carte(Math.floor(Math.random() * 4), Math.floor(Math.random() * 13));

    //----------------------------------------------
    //
    //----------------------------------------------

    distrubuerCartes() //Distribue les 8 cartes privées des joueurs, puis les 5 cartes communes (flop, turn, river)
    {
        for(let j = 0; j < 4; j++)
        {
            this.paquet.brasse();
            this.joueurs.push(new Joueur(j + 1, this.paquet.cartesBrassees.splice(0, 2)));
        }

        this.paquet.brasse();
        this.flop = this.paquet.cartesBrassees.splice(0, 3);
    }

    //----------------------------------------------
    //
    //----------------------------------------------

    evaluerMains() //Initialise la valeur de chaque Joueur et les affiche
    {
        for(let j = 0; j < 4; j++)
        {
            let cartesPubliques:Carte[] = [this.flop[Math.floor(Math.random() * this.flop.length)], this.turn, this.river];
            this.joueurs[j].valeur = this.evaluateur.evaluer(this.joueurs[j].cartes.concat(cartesPubliques));
        }
    }

    //----------------------------------------------
    //
    //----------------------------------------------

    determineGagnant() //Trouve le gagnant et affiche le résultat
    {
        this.joueurGagnant.valeur = Math.max(...this.joueurs.map(j => j.valeur));
        this.joueurGagnant.numero = this.joueurs[this.joueurs.findIndex(j => j.valeur === this.joueurGagnant.valeur)].numero;        
    }
}