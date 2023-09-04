import mongoose from 'mongoose';
import { PLANET_NAMES } from '../libs/constants.js';

const customerSchema = mongoose.Schema({
    name: { type: String, require: true },
    email: { type: String, require: true, unique: true },
    planet: { type: String, require: true, enum : PLANET_NAMES },
    order: { 
        type: mongoose.Schema.Types.ObjectId,
        ref: 'orders'
    },
    coord: {
        lat: { type: Number, min: -1000, max: 1000 },
        lon: { type: Number, min: -1000, max: 1000 }
    },        
    phone: { type: String, require: true },
    birthday: { type: Date, required: true },
    referalCode: { type: String }
}, {
    collection: 'customers'
});

customerSchema.virtual('orders', {
    ref: 'Order',
    foreignField: 'customer',
    localField: '_id',
    justOne:false
});
export default mongoose.model('Customer', customerSchema);