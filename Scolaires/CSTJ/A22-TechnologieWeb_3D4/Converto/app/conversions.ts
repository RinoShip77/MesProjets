//----------------------------------------
//  Fichier : conversions.ts
//  Développeur: Olivier Bourgault
//  Date: 2022-11-07
//-----------------------------------------

//--------------------------------------------
//Fonction qui va convertir la dimensions dans l'unité initiale sélectionné pour ensuite donner la nouvelle valeur dans l'unité finale visé
//--------------------------------------------
export function convertirDimensions(uniteEntree: string, uniteSortie: string, valeurEntree: number) {
    //On compare l'unité de départ et l'unité de sortie pour faire la bonne conversion, on fait le bon calcul...
    if (uniteEntree === "mm" && uniteSortie === "cm") {
        return valeurEntree / 10;
    }
    if (uniteEntree === "mm" && uniteSortie === "m") {
        return valeurEntree / 1000;
    }
    if (uniteEntree === "mm" && uniteSortie === "km") {
        return valeurEntree / 1000000;
    }
    if (uniteEntree === "mm" && uniteSortie === "pouce") {
        return valeurEntree / 25.4;
    }
    if (uniteEntree === "mm" && uniteSortie === "pied") {
        return valeurEntree / 304.8;
    }
    if (uniteEntree === "mm" && uniteSortie === "verge") {
        return valeurEntree / 914.4;
    }
    if (uniteEntree === "mm" && uniteSortie === "mile") {
        return valeurEntree / 1609344;
    }

    if (uniteEntree === "cm" && uniteSortie === "mm") {
        return valeurEntree * 10;
    }
    if (uniteEntree === "cm" && uniteSortie === "m") {
        return valeurEntree / 100;
    }
    if (uniteEntree === "cm" && uniteSortie === "km") {
        return valeurEntree / 100000;
    }
    if (uniteEntree === "cm" && uniteSortie === "pouce") {
        return valeurEntree / 2.54;
    }
    if (uniteEntree === "cm" && uniteSortie === "pied") {
        return valeurEntree / 30.48;
    }
    if (uniteEntree === "cm" && uniteSortie === "verge") {
        return valeurEntree / 91.44;
    }
    if (uniteEntree === "cm" && uniteSortie === "mile") {
        return valeurEntree / 160934.4;
    }

    if (uniteEntree === "m" && uniteSortie === "mm") {
        return valeurEntree * 1000;
    }
    if (uniteEntree === "m" && uniteSortie === "cm") {
        return valeurEntree * 100;
    }
    if (uniteEntree === "m" && uniteSortie === "km") {
        return valeurEntree / 1000;
    }
    if (uniteEntree === "m" && uniteSortie === "pouce") {
        return valeurEntree * 39.3701;
    }
    if (uniteEntree === "m" && uniteSortie === "pied") {
        return valeurEntree / 0.3048;
    }
    if (uniteEntree === "m" && uniteSortie === "verge") {
        return valeurEntree / 0.9144;
    }
    if (uniteEntree === "m" && uniteSortie === "mile") {
        return valeurEntree / 1609.344;
    }

    if (uniteEntree === "km" && uniteSortie === "mm") {
        return valeurEntree * 1000000;
    }
    if (uniteEntree === "km" && uniteSortie === "cm") {
        return valeurEntree * 100000;
    }
    if (uniteEntree === "km" && uniteSortie === "m") {
        return valeurEntree * 1000;
    }
    if (uniteEntree === "km" && uniteSortie === "pouce") {
        return valeurEntree * 39370.1;
    }
    if (uniteEntree === "km" && uniteSortie === "pied") {
        return valeurEntree * 3280.84167;
    }
    if (uniteEntree === "km" && uniteSortie === "verge") {
        return valeurEntree * 1093.61389;
    }
    if (uniteEntree === "km" && uniteSortie === "mile") {
        return valeurEntree / 1.609344;
    }

    if (uniteEntree === "pouce" && uniteSortie === "mm") {
        return valeurEntree * 25.39999;
    }
    if (uniteEntree === "pouce" && uniteSortie === "cm") {
        return valeurEntree * 2.54;
    }
    if (uniteEntree === "pouce" && uniteSortie === "m") {
        return valeurEntree * 0.0254;
    }
    if (uniteEntree === "pouce" && uniteSortie === "km") {
        return valeurEntree * 0.0000254;
    }
    if (uniteEntree === "pouce" && uniteSortie === "pied") {
        return valeurEntree / 12;
    }
    if (uniteEntree === "pouce" && uniteSortie === "verge") {
        return valeurEntree / 36;
    }
    if (uniteEntree === "pouce" && uniteSortie === "mile") {
        return valeurEntree / 63360;
    }

    if (uniteEntree === "pied" && uniteSortie === "mm") {
        return valeurEntree * 304.79984;
    }
    if (uniteEntree === "pied" && uniteSortie === "cm") {
        return valeurEntree * 30.47998;
    }
    if (uniteEntree === "pied" && uniteSortie === "m") {
        return valeurEntree * 0.3048;
    }
    if (uniteEntree === "pied" && uniteSortie === "km") {
        return valeurEntree * 0.0003;
    }
    if (uniteEntree === "pied" && uniteSortie === "pouce") {
        return valeurEntree * 12;
    }
    if (uniteEntree === "pied" && uniteSortie === "verge") {
        return valeurEntree / 3;
    }
    if (uniteEntree === "pied" && uniteSortie === "mile") {
        return valeurEntree / 5280;
    }

    if (uniteEntree === "verge" && uniteSortie === "mm") {
        return valeurEntree * 914.39951;
    }
    if (uniteEntree === "verge" && uniteSortie === "cm") {
        return valeurEntree * 91.43995;
    }
    if (uniteEntree === "verge" && uniteSortie === "m") {
        return valeurEntree * 0.9144;
    }
    if (uniteEntree === "verge" && uniteSortie === "km") {
        return valeurEntree * 0.0009144;
    }
    if (uniteEntree === "verge" && uniteSortie === "pouce") {
        return valeurEntree * 36;
    }
    if (uniteEntree === "verge" && uniteSortie === "pied") {
        return valeurEntree * 3;
    }
    if (uniteEntree === "verge" && uniteSortie === "mile") {
        return valeurEntree / 1760;
    }

    if (uniteEntree === "mile" && uniteSortie === "mm") {
        return valeurEntree * 1609343.13095;
    }
    if (uniteEntree === "mile" && uniteSortie === "cm") {
        return valeurEntree * 160934.3131;
    }
    if (uniteEntree === "mile" && uniteSortie === "m") {
        return valeurEntree * 1609.34313;
    }
    if (uniteEntree === "mile" && uniteSortie === "km") {
        return valeurEntree * 1.60934;
    }
    if (uniteEntree === "mile" && uniteSortie === "pouce") {
        return valeurEntree * 63360;
    }
    if (uniteEntree === "mile" && uniteSortie === "pied") {
        return valeurEntree * 5280;
    }
    if (uniteEntree === "mile" && uniteSortie === "verge") {
        return valeurEntree * 1760;
    }

    return valeurEntree; //Pour ensuite retourner la bonne valeur
}

