//Mercredi 10 nov
import expressValidator from 'express-validator';
const { body } = expressValidator;

class PizzeriaValidators {
    partial() {
        return [
            body('coord.lon').optional()
            .isFloat({min: -1000, max:1000}).withMessage('La longitude doit etre comprise en -1000 et 1000'),
            body('coord.lat').optional()
            .isFloat({min: -1000, max:1000}).withMessage('La lattitude doit etre comprise en -1000 et 1000'),
        ];
    }
    
    complete() {
        return [
            body('planet').exists().withMessage('Un nom de planète est requis'),
            body('coord.lon').exists().withMessage('La longitude est requise'),
            body('coord.lat').exists().withMessage('La latitude est requise'),
            body('chef.name').exists().withMessage('Le nom du chef est requis'),
            body('chef.ancestor').exists().withMessage('L ancetre du chef est requis'),
            body('chef.speciality').exists().withMessage('La specialite du chef est requise'),
            ... this.partial(),
        ];
    }
}

export default new PizzeriaValidators();