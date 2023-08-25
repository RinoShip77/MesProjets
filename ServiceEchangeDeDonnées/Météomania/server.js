import './env.js'; //Ajoute les fichiers d'environnement
import chalk from 'chalk'; //Ajoute une bibliothèque pour écrire en couleurs
import app from './src/app.js'; //Vas chercher les informations de 'app.js'

const PORT = process.env.PORT; //Précise sur quel port le serveur sera lancé

app.listen(PORT, err => { //Si ça fonctionne, on affiche un message de réussite
    console.log(chalk.blue(`\n\n\n-----------------------------------------------
    Bienvenue dans l'application Météomania\n\t       sur le port ${PORT}.`)); //On indique également le port sur lequel le serveur est actif
});