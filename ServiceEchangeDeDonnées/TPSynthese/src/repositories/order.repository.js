import Order from '../models/order.model.js';
import objectToDotNotation from '../libs/objectToDotNotation.js';
import customerRepository from './customer.repository.js';

const taxesRates = 0.0087;
class OrdersRepository {
    retrieveById(idOrder, retrieveOptions = {}) {
        const retrieveQuery = Order.findById(idOrder);

        if (retrieveOptions.customer) {
            retrieveQuery.populate('customer');
        }
        
        return retrieveQuery;
    }
    
    retrieveAll(retrieveOptions) {

        let retrieveQuery = {};

        if (retrieveOptions.topping == null) {
            retrieveQuery = Order.find()
            .skip(retrieveOptions.skip)
            .limit(retrieveOptions.limit)
            .sort({'orderDate': -1});
        } else {
            retrieveQuery = Order.find({'pizzas.toppings': retrieveOptions.topping})
            .skip(retrieveOptions.skip)
            .limit(retrieveOptions.limit)
            .sort({'orderDate': -1});
        }
        
        let countQuery;

        if (retrieveOptions.topping == null) {
            countQuery = Order.countDocuments()
        } else {
            countQuery = Order.countDocuments({'pizzas.toppings': retrieveOptions.topping})
        }
        
        return Promise.all([retrieveQuery, countQuery]);
    }

    update(idOrder, orderModifs) {

        const orderToDotNotation = objectToDotNotation(orderModifs);
        return Order.findByIdAndUpdate(idOrder, orderToDotNotation, {new:true});
    }

    delete(idOrder) {
        return Order.findByIdAndDelete(idOrder);
    }

    create(order) {
        return Order.create(order);
    }
    
    transform(order, transformOptions = {}) {
        if (transformOptions.embed && transformOptions.embed.customers) { //Si les commandes sont demandées, ont ajoute celles qui sont associées 
            order.customers = orders.customers.map(c =>
                c = customerRepository.transform(c, transformOptions)
            )
        };

        //Variables locales
        let subTotal = 0;
        let pizzas = order.pizzas;
        for(var p = 0; p < pizzas.length; p++) {
            delete pizzas[p]._id;
            delete pizzas[p].id;
            subTotal += parseFloat(pizzas[p].price.toFixed(3)); //Somme de l’ensemble des prix des pizzas de la commande à 3 chiffres après la virgule
        }
        
        //Ajouts:
        order.href = `${process.env.BASE_URL}/orders/${order._id}`;
        order.customer = { href: `${process.env.BASE_URL}/customers/${order.customer}` }
        order.pizzeria = { href: `${process.env.BASE_URL}/pizzerias/${order.pizzeria}` }
        order.subTotal = subTotal;
        order.taxesRates = taxesRates;
        order.taxes = parseFloat((order.subTotal * order.taxesRates).toFixed(3));
        order.total = parseFloat((order.subTotal + order.taxes).toFixed(3));

        //Retraits:
        delete order._id;
        delete order.id;
        
        return order;
    }
}

export default new OrdersRepository();