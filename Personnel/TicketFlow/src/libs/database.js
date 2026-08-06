import mongoose from 'mongoose';

export default async () => {
    try {
        await mongoose.connect(process.env.MONGODB_URI);
        console.log('[MongoDB] Connection successful');
    } catch(erreur) {
        console.log('[MongoDB] Connection failed :', erreur.message);

        // Empêche de tuer Jest si on est en train de tester
        if (process.env.NODE_ENV !== 'development') {
            process.exit(1);
        }
    }
}