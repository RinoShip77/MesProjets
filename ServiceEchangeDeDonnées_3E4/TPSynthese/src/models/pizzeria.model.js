import mongoose from 'mongoose';
import { PLANET_NAMES, MONSTER_ANCESTORS, PIZZA_TOPPINGS } from '../libs/constants.js';

const pizzeriaSchema = mongoose.Schema({
    planet: { type: String, required: true, enum: PLANET_NAMES },
    coord: {
        lon: { type: Number, min: -1000, max: 1000 },
        lat: { type: Number, min: -1000, max: 1000 }
    },
    chef: {
        name: { type: String, required: true },
        ancestor: { type: String, required: true, enum: MONSTER_ANCESTORS },
        speciality: { type: String, required: true, enum: PIZZA_TOPPINGS }
    }
}, {
    collection: 'pizzerias'
});

pizzeriaSchema.virtual('orders', {
    ref:'Order',
    foreignField: 'pizzeria',
    localField: '_id',
    justOne: false
});

export default mongoose.model('Pizzeria', pizzeriaSchema);