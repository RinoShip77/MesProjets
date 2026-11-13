//----------------------------------------
//  Fichier : conversion.ts
//  Développeur: Olivier Bourgault
//  Date: 2022-11-07
//-----------------------------------------

//--------------------------------------------
//Fonction qui va convertir le montant entré par l'utilisateur pour une année donnée pour ensuite retourner l'équivalent de ce montant lors d'une seconde année
//--------------------------------------------
export function convertir(IPCAnnuels: Array<any>, anneeEntree: number, anneeSortie: number, valeurEntree: number) {
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