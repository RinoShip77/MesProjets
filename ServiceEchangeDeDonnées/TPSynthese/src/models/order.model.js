import mongoose from 'mongoose';
import { PIZZA_SIZES, PIZZA_TOPPINGS } from '../libs/constants.js';

const orderSchema = mongoose.Schema({
    pizzeria: { type: mongoose.Schema.Types.ObjectId, ref: 'Pizzeria', require: true },
    customer: { type: mongoose.Schema.Types.ObjectId, ref: 'Customer', require:true },
    orderDate: { type: Date, default: Date.now() },
    pizzas:[{
        size: { type: String, required:true, enum : PIZZA_SIZES },
        price: { type: Number, required:true, min: 0 },
        toppings: { type: [String], enum : PIZZA_TOPPINGS },
    }]
}, {
    collection: 'orders'
});

export default mongoose.model('Order', orderSchema);