//Mercredi 10 nov
import expressValidator from 'express-validator';
const { body } = expressValidator;

class OrderValidators {
    partial() {
        return [];
            
    }
    
    complete() {
        //Validation complète
        //On veut pas copier-coller les validations du 'prtial()'
        
        return [
            
        ];
    }
}

export default new OrderValidators();