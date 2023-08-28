import mongoose from 'mongoose'; //Ajoute des données externes
import chalk from 'chalk'; //Donne accès à la biblio

export default async () => { //Exporte le code, mais le fait en asynchrone
    const url = process.env.DATABASE; //Trouve le lien vers la base de données avec une variable d'environnement
    
    try { //Essai le code
        await mongoose.connect(url); //Essaye de se connecter (on attend avant)
        console.log(chalk.green('\t [MONGODB] - Connexion réussie')); //Affiche un message de succès sur la console 
        console.log(chalk.blue('-----------------------------------------------\n\n\n'));
    } catch(err) { //Traite les cas d'erreurs qui se sont produits
        console.log(chalk.red('\t[MONGODB] - Échec de connexion')); //Affiche un message d'erreur sur la console
        console.log(chalk.blue('-----------------------------------------------\n\n'));
        process.exit(1); //Sort avec une erreur
    }
}