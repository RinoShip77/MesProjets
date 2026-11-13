//----------------------------------------------
// fichier: paquet.ts
// Dev: Olivier Bourgault
// Date: 2021-11-08
// Projet: Poker
//----------------------------------------------

import { Carte } from "./carte"; //On importe la classe externe

export class Paquet
{
    //Déclaration d'attributs
    cartes:Carte[] = []; //Tableau de carte
    cartesBrassees:Carte[] = []; //Tableau de carte qui a été mélangé
    curseur:number = 0; //Indique la prochaine carte à distribuer, commence à 0 et augmente à chaque carte distribuée

    //----------------------------------------------
    //
    //----------------------------------------------

    constructor() //Initialisation du paquet
    {
        for(let sorte = 0; sorte < 4; sorte++) //Boucle pour choisir une sorte de carte différente à chaque itération
        {
           for(let valeur = 0; valeur < 13; valeur++) //Boucle pour définir la valeur d'une carte différente à chaque itération
           {
               this.cartes.push(new Carte(sorte, valeur)); //Ajoute une nouvelle carte au tableau
           }
        }
    }

    //----------------------------------------------
    //
    //----------------------------------------------

    brasse() //Mélange les 52 cartes
    {
        let tableauValeurChoisie:number[] = new Array(); //Initialisation d'un tableau de nombres
        
        for (let i = 0; i < 52; i++)
        {
            tableauValeurChoisie[i] = -1;
        }

        let trouveProchaine:boolean;

        for (let i = 0; i < 52; i++) 
        {
            trouveProchaine = false;

            while (!trouveProchaine)
            {
                let indice:number = -1;
                let aleaTmp:number = Math.floor(Math.random() * 52);
                let etat:string = '';

                for (let j=0; j < 52; j++)
                {
                    if (tableauValeurChoisie[j] == -1)
                    {   
                        indice = j;
                        etat = "OK";      
                        break;                        
                    }    
                    else if (tableauValeurChoisie[j] == aleaTmp)
                    {
                        etat = "DEJA_PRIS";
                        break;
                    }    
                }
                if (etat == "OK")
                {
                    tableauValeurChoisie[indice] = aleaTmp;
                    trouveProchaine = true;
                }  
            }
        }
        for (let i = 0; i < 52; i++) 
        {    
            this.cartesBrassees[i] = this.cartes[tableauValeurChoisie[i]];
        }
    }

    //----------------------------------------------
    //
    //----------------------------------------------

    distribue() //Retourne la carte du curseur actuel et déplace le curseur vers la prochaine Carte
    {
        this.brasse(); //Brasse le paquet de cartes
        this.curseur++; //Incrémente le curseur        
        
        return this.cartesBrassees[this.curseur]; //Retourne la carte
    }
}