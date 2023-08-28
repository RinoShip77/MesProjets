//----------------------------------------------
// fichier: evaluateur.ts
// Dev: Olivier Bourgault
// Date: 2021-11-08
// Projet: Poker
//----------------------------------------------

import { Carte } from './carte'; //On importe la classe externe

export class Evaluateur
{
    evaluer(main:Carte[])
    {
        main.sort(this.trieSelonValeur); //On commence par trier la main selon les valeurs de ses cartes
        
        if (this.quinteFlush(main)) //Si c'est une quinte flush, ...
        {
            return 371292;
        }

        if (this.carre(main)) //Si c'est un carré, ...
        {
            return 342731;
        }
        
        if (this.full(main)) //Si c'est une full, ...
        {
            return 340534;
        }

        if (this.couleur(main)) //Si c'est une suite de couleurs, ...
        {
            return 330010;
        }
        
        if (this.quinte(main)) //Si c'est une quinte, ...
        {
            return 325682;
        }
        
        if (this.brelan(main)) //Si c'est un brelan, ...
        {
            return 311973;
        }
        
        if (this.doublePaires(main)) //Si c'est une double paires, ...
        {
            return 301804;
        }
        
        if (this.paire(main)) //Si c'est une paire, ...
        {
            return 281046;
        }
        
        if (this.carteLaPlusForte(main)) //Si c'est un cas de carte la plus forte, ...
        {
            return 267645;
        }
        
        return 0;
    }
    
    //----------------------------------------------
    //
    //----------------------------------------------
    
    trieSelonValeur(carte1:Carte, carte2:Carte) //Compare la valeur des deux cartes
    {
        if (carte1.valeur < carte2.valeur) //Si la valeur de la carte 1 est plus petite que celle de la carte 2, ...
        {
            return 1;
        }
        
        if (carte1.valeur > carte2.valeur) //Si la valeur de la carte 1 est plus grande que celle de la carte 2, ...
        {
            return -1;
        }
        
        return 0;
    }
    
    //----------------------------------------------
    //
    //----------------------------------------------

    quinteFlush(main:Carte[]) //Vérifie si le joueur détient une quinte flush
    {
        const sorte = main[0].sorte;

        if (main.every(c => c.sorte === sorte) && main[0].valeur === (main[1].valeur + 1) && main[1].valeur === (main[2].valeur + 1) && main[2].valeur === (main[3].valeur + 1) && main[3].valeur === (main[4].valeur + 1)) //Si la sorte des cartes est la même et que les valeurs des cartes se suivent, ..., ...
        {
            return true;
        }

        return false;
    }

    //----------------------------------------------
    //
    //----------------------------------------------
    
    carre(main:Carte[]) //Vérifie si la main est un carré
    {
        if ((main[0].valeur === main[1].valeur && main[1].valeur === main[2].valeur && main[2].valeur === main[3].valeur) || (main[1].valeur === main[2].valeur && main[2].valeur === main[3].valeur && main[3].valeur === main[4].valeur)) //Si la main est constitué de quatre cartes de même valeurs, ...
        {
            return true;
        }

        return false;
    }

    //----------------------------------------------
    //
    //----------------------------------------------

    full(main:Carte[]) //Vérifie si la valeur représente une full
    {
        if (this.brelan(main) && this.paire(main)) //Si la main est constitué d'un brelan et d'une paire, ...
        {
            return true;
        }

        return false;
    }

    //----------------------------------------------
    //
    //----------------------------------------------
    
    couleur(main:Carte[]) //Vérifie si la main est une suite de couleurs
    {
        const sorte = main[0].sorte;

        if (main.every(c => c.sorte === sorte)) //Si la sorte de la carte est la même, ...
        {
            return true;
        }

        return false;
    }

    //----------------------------------------------
    //
    //----------------------------------------------

    quinte(main:Carte[]) //Vérifie si la main correspond à une quinte
    {
        if (main[0].valeur === (main[1].valeur + 1) && main[1].valeur === (main[2].valeur + 1) && main[2].valeur === (main[3].valeur + 1) && main[3].valeur === (main[4].valeur + 1)) //Si les valeurs des carte se suivent, ...
        {
            return true;
        }

        return false;
    }
    
    //----------------------------------------------
    //
    //----------------------------------------------
    
    brelan(main:Carte[]) //Vérifie si la valeur de la main est un brelan
    {
        if((main[0].valeur === main[1].valeur && main[1].valeur === main[2].valeur) || (main[1].valeur === main[2].valeur && main[2].valeur === main[3].valeur) || (main[2].valeur === main[3].valeur && main[3].valeur === main[4].valeur)) //Si la main a trois cartes de la même valeur, ...
        {
            return true;
        }

        return false;
    }
    
    //----------------------------------------------
    //
    //----------------------------------------------
    
    doublePaires(main:Carte[]) //Vérifie si la main est composé d'une double paires
    {
        if((main[0].valeur === main[1].valeur && main[2].valeur === main[3].valeur) || (main[1].valeur === main[2].valeur && main[3].valeur === main[4].valeur) || (main[0].valeur === main[1].valeur && main[3].valeur === main[4].valeur)) //Si la main a deux cartes de la même valeur ainsi que deux cartes d'une autre valeur, ...
        {
            return true;
        }

        return false;
    }
    
    //----------------------------------------------
    //
    //----------------------------------------------
    
    paire(main:Carte[]) //Vérifie si la valeur correspond à une paire
    {
        if(main[0].valeur === main[1].valeur || main[1].valeur === main[2].valeur || main[2].valeur === main[3].valeur || main[3].valeur === main[4].valeur) //Si la main a deux cartes de la même valeur, ...
        {
            return true;
        }

        return false;
    }
    
    //----------------------------------------------
    //
    //----------------------------------------------
    
    carteLaPlusForte(main:Carte[]) //Vérifie si la main détient la carte la plus forte
    {
        if(!this.quinteFlush && !this.carre && !this.full && !this.couleur && !this.quinte && !this.brelan && !this.doublePaires && !this.paire) //Si la main ne correspond à aucune autre combinaison possible, ...
        {
            return true;
        }
        
        return false;
    }
}