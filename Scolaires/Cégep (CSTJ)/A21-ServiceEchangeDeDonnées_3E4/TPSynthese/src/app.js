import express from 'express'; //Prend en mémoire la biblio
import database from './libs/database.js'; //Importation de la base de donnée
import errorMiddleware from './middlewares/errors.js'; //Ajoute le ficher d'erreurs
import ordersRoutes from './routes/orders.routes.js'; //Ajoute le fichier de routes pour les commandes
import pizzeriasRoutes from './routes/pizzerias.routes.js'; //Ajoute le fichier de routes pour les pizzas
import customersRoutes from './routes/customers.routes.js'; //Ajoute le fichier de routes pour les clients

database(); //Fonction qui appelle la base de donnée

const app = express(); //Déclaration d'une constante basée sur la fonction express
app.use(express.json()); //Utilisation de la fonction en précisant la recherche
app.use((req, res, next) => { //Indique l'adresse internet utilisée
    res.header('base_url', process.env.BASE_URL);
    next();
});
app.use('/orders', ordersRoutes); //Va utiliser les données du fichier de routes
app.use('/pizzerias', pizzeriasRoutes); //Va utiliser les données du fichier de routes
app.use('/customers', customersRoutes); //Va utiliser les données du fichier de routes
app.use(errorMiddleware); //Fonction qui va permettre d'utiliser les données du fichier d'erreur


export default app; //Pour permettre aux autres fichiers de y accéder