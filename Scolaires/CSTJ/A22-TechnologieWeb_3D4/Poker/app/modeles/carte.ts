//----------------------------------------------
// fichier: carte.ts
// Dev: Olivier Bourgault
// Date: 2021-11-08
// Projet: Poker
//----------------------------------------------

export class Carte
{
  //Déclaration d'attributs
  sorte:number = 0;
  valeur:number = 0;

  //----------------------------------------------
  //
  //----------------------------------------------

  constructor(sorte:number, valeur:number) //Sera le constructeur exécuté lorsque l'on va créer une carte
  {
    this.sorte = sorte;
    this.valeur = valeur;
  }

  //----------------------------------------------
  //
  //----------------------------------------------

  versNomImage() //Sert à définir le nom de l'image d'une carte
  {
    let nom = '';

    switch(this.sorte) //Va définir la sorte de la carte
    {
      case 0:
        nom = 'pique_';
        break;
      case 1:
        nom = 'trefle_';
        break;
      case 2:
        nom = 'carreau_';
        break;
      case 3:
        nom = 'coeur_';
        break;
    }

    switch(this.valeur) //Ajoute la valeur de la carte
    {
      case 0:
        nom += 'deux.gif';
        break;
      case 1:
        nom += 'trois.gif';
        break;
      case 2:
        nom += 'quatre.gif';
        break;
      case 3:
        nom += 'cinq.gif';
        break;
      case 4:
        nom += 'six.gif';
        break;
      case 5:
        nom += 'sept.gif';
        break;
      case 6:
        nom += 'huit.gif';
        break;
      case 7:
        nom += 'neuf.gif';
        break;
      case 8:
        nom += 'dix.gif';
        break;
      case 9:
        nom += 'valet.gif';
        break;
      case 10:
        nom += 'reine.gif';
        break;
      case 11:
        nom += 'roi.gif';
        break;
      case 12:
        nom += 'as.gif';
        break;
    }
    
    return nom;
  }
}