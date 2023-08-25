import express from 'express'; //Va permettre de coder plus rapidement avec les données de cette biblio
import HttpError from 'http-errors'; //Prend les données externe du fichier d'erreurs et les inclus dans le fichier
import observationRepositery from '../repositeries/observation.repositery.js'; //Va chercher les données du dépôt

const router = express.Router(); //On appelle la fonction '.Router()' de 'express' pour faciliter le code et on met le tout dans une constante locale

class ObservationsRoutes {
    constructor() {
        router.post('/', this.post); //Renvoie à la fonction pour créer une nouvelle observation   
        router.delete('/:idObservation', this.delete); //Renvoie à la fonction pour supprimer une observation
        router.get('/:stationName', this.getAll); //Renvoie à la fonction pour aller chercher les informationss de toutes les observations d'une station      
        router.get('/:stationName/:idObservation', this.getOne); //Renvoie à la fonction pour obtenir les informations d'une observation précise d'une station
    }

    async post(req, res, next) { //On met 'async' car on doit faire interagir la base de donnée et que l'on va devoir attendre sa réponse avant de continuer
        const newObservation = req.body; //On va charcher les données entrées dans le 'body' de la requête

        if(Object.keys(newObservation).length === 0) { //Si l'observation passée dans la requête est vide
            return next(HttpError.BadRequest(`L'observation ne peut pas contenir aucune donnée`)); //Message d'erreur (mauvaise requête) pour le code '400'
        }

        try {
            let observationAdded = await observationRepositery.create(newObservation); //On crée une nouvelle observation en asynchrone (seulement lorsque la BD sera connectée)
            observationAdded = observationAdded.toObject({getters:false, virtuals:false}); //On transforme cette observation en objet de la base de données
            observationAdded = observationRepositery.transform(observationAdded); //On appelle la fonction 'transform' pour apporter des modifications

            res.status(201).json(observationAdded); //La création est un succès
        } catch(err) {
            return next(err); //Retourne l'erreur
        }
    }

    async delete(req, res, next) { //Supprimer une observation spécifique
        try { //Essai le code
            const deleteResult = await observationRepositery.delete(req.params.idObservation); //Va supprimer le 'idObservation' passer dans l'URL
        } catch(err) {
            return res.status(405).end(); //On retourne le code 405
        }
    }
    
    async getAll(req, res, next) {
        const filter = {};
        if(req.params.stationName) {
            filter.stationName = req.params.stationName; //Définie le filtre à appliquer         
        }

        const transformOptions = {}; //Validation des paramètres de la 'request' (de l'utilisateur)
        try {            
            let observations = await observationRepositery.retrieveAll(filter); //On reçoit les observations de la BD
            
            if(observations.length != 0)
            {
            transformOptions.unit = req.query.unit; //On conserve la valeur de 'unit' dans 'transformOptions.unit'
            observations = observations.map(o => { //Foreach() qui va résulter en un tableau
                o = o.toObject({getters:false, virtuals:false}); //Conversion de la variable 'o' en objet
                o = observationRepositery.transform(o, transformOptions); //On applique la transformation de valeur à celle-ci
                return o; //On retourne le même tableau, mais transformé
            });

            res.status(200).json(observations); //La récupération des observations est un succès et l'affichage sera en 'JSON'
            } else {
                return next(HttpError.BadRequest(`La requête est incorrecte`)); //Message d'erreur (mauvaise requête) pour le code '400'
            }
        } catch (err) {
            return next(err);
        }
    }
    
    async getOne(req, res, next) {
        const stationName = req.params.stationName; //Récupère le nom de la station à laquelle l'observation est rattaché
        const idObservation = req.params.stationName.idObservation; //Récupère l'identifiant de l'observation dans l'URL

        const transformOptions = {}; //Validation des paramètres de la 'request' (de l'utilisateur)
        try {
            if(observationRepositery.retrieveAll(stationName)) //On précise la recherche à une station spécifique
            {
                let observation = await observationRepositery.retrieveById(req.params.idObservation); //On reçoit une observation

                transformOptions.unit = req.query.unit; //On passe le paramètre 'unit' de la requête de l'utilisateur dans la constante 'tranformOptions.unit'
                if (observation) {
                    observation = observation.toObject({getters:false, virtuals:false}); //Conversion de la variable en objet
                    observation = observationRepositery.transform(observation, transformOptions); //On applique la fonction pour transformer les données

                    res.status(200).json(observation); //La récupération de l'observation est réussie
                } else {
                    return next(HttpError.NotFound(`L'observation avec l'identifiant ${idObservation} n'existe pas`)); //Message d'erreur pour informer l'utilisateur du code '404'
                }
            } else {
                return next(HttpError.NotFound(`La station ${stationName} n'existe pas`)); //Message d'erreur pour informer l'utilisateur du code '404'
            }
        } catch (err) {
            return next(err); //Retourne la prochaine erreur
        }
    }
}

new ObservationsRoutes(); // Permet de créer l'objet/appeler le constructeur
export default router;