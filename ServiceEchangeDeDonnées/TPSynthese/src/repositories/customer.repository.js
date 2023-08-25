import Customer from '../models/customer.model.js';
import objectToDotNotation from '../libs/objectToDotNotation.js';
import dayjs from 'dayjs';
import orderRepository from './order.repository.js';

class CustomersRepository {
    retrieveAll(retrieveOptions = {}) {
        let retrieveQuery = Customer.find().limit(retrieveOptions.limit).sort('birthday'); //Affiche des objets jusqu'a atteindre la limite
        let countQuery = Customer.countDocuments(); //Compte tous les objets

        if(retrieveOptions.planet)
        {
            //Le nombre de page s'adapte selon l'objet planète
            retrieveQuery = Customer.find(retrieveOptions).limit(retrieveOptions.limit).sort('birthday'); //Filtre selon les 'retrieveOptions'
            countQuery = Customer.countDocuments(Customer.find(retrieveOptions)); //Compte les documents selon le filtre
        }

        return Promise.all([retrieveQuery, countQuery]); //Retourne les deux objets sous forme de tableau
    }

    retrieveById(idCustomer, retrieveOptions = {}) {
        const retrieveQuery = Customer.findById(idCustomer);

        if (retrieveOptions.orders) {
            retrieveQuery.populate('orders');
        }
        
        return retrieveQuery;
    }

    create(customer) {
        return Customer.create(customer);
    }

    update(idCustomer, customerModifs) { //Fait une mise à jour du client
        const customerToDotNotation = objectToDotNotation(customerModifs);
        return Customer.findByIdAndUpdate(idCustomer, customerToDotNotation, {new:true});
    }
    
    transform(customer, transformOptions = {}) { //Formate l'objet passé en paramètre
        if (transformOptions.embed && transformOptions.embed.orders) { //Si les commandes sont demandées, ont ajoute celles qui sont associées 
            customer.orders = customer.orders.map(o =>
            o = orderRepository.transform(o, transformOptions)
            )
        };
        customer.phone = `[${customer.phone.substr(0, 4)}]${customer.phone.substr(4, 4)}-${customer.phone.substr(8, 6)}@${customer.phone.substr(14, 2)}`;

        //Ajouts:
        customer.href = `${process.env.BASE_URL}/customers/${customer._id}`;
        customer.age = dayjs().diff(`${customer.birthday}`, 'year');
        customer.lightspeed = `[${customer.planet}]@(${customer.coord.lat};${customer.coord.lon})`;

        //Retraits:
        delete customer._id;
        delete customer.id;
        delete customer.__v;

        return customer;
    }
}

export default new CustomersRepository();