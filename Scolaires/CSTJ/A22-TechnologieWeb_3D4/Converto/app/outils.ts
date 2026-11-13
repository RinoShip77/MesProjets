//----------------------------------------
//  Fichier : outils.ts
//  Développeur: Olivier Bourgault
//  Date: 2022-11-07
//-----------------------------------------

//--------------------------------------------
//Cette fonction va simplement retourner la valeur passée en paramètre dans la bonne précision 
//--------------------------------------------
export function majPrecision(valeur: number, precision: number) {
  return valeur.toFixed(precision);
}

//--------------------------------------------
//Fonction pour accorder les unités de dimensions
//--------------------------------------------
export function majUniteeDimensions(uniteEntree: string, uniteSortie: string) {
  switch (uniteEntree) {
    case "pouce":
      uniteEntree = "pouces";
      break;
    case "pied":
      uniteEntree = "pieds";
      break;
    case "verge":
      uniteEntree = "verges";
      break;
    case "mile":
      uniteEntree = "miles";
      break;
  }

  switch (uniteSortie) {
    case "pouce":
      uniteSortie = "pouces";
      break;
    case "pied":
      uniteSortie = "pieds";
      break;
    case "verge":
      uniteSortie = "verges";
      break;
    case "mile":
      uniteSortie = "miles";
      break;
  }
}

//--------------------------------------------
//Fonction pour accorder les unités de dimensions
//--------------------------------------------
export function majUniteePoids(uniteEntree: string, uniteSortie: string) {
  switch (uniteEntree) {
    case "tonne mét":
      uniteEntree = "tonnes mét";
      break;
    case "once":
      uniteEntree = "onces";
      break;
    case "livre":
      uniteEntree = "livres";
      break;
    case "tonne courte":
      uniteEntree = "tonnes courtes";
      break;
  }

  switch (uniteSortie) {
    case "tonne mét":
      uniteSortie = "tonnes mét";
      break;
    case "once":
      uniteSortie = "onces";
      break;
    case "livre":
      uniteSortie = "livres";
      break;
    case "tonne courte":
      uniteSortie = "tonnes courtes";
      break;
  }
}