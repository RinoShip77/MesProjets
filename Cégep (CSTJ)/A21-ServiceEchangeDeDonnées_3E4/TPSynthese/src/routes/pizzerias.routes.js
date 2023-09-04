import express from 'express';
import HttpError from 'http-errors';
import paginate from 'express-paginate';
import pizzeriaRepository from '../repositories/pizzeria.repository.js';
import pizzeriaValidator from '../validators/pizzeria.validator.js';
import validator from '../middlewares/validator.js';

const router = express.Router();

class PizzeriaRoutes {
    constructor() {
        router.get('/', paginate.middleware(25, 50), this.getAll);
        router.get('/:idPizzeria', this.getOne); //Pour obtenir une pizzeria spécifique
        router.post('/', pizzeriaValidator.complete(), validator, this.post);
    }

    async getAll(req, res, next) {
        const speciality = req.query.speciality;
        const retrieveOptions = {
            skip: req.skip,
            limit: req.query.limit,

            pizzerias: req.query.pizzerias
        };

        try {
            let [pizzerias, documentsCount] = await pizzeriaRepository.retrieveAll(retrieveOptions, speciality); //Retourne les clients et le nombre de clients

            pizzerias = pizzerias.map(p => {
                p = p.toObject({ getter: false, virtuals: false });
                p = pizzeriaRepository.transform(p); 
                return p;
            });

            const response = {
                totalDocuments: documentsCount,
                data: pizzerias
            };

            res.status(200).json(response);
        } catch (err) {
            return next(err);
        }
    }

    async getOne(req, res, next) {
        //Validation des paramètres de la request
        const retrieveOptions = {};
        const transformOptions = { embed: {} };

        if(req.query.embed && req.query.embed === 'orders') { //Si le paramètre d'URL 'embed' est renseigné, ...
            retrieveOptions.orders = true;
            transformOptions.embed.orders = true;
        }

        try {
            let pizzeria = await pizzeriaRepository.retrieveById(req.params.idPizzeria, retrieveOptions);
            
            if (pizzeria) {
                pizzeria = pizzeria.toObject({getters:false, virtuals:true});
                pizzeria = pizzeriaRepository.transform(pizzeria, transformOptions); //On transforme l'objet selon les paramètres
                res.status(200).json(pizzeria);
            } else {
                return next(HttpError.NotFound(`La pizzeria ${req.params.idPizzeria} n'existe pas`));
            }
        } catch (err) {
            return next(err);
        }
    }

    async post(req, res, next) {
        const newPizzeria = req.body;

        if (Object.keys(newPizzeria).length === 0) {
            return next(HttpError.BadRequest('La pizzeria ne peut pas contenir aucune donnée'));
        }

        try {
            let pizzeriaAdded = await pizzeriaRepository.create(newPizzeria);

            pizzeriaAdded = pizzeriaAdded.toObject({ getters: false, virtuals: false });
            pizzeriaAdded = pizzeriaRepository.transform(pizzeriaAdded);
            res.header('customers', pizzeriaAdded.href);

            if (req.query._body === 'false') {
                res.status(201).end();
            } else {
                res.status(201).json(pizzeriaAdded);
            }

        } catch (err) {
            return next(err);
        }
    }
}

new PizzeriaRoutes();
export default router;