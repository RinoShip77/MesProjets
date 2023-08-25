import express from 'express'; //Prend en mémoire la biblio
import dayjs from 'dayjs'; //Prend en mémoire la biblio
import database from './libs/database.js'; //Importation de la base de donnée
import errorMiddleware from './middlewares/errors.js'; //Ajoute le ficher d'erreurs
import observationsRoutes from './routes/observations.routes.js'; //Ajoute le fichier de routes

const app = express(); //Déclaration d'une constante basée sur la fonction express

app.use(express.json()); //Utilisation de la fonction en précisant la recherche
database(); //Fonction qui appelle la base de donnée
app.use(errorMiddleware); //Fonction qui va permettre d'utiliser les données du fichier d'erreur
app.use('/observations', observationsRoutes); //Va utiliser les données du fichier de routes

export default app; //Pour permettre aux autres fichiers de y accéder