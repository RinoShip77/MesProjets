import Pizzeria from '../models/pizzeria.model.js';
import orderRepository from './order.repository.js';

class PizzeriasRepository {

    create(pizzeria) {
        return Pizzeria.create(pizzeria);
    }

    retrieveAll(retrieveOptions, speciality) {
        let retrieveQuery = Pizzeria.find().skip(retrieveOptions.skip).limit(retrieveOptions.limit).sort("chef.name ");
        let countQuery = Pizzeria.estimatedDocumentCount();

        if (speciality) {
            //Le nombre de page s'adapte selon l'objet planète
            retrieveQuery =  Pizzeria.find({ 'chef.speciality': speciality }); //Filtre selon les 'retrieveOptions'
            countQuery = Pizzeria.countDocuments( Pizzeria.find({ 'chef.speciality': speciality })); //Compte les documents selon le filtre
        }
        
        return Promise.all([retrieveQuery, countQuery]);
    }

    retrieveById(idPizzeria, retrieveOptions = {}) { //Retourne un objet spécifique
        const retrieveQuery = Pizzeria.findById(idPizzeria);

        if(retrieveOptions.orders) { //Si ont veut les commandes, on va les générer
            retrieveQuery.populate('orders');
        }
        
        return retrieveQuery;
    }

    transform(pizzeria, transformOptions = {}) { //Formate l'objet passé en paramètre
        if (transformOptions.embed && transformOptions.embed.orders) { //Si les commandes sont demandées, on ajoute celles qui sont associées 
            pizzeria.orders = pizzeria.orders.map(o =>
                o = orderRepository.transform(o, transformOptions)
            )
        };
        
        //Ajouts:
        pizzeria.href = `${process.env.BASE_URL}/pizzerias/${pizzeria._id}`;
        pizzeria.lightspeed = `[${pizzeria.planet}]@(${pizzeria.coord.lat};${pizzeria.coord.lon})`;
        
        //Retraits:
        delete pizzeria._id;
        delete pizzeria.id;
        delete pizzeria.__v;
        
        return pizzeria;
    }
}

export default new PizzeriasRepository();