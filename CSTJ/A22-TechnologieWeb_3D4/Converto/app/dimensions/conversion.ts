//----------------------------------------
//  Fichier : conversion.ts
//  Développeur: Olivier Bourgault
//  Date: 2022-11-07
//-----------------------------------------

//--------------------------------------------
//Fonction qui va convertir la longueur d'une dimension dans l'unité initiale sélectionné pour ensuite donner la nouvelle valeur dans l'unité finale visé
//--------------------------------------------
export function convertir1D(uniteEntree: string, uniteSortie: string, valeurEntree: number) {
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
//Fonction qui va convertir la longueur de deux dimensions dans l'unité initiale sélectionné pour ensuite donner la nouvelle valeur dans l'unité finale visé
//--------------------------------------------
export function convertir2D(uniteEntree: string, uniteSortie: string, valeurEntree_2: number) {
    //On compare l'unité de départ et l'unité de sortie pour faire la bonne conversion, on fait le bon calcul...
    if (uniteEntree === "mm" && uniteSortie === "cm") {
        return valeurEntree_2 / 100;
    }
    if (uniteEntree === "mm" && uniteSortie === "m") {
        return valeurEntree_2 / 1000000;
    }
    if (uniteEntree === "mm" && uniteSortie === "km") {
        return valeurEntree_2 / 1000000000000;
    }
    if (uniteEntree === "mm" && uniteSortie === "pouce") {
        return valeurEntree_2 / 645.2;
    }
    if (uniteEntree === "mm" && uniteSortie === "pied") {
        return valeurEntree_2 / 92900;
    }
    if (uniteEntree === "mm" && uniteSortie === "verge") {
        return valeurEntree_2 / 836100;
    }
    if (uniteEntree === "mm" && uniteSortie === "mile") {
        return valeurEntree_2 / 2589988110336;
    }

    if (uniteEntree === "cm" && uniteSortie === "mm") {
        return valeurEntree_2 * 100;
    }
    if (uniteEntree === "cm" && uniteSortie === "m") {
        return valeurEntree_2 / 10000;
    }
    if (uniteEntree === "cm" && uniteSortie === "km") {
        return valeurEntree_2 / 10000000000;
    }
    if (uniteEntree === "cm" && uniteSortie === "pouce") {
        return valeurEntree_2 * 0.15500;
    }
    if (uniteEntree === "cm" && uniteSortie === "pied") {
        return valeurEntree_2 / 929;
    }
    if (uniteEntree === "cm" && uniteSortie === "verge") {
        return valeurEntree_2 / 8361;
    }
    if (uniteEntree === "cm" && uniteSortie === "mile") {
        return valeurEntree_2 / 25899881103.36;
    }

    if (uniteEntree === "m" && uniteSortie === "mm") {
        return valeurEntree_2 * 1000000;
    }
    if (uniteEntree === "m" && uniteSortie === "cm") {
        return valeurEntree_2 * 10000;
    }
    if (uniteEntree === "m" && uniteSortie === "km") {
        return valeurEntree_2 / 1000000;
    }
    if (uniteEntree === "m" && uniteSortie === "pouce") {
        return valeurEntree_2 * 1550.00477;
    }
    if (uniteEntree === "m" && uniteSortie === "pied") {
        return valeurEntree_2 * 10.76392;
    }
    if (uniteEntree === "m" && uniteSortie === "verge") {
        return valeurEntree_2 * 1.1959900463011;
    }
    if (uniteEntree === "m" && uniteSortie === "mile") {
        return valeurEntree_2 / 2589988.11034;
    }

    if (uniteEntree === "km" && uniteSortie === "mm") {
        return valeurEntree_2 * 1000000000000;
    }
    if (uniteEntree === "km" && uniteSortie === "cm") {
        return valeurEntree_2 * 10000000000;
    }
    if (uniteEntree === "km" && uniteSortie === "m") {
        return valeurEntree_2 * 1000000;
    }
    if (uniteEntree === "km" && uniteSortie === "pouce") {
        return valeurEntree_2 * 1550004774.01000;
    }
    if (uniteEntree === "km" && uniteSortie === "pied") {
        return valeurEntree_2 * 10763922.04174;
    }
    if (uniteEntree === "km" && uniteSortie === "verge") {
        return valeurEntree_2 * 1195991.33797;
    }
    if (uniteEntree === "km" && uniteSortie === "mile") {
        return valeurEntree_2 / 2.589988110336;
    }

    if (uniteEntree === "pouce" && uniteSortie === "mm") {
        return valeurEntree_2 * 645.15930;
    }
    if (uniteEntree === "pouce" && uniteSortie === "cm") {
        return valeurEntree_2 * 6.45159;
    }
    if (uniteEntree === "pouce" && uniteSortie === "m") {
        return valeurEntree_2 / 1550.0031;
    }
    if (uniteEntree === "pouce" && uniteSortie === "km") {
        return valeurEntree_2 / 1550003100.0062;
    }
    if (uniteEntree === "pouce" && uniteSortie === "pied") {
        return valeurEntree_2 / 144.00001;
    }
    if (uniteEntree === "pouce" && uniteSortie === "verge") {
        return valeurEntree_2 / 1296.0001;
    }
    if (uniteEntree === "pouce" && uniteSortie === "mile") {
        return valeurEntree_2 / 4014489921.1592;
    }

    if (uniteEntree === "pied" && uniteSortie === "mm") {
        return valeurEntree_2 * 92902.93966;
    }
    if (uniteEntree === "pied" && uniteSortie === "cm") {
        return valeurEntree_2 * 929.02940;
    }
    if (uniteEntree === "pied" && uniteSortie === "m") {
        return valeurEntree_2 * 0.09290304;
    }
    if (uniteEntree === "pied" && uniteSortie === "km") {
        return valeurEntree_2 / 10763910.41671;
    }
    if (uniteEntree === "pied" && uniteSortie === "pouce") {
        return valeurEntree_2 * 144.00000;
    }
    if (uniteEntree === "pied" && uniteSortie === "verge") {
        return valeurEntree_2 / 9;
    }
    if (uniteEntree === "pied" && uniteSortie === "mile") {
        return valeurEntree_2 / 27878400;
    }

    if (uniteEntree === "verge" && uniteSortie === "mm") {
        return valeurEntree_2 * 836126.45698;
    }
    if (uniteEntree === "verge" && uniteSortie === "cm") {
        return valeurEntree_2 * 8361.26457;
    }
    if (uniteEntree === "verge" && uniteSortie === "m") {
        return valeurEntree_2 * 0.83612736;
    }
    if (uniteEntree === "verge" && uniteSortie === "km") {
        return valeurEntree_2 * 0.00000083612736;
    }
    if (uniteEntree === "verge" && uniteSortie === "pouce") {
        return valeurEntree_2 * 1296;
    }
    if (uniteEntree === "verge" && uniteSortie === "pied") {
        return valeurEntree_2 * 9;
    }
    if (uniteEntree === "verge" && uniteSortie === "mile") {
        return valeurEntree_2 * 0.0000003228;
    }

    if (uniteEntree === "mile" && uniteSortie === "mm") {
        return valeurEntree_2 * 2589985313151.10693;
    }
    if (uniteEntree === "mile" && uniteSortie === "cm") {
        return valeurEntree_2 * 25899853131.51106;
    }
    if (uniteEntree === "mile" && uniteSortie === "m") {
        return valeurEntree_2 * 2589985.31315;
    }
    if (uniteEntree === "mile" && uniteSortie === "km") {
        return valeurEntree_2 * 2.58998811;
    }
    if (uniteEntree === "mile" && uniteSortie === "pouce") {
        return valeurEntree_2 * 4014489600;
    }
    if (uniteEntree === "mile" && uniteSortie === "pied") {
        return valeurEntree_2 * 27878400;
    }
    if (uniteEntree === "mile" && uniteSortie === "verge") {
        return valeurEntree_2 * 3097600;
    }

    return valeurEntree_2; //Pour ensuite retourner la bonne valeur
}

//--------------------------------------------
//Fonction qui va convertir la longueur de trois dimensions dans l'unité initiale sélectionné pour ensuite donner la nouvelle valeur dans l'unité finale visé
//--------------------------------------------
export function convertir3D(uniteEntree: string, uniteSortie: string, valeurEntree_3: number) {
    //On compare l'unité de départ et l'unité de sortie pour faire la bonne conversion, on fait le bon calcul...
    if (uniteEntree === "mm" && uniteSortie === "cm") {
        return valeurEntree_3 / 1000;
    }
    if (uniteEntree === "mm" && uniteSortie === "m") {
        return valeurEntree_3 / 1000000000;
    }
    if (uniteEntree === "mm" && uniteSortie === "km") {
        return valeurEntree_3 / 1000000000000000000;
    }
    if (uniteEntree === "mm" && uniteSortie === "pouce") {
        return valeurEntree_3 / 16387.064;
    }
    if (uniteEntree === "mm" && uniteSortie === "pied") {
        return valeurEntree_3 / 28316846.592;
    }
    if (uniteEntree === "mm" && uniteSortie === "verge") {
        return valeurEntree_3 / 764554857.984;
    }
    if (uniteEntree === "mm" && uniteSortie === "mile") {
        return valeurEntree_3 / 4168181825440600000;
    }

    if (uniteEntree === "cm" && uniteSortie === "mm") {
        return valeurEntree_3 * 1000;
    }
    if (uniteEntree === "cm" && uniteSortie === "m") {
        return valeurEntree_3 / 1000000;
    }
    if (uniteEntree === "cm" && uniteSortie === "km") {
        return valeurEntree_3 / 1000000000000000;
    }
    if (uniteEntree === "cm" && uniteSortie === "pouce") {
        return valeurEntree_3 / 16.387064;
    }
    if (uniteEntree === "cm" && uniteSortie === "pied") {
        return valeurEntree_3 / 28316.84659;
    }
    if (uniteEntree === "cm" && uniteSortie === "verge") {
        return valeurEntree_3 / 764554.85798;
    }
    if (uniteEntree === "cm" && uniteSortie === "mile") {
        return valeurEntree_3 / 4168181825440600;
    }

    if (uniteEntree === "m" && uniteSortie === "mm") {
        return valeurEntree_3 * 1000000000;
    }
    if (uniteEntree === "m" && uniteSortie === "cm") {
        return valeurEntree_3 * 1000000;
    }
    if (uniteEntree === "m" && uniteSortie === "km") {
        return valeurEntree_3 / 1000000000;
    }
    if (uniteEntree === "m" && uniteSortie === "pouce") {
        return valeurEntree_3 * 61023.84295;
    }
    if (uniteEntree === "m" && uniteSortie === "pied") {
        return valeurEntree_3 * 35.31472;
    }
    if (uniteEntree === "m" && uniteSortie === "verge") {
        return valeurEntree_3 * 1.3079506193144;
    }
    if (uniteEntree === "m" && uniteSortie === "mile") {
        return valeurEntree_3 / 4168181825.4406;
    }

    if (uniteEntree === "km" && uniteSortie === "mm") {
        return valeurEntree_3 * 1000000000000000000;
    }
    if (uniteEntree === "km" && uniteSortie === "cm") {
        return valeurEntree_3 * 1000000000000000;
    }
    if (uniteEntree === "km" && uniteSortie === "m") {
        return valeurEntree_3 * 1000000000;
    }
    if (uniteEntree === "km" && uniteSortie === "pouce") {
        return valeurEntree_3 * 61023842953251.10156;
    }
    if (uniteEntree === "km" && uniteSortie === "pied") {
        return valeurEntree_3 * 35314723931.27957;
    }
    if (uniteEntree === "km" && uniteSortie === "verge") {
        return valeurEntree_3 * 1307952738.19554;
    }
    if (uniteEntree === "km" && uniteSortie === "mile") {
        return valeurEntree_3 / 4.1681818254406;
    }

    if (uniteEntree === "pouce" && uniteSortie === "mm") {
        return valeurEntree_3 * 16387.03745;
    }
    if (uniteEntree === "pouce" && uniteSortie === "cm") {
        return valeurEntree_3 * 16.38704;
    }
    if (uniteEntree === "pouce" && uniteSortie === "m") {
        return valeurEntree_3 / 61023.74409;
    }
    if (uniteEntree === "pouce" && uniteSortie === "km") {
        return valeurEntree_3 / 61023744094732;
    }
    if (uniteEntree === "pouce" && uniteSortie === "pied") {
        return valeurEntree_3 / 1728.00021;
    }
    if (uniteEntree === "pouce" && uniteSortie === "verge") {
        return valeurEntree_3 / 46656.0056;
    }
    if (uniteEntree === "pouce" && uniteSortie === "mile") {
        return valeurEntree_3 / 254358091578970;
    }

    if (uniteEntree === "pied" && uniteSortie === "mm") {
        return valeurEntree_3 * 28316800.71876;
    }
    if (uniteEntree === "pied" && uniteSortie === "cm") {
        return valeurEntree_3 * 28316.80072;
    }
    if (uniteEntree === "pied" && uniteSortie === "m") {
        return valeurEntree_3 / 35.31467;
    }
    if (uniteEntree === "pied" && uniteSortie === "km") {
        return valeurEntree_3 / 35314666721.489;
    }
    if (uniteEntree === "pied" && uniteSortie === "pouce") {
        return valeurEntree_3 * 1728.00000;
    }
    if (uniteEntree === "pied" && uniteSortie === "verge") {
        return valeurEntree_3 / 27;
    }
    if (uniteEntree === "pied" && uniteSortie === "mile") {
        return valeurEntree_3 / 147197952000;
    }

    if (uniteEntree === "verge" && uniteSortie === "mm") {
        return valeurEntree_3 * 764553619.40647;
    }
    if (uniteEntree === "verge" && uniteSortie === "cm") {
        return valeurEntree_3 * 764553.61941;
    }
    if (uniteEntree === "verge" && uniteSortie === "m") {
        return valeurEntree_3 / 1.3079506193144;
    }
    if (uniteEntree === "verge" && uniteSortie === "km") {
        return valeurEntree_3 / 1307950619.3144;
    }
    if (uniteEntree === "verge" && uniteSortie === "pouce") {
        return valeurEntree_3 * 46656.00000;
    }
    if (uniteEntree === "verge" && uniteSortie === "pied") {
        return valeurEntree_3 * 27;
    }
    if (uniteEntree === "verge" && uniteSortie === "mile") {
        return valeurEntree_3 / 5451776000;
    }

    if (uniteEntree === "mile" && uniteSortie === "mm") {
        return valeurEntree_3 * 4168175072993315840;
    }
    if (uniteEntree === "mile" && uniteSortie === "cm") {
        return valeurEntree_3 * 4168175072993314.50000;
    }
    if (uniteEntree === "mile" && uniteSortie === "m") {
        return valeurEntree_3 * 4168175072.99332;
    }
    if (uniteEntree === "mile" && uniteSortie === "km") {
        return valeurEntree_3 * 4.168175;
    }
    if (uniteEntree === "mile" && uniteSortie === "pouce") {
        return valeurEntree_3 * 254358091578970;
    }
    if (uniteEntree === "mile" && uniteSortie === "pied") {
        return valeurEntree_3 * 147197952000;
    }
    if (uniteEntree === "mile" && uniteSortie === "verge") {
        return valeurEntree_3 * 5451776000;
    }

    return valeurEntree_3; //Pour ensuite retourner la bonne valeur
}