//--------------------------------------------
//Fonction qui va convertir le poids dans l'unité initiale sélectionné pour ensuite donner la nouvelle valeur dans l'unité finale visé
//--------------------------------------------
export function convertirPoids(uniteEntree: string, uniteSortie: string, valeurEntree: number) {
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

//--------------------------------------------
//Fonction qui va convertir la température dans l'unité initiale sélectionné pour ensuite donner la nouvelle valeur dans l'unité finale visé
//--------------------------------------------
export function convertirTemperatures(uniteEntree: string, uniteSortie: string, valeurEntree: number) {
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

//--------------------------------------------
//Fonction qui va convertir le montant entré par l'utilisateur pour une année donnée pour ensuite retourner l'équivalent de ce montant lors d'une seconde année
//--------------------------------------------
export function convertirMonnaie(IPCAnnuels: Array<any>, anneeEntree: number, anneeSortie: number, valeurEntree: number) {
    if (anneeEntree < anneeSortie) { //Lorsque l'on veut avancer dans le temps...        
        let somme = 0;
        IPCAnnuels.forEach(ipc => { //On parcours chaque élément du tableau
            if (ipc.an == anneeEntree) {
                somme = valeurEntree * (ipc.taux + 1); //Si l'année correspond à notre année de départ, on initialise la première opération de conversion
            }
        })

        for (let iteration = 1; iteration <= anneeSortie - anneeEntree; iteration++) { //On parcours les années en partant de la plus petite
            let resultat = somme * (IPCAnnuels[iteration].taux + 1);//On effectue la seconde opération avec la valeur contenu lors de cet itération dans la variable
            somme = resultat; //On initiale notre variable locale avec le résultat précédemment obtenu

            if (IPCAnnuels[iteration].an == anneeSortie) {
                return somme; //On retourne la bonne valeur quand on ateint l'année finale
            }
        }
        return valeurEntree;
    } else { //Lorsque l'on veut reculer dans le temps...        
        let somme = 0;
        IPCAnnuels.forEach(ipc => { //On parcours chaque élément du tableau
            if (ipc.an == anneeEntree) {
                somme = valeurEntree / (ipc.taux + 1); //Si l'année correspond à notre année de départ, on initialise la première opération de conversion
            }
        })

        for (let iteration = (IPCAnnuels.length - 2); iteration >= (IPCAnnuels.length - 1) - (anneeEntree - anneeSortie); iteration--) { //On parcours les années en partant de la plus grande
            let resultat = somme / (IPCAnnuels[iteration].taux + 1); //On effectue la seconde opération avec la valeur contenu lors de cet itération dans la variable
            somme = resultat; //On initiale notre variable locale avec le résultat précédemment obtenu

            if (IPCAnnuels[iteration].an == anneeSortie) {
                return somme; //On retourne la bonne valeur quand on ateint l'année finale
            }
        }
        return valeurEntree;
    }
}