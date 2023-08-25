import mongoose from 'mongoose'; //Importation pour la BD

const observationSchema = mongoose.Schema ({ //Définition du modèle d'une observation
    location: {
        station: {type:String, index:true, required:true }, //Chaîne de caractères qui est nécessaire à la création de l'observation et indexée
        coord: {
            lon: {type:Number}, //Donnée d'ordre nominal
            lat: {type:Number}
        }
    },
    temperature:Number,
    pressure:Number,
    humidity:Number,
    feelslike:Number,
    uvIndex: {type:Number, min:0, max:11}, //Un nombre qui sera entre 0 et 11
    wind: {
        speed: {type:Number},
        degree: {type:Number, min:0, max:360} //Un interval de nombres qui seront entre 0 et 360
    },
    clouds: {
        cloudscover: {type:Number, min:0, max:1} //Un chiffre entree 0 et 1
    },    
    observationDate: {type:Date, default:Date.now}, //Une date qui aura la date courante comme date par défaut
    hexMatrix:[String]
},{
    collection:'observations', //Dans quelle collection regarder
    strict:'throw'
});

export default mongoose.model('Observation', observationSchema); //Rend le schéma accèssible à l'extérieur