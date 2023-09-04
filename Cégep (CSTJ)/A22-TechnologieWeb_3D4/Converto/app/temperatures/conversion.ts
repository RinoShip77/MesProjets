//----------------------------------------
//  Fichier : conversion.ts
//  Développeur: Olivier Bourgault
//  Date: 2022-11-07
//-----------------------------------------

//--------------------------------------------
//Fonction qui va convertir la température dans l'unité initiale sélectionné pour ensuite donner la nouvelle valeur dans l'unité finale visé
//--------------------------------------------
export function convertir(uniteEntree: string, uniteSortie: string, valeurEntree: number) {
    //On compare l'unité de départ et l'unité de sortie pour faire la bonne conversion, on fait le bon calcul...
    if (uniteEntree === "Celsius" && uniteSortie === "Fahranheit") {
        return (valeurEntree * 1.8) + 32;
    }
    if (uniteEntree === "Celsius" && uniteSortie === "Kelvin") {
        return valeurEntree + 273.15;
    }

    if (uniteEntree === "Fahranheit" && uniteSortie === "Celsius") {
        return ((valeurEntree - 32) * 5) / 9;
    }
    if (uniteEntree === "Fahranheit" && uniteSortie === "Kelvin") {
        return (((valeurEntree - 32) * 5) / 9) + 273.15;
    }

    if (uniteEntree === "Kelvin" && uniteSortie === "Celsius") {
        return valeurEntree - 273.15;
    }
    if (uniteEntree === "Kelvin" && uniteSortie === "Fahranheit") {
        return ((valeurEntree - 273.15) * 1.8) + 32;
    }

    return valeurEntree; //Pour ensuite retourner la bonne valeur
}