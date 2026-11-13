import express from 'express'; //Importe la bibliothèque externe
import HttpError from 'http-errors'; //Va chercher les données dans le fichier d'erreurs
import paginate from 'express-paginate'; //Pour ajouter la pagination
import customerRepository from '../repositories/customer.repository.js'; //Donne accès aux fonctions externes
import customerValidator from '../validators/customer.validator.js'; //Prend le validateur externe du modèle
import validator from '../middlewares/validator.js'; ///Permet d'accéder à la bibliothèque de validation

const router = express.Router();

class CustomersRoutes {
    constructor() {
        router.get('/', paginate.middleware(20, 40), this.getAll); //Obtenir tous les clients
        router.get('/:idCustomer', this.getOne);
        router.post('/', customerValidator.complete(), validator, this.post);
        router.put('/:idCustomer', customerValidator.complete(), validator, this.put); //Mise à jour complète d'un client
    }
    
    async getAll(req, res, next) { //Retourne tous les clients
         const retrieveOptions = {
            limit: req.query.limit, //Nombre limite d'objets par page
            planet: req.query.planet //Si présent, seulement les clients situés sur la planète possédant le nom fourni seront affichées
        };

        try {
            let [customers, documentsCount] = await customerRepository.retrieveAll(retrieveOptions); //Retourne les clients et le nombre de clients
            customers = customers.map(c => {
                c = c.toObject({getter:false, virtuals:false}); //On change un customer en objet
                c = customerRepository.transform(c); //On transforme l'objet de customer
                return c;
            });

            const pageCount = Math.ceil(documentsCount/req.query.limit); //Compte le nombre de page total
            const hasNextPage = (paginate.hasNextPages(req))(pageCount); //Appele une fonction et retourne son résultat avec le paramètre 'pageCount'
            const pageArray = paginate.getArrayPages(req)(5, pageCount, req.query.page); //Retourne un tableau avec la page suivante, actuelle et suivante

            const response = {
                _metadata: {
                    hasNextPage: hasNextPage,
                    page: req.query.page,
                    limit: req.query.limit,
                    totalPages: pageCount,
                    totalDocuments: documentsCount
                },
                _links: {
                    //Accède au paramètre 'url' du tableau pour avoir un lien
                    prev: pageArray[1].url,
                    self: pageArray[2].url,
                    next: pageArray[3].url,
                },
                data: customers
            };

            //Traite les cas limites
            if (req.query.page === 1) {
                delete response._links.prev;
                response._links.self = pageArray[0].url;
                response._links.next = pageArray[1].url;
            }

            if (!hasNextPage) {
                response._links.prev = pageArray[3].url;
                response._links.self = pageArray[4].url;
                delete response._links.next;
            }

            res.status(200).json(response);
        } catch (err) {
            return next(err);
        }
    }
    
    async getOne(req, res, next) {
        const retrieveOptions = {};
        const transformOptions = { embed: {} };

        if (req.query.embed && req.query.embed === 'orders') {
            retrieveOptions.orders = true;
            transformOptions.embed.orders = true;
        }

        try {
            const idCustomer = req.params.idCustomer;
            let customer = await customerRepository.retrieveById(idCustomer, retrieveOptions);

            if (!customer) {
                return next(HttpError.NotFound(`Le customer ${idCustomer} n'existe pas`));
            }

            customer = customer.toObject({getters:false, virtuals:true});
            customer = customerRepository.transform(customer, transformOptions);   
            res.status(200).json(customer);
        } catch(err) {
            return next(err);
        }
    }
    
    async post(req, res, next) {
        const newCustomer = req.body;

        if (Object.keys(newCustomer).length === 0) {
            return next(HttpError.BadRequest('Le customer ne peut pas contenir aucune donnée'));
        }

        try {
            let customerAdded = await customerRepository.create(newCustomer);
            customerAdded = customerAdded.toObject({ getters: false, virtuals: false });
            customerAdded = customerRepository.transform(customerAdded);

            //Mercredi 10 nov
            res.header('location', customerAdded.href); //Ajoute dans le 'Header' de Postman

            if (req.query._body === 'false') {
                res.status(204).end();
            } else {
                 
                 res.status(201).json(customerAdded);
            }
        } catch (err) {
            return next(err);
        }
    }

    async put(req, res, next) { //Mise à jour complète d'un client
        try {
            let customer = await customerRepository.update(req.params.idCustomer, req.body);
            
            if(!customer) {
                return next(HttpError.NotFound(`Le client avec l'identifiant ${req.params.idCustomer} n'existe pas.`));
            }
            
            if(req.query._body === 'false') { //Si il n'y aura pas de données
                res.status(204).end();
            } else {
                customer = customer.toObject({getters:false, virtuals:false});
                customer = customerRepository.transform(customer);
                
                res.status(200).json(customer);
            }
        } catch(err) {
            return next(err);
        }
    }
}

new CustomersRoutes();
export default router;