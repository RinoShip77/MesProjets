//----------------------------------------
//  Fichier : conversion.ts
//  Développeur: Olivier Bourgault
//  Date: 2022-11-07
//-----------------------------------------

//--------------------------------------------
//Fonction qui va convertir le poids dans l'unité initiale sélectionné pour ensuite donner la nouvelle valeur dans l'unité finale visé
//--------------------------------------------
export function convertir(uniteEntree: string, uniteSortie: string, valeurEntree: number) {
    //On compare l'unité de départ et l'unité de sortie pour faire la bonne conversion, on fait le bon calcul...
    if (uniteEntree === "g" && uniteSortie === "kg") {
        return valeurEntree / 1000;
    }
    if (uniteEntree === "g" && uniteSortie === "tonne mét") {
        return valeurEntree / 1000000;
    }
    if (uniteEntree === "g" && uniteSortie === "once") {
        return valeurEntree * 0.03527;
    }
    if (uniteEntree === "g" && uniteSortie === "livre") {
        return valeurEntree / 453.59237;
    }
    if (uniteEntree === "g" && uniteSortie === "tonne courte") {
        return valeurEntree / 907184.74;
    }

    if (uniteEntree === "kg" && uniteSortie === "g") {
        return valeurEntree * 1000;
    }
    if (uniteEntree === "kg" && uniteSortie === "tonne mét") {
        return valeurEntree / 1000;
    }
    if (uniteEntree === "kg" && uniteSortie === "once") {
        return valeurEntree * 35.27392;
    }
    if (uniteEntree === "kg" && uniteSortie === "livre") {
        return valeurEntree / 0.45359237;
    }
    if (uniteEntree === "kg" && uniteSortie === "tonne courte") {
        return valeurEntree / 907.18474;
    }

    if (uniteEntree === "tonne mét" && uniteSortie === "g") {
        return valeurEntree * 1000000;
    }
    if (uniteEntree === "tonne mét" && uniteSortie === "kg") {
        return valeurEntree * 1000;
    }
    if (uniteEntree === "tonne mét" && uniteSortie === "once") {
        return valeurEntree * 35273.92;
    }
    if (uniteEntree === "tonne mét" && uniteSortie === "livre") {
        return valeurEntree * 2204.62;
    }
    if (uniteEntree === "tonne mét" && uniteSortie === "tonne courte") {
        return valeurEntree / 0.90718474;
    }

    if (uniteEntree === "once" && uniteSortie === "g") {
        return valeurEntree * 28.3495231;
    }
    if (uniteEntree === "once" && uniteSortie === "kg") {
        return valeurEntree * 0.0283495231;
    }
    if (uniteEntree === "once" && uniteSortie === "tonne mét") {
        return valeurEntree * 0.0000283495231;
    }
    if (uniteEntree === "once" && uniteSortie === "livre") {
        return valeurEntree / 16;
    }
    if (uniteEntree === "once" && uniteSortie === "tonne courte") {
        return valeurEntree * 0.00003;
    }

    if (uniteEntree === "livre" && uniteSortie === "g") {
        return valeurEntree * 453.59237;
    }
    if (uniteEntree === "livre" && uniteSortie === "kg") {
        return valeurEntree * 0.45359237;
    }
    if (uniteEntree === "livre" && uniteSortie === "tonne mét") {
        return valeurEntree * 0.00045359237;
    }
    if (uniteEntree === "livre" && uniteSortie === "once") {
        return valeurEntree * 16;
    }
    if (uniteEntree === "livre" && uniteSortie === "tonne courte") {
        return valeurEntree / 2000;
    }

    if (uniteEntree === "tonne courte" && uniteSortie === "g") {
        return valeurEntree * 907185.81887;
    }
    if (uniteEntree === "tonne courte" && uniteSortie === "kg") {
        return valeurEntree * 907.18582;
    }
    if (uniteEntree === "tonne courte" && uniteSortie === "tonne mét") {
        return valeurEntree * 0.90719;
    }
    if (uniteEntree === "tonne courte" && uniteSortie === "once") {
        return valeurEntree * 32000;
    }
    if (uniteEntree === "tonne courte" && uniteSortie === "livre") {
        return valeurEntree * 2000;
    }

    return valeurEntree; //Pour ensuite retourner la bonne valeur
}