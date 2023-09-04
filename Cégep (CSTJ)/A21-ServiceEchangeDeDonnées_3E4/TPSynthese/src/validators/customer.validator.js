//Mercredi 10 nov
import expressValidator from 'express-validator';
const { body } = expressValidator;
import { PLANET_NAMES } from '../libs/constants.js';

class CustomerValidators {
    complete() {
        //PUT
        return [
            //On valide le format des champs
            body('name').exists()
                .withMessage('Le nom du client est requis').bail()
                .isString().withMessage('Le nom doit être une chaîne de caractères'),
            body('email').exists()
                .withMessage('Le email du client est requis').bail()
                .isEmail().withMessage('Le email dois être une adresse de courriel et doit être unique'),
            body('planet').exists()
                .withMessage('La planète du client est requise').bail()
                .isIn(PLANET_NAMES).withMessage('La planète doit faire partie de la collection de planète'), //Est dans le contenant
            body('coord.lat').exists()
                .withMessage('La latitude du client est requise').bail()
                .isFloat({ min: -1000, max: 1000 }).withMessage('et doit être comprise entre -1000 et 1000'),
            body('coord.lon').exists()
                .withMessage('La longitude du client est requise').bail()
                .isFloat({ min: -1000, max: 1000 }).withMessage('et doit être comprise entre -1000 et 1000'),
            body('phone').exists()
                .withMessage('Le numéro de téléphone du client est requis').bail()
                .isHexadecimal().withMessage('Le numéro de téléphone doit être des carctères hexadécimaux')
                .isLength({ min: 16, max: 16 }).withMessage('Le numéro de téléphone doit contenir seize caractères'),
            body('birthday').exists()
                .withMessage("La date d'anniversaire du client est requise").bail()
                .isISO8601().withMessage("La date d'anniversaire doit être dans un format de date")
                .isBefore(new Date().toISOString()).withMessage("La date d'anniversaire doit être antérieur"),
        ]
    }
}

export default new CustomerValidators();