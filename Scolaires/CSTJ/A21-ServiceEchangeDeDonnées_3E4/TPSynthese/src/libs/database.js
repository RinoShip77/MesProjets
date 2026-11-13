import mongoose from 'mongoose'; //Va chercher des données externes
import chalk from 'chalk'; //Donne accès à la biblio

export default async () => { //Exporte le code, mais le fait en asynchrone
    const url = process.env.DATABASE; //Trouve le lien vers la base de données avec une variable d'environnement
    console.log(chalk.green(`[MONGO] - Establish new connection with url: ${url}`)); //Affiche sur la console

    try {
        await mongoose.connect(url); //Essaye de se connecter (on attend avant)
        console.log(chalk.green(`[MONGO] - Connected to: ${url}`)); 
    } catch(err) { //Traite les cas d'erreurs qui se sont produits
        console.log(chalk.red(`[MONGO] - Cannot connect to: ${url}\n ${err} ... \n Exiting`));
        process.exit(1);
    }
}