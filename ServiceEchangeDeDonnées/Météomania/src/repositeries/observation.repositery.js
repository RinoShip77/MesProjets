import Observation from '../models/observation.model.js'; //Accède au modèle d'une observation
import dayjs from 'dayjs'; //Ajoute les données reliées à la biblio pour la gestion des dates

const ZERO_KELVIN = 273.15; //Pour les températures

class ObservationRepositery {
    retrieveById(idObservation) {
        return Observation.findById(idObservation); //Cherche dans les données et retourne une observation correspondante
    }

    retrieveAll(filter) {
        const WHERE = {
            'location.station': filter.stationName //La nom de la station sera un attribut du filtre passé en paramètre
        }
        return Observation.find(WHERE); //Cherche dans les données et retourne un tableau qui contient les observations correspondantes
    }

    create(observation) {
        return Observation.create(observation); //Crée un objet qui sera une observation
    }

    delete(idObservation) {
        return Observation.findByIdAndDelete(idObservation); //Trouve une observation, et la supprime. Retourne l'observation ou 'null'
    }

    transform(observation, transformOptions = {}) { //Regarde les options de transformations (objet vide), et transforme ensuite la valeur
        observation.location = {
            coord: {
                lon:observation.location.coord.lon,
                lat:observation.location.coord.lat
            },
            stationName:`${observation.location.station}`
        }

        //La séries de conditions suivantes va ajouter la donnée 'dierection' à l'attribut 'wind' de l'observation selon la valeutr de l'attribut 'degree'
        if(observation.wind.degree >= 337.5 && observation.wind.degree < 22.5)
        {
            observation.wind = {
                speed:observation.wind.speed,
                degree:observation.wind.degree,
                direction:"N"
            }
        } else {
            if(observation.wind.degree >= 22.5 && observation.wind.degree < 67.5)
            {
                observation.wind = {
                    speed:observation.wind.speed,
                    degree:observation.wind.degree,
                    direction:"NE"
                }
            } else {
                if(observation.wind.degree >= 67.5 && observation.wind.degree < 112.5)
                {
                    observation.wind = {
                        speed:observation.wind.speed,
                        degree:observation.wind.degree,
                        direction:"E"
                    }
                } else {
                    if(observation.wind.degree >= 112.5 && observation.wind.degree < 157.5)
                    {
                        observation.wind = {
                            speed:observation.wind.speed,
                            degree:observation.wind.degree,
                            direction:"SE"
                        }
                    } else {
                        if(observation.wind.degree >= 157.5 && observation.wind.degree < 202.5)
                        {
                            observation.wind = {
                                speed:observation.wind.speed,
                                degree:observation.wind.degree,
                                direction:"S"
                            }
                        } else {
                            if(observation.wind.degree >= 202.5 && observation.wind.degree < 247.5)
                            {
                                observation.wind = {
                                    speed:observation.wind.speed,
                                    degree:observation.wind.degree,
                                    direction:"SW"
                                }
                            } else {
                                if(observation.wind.degree >= 247.5 && observation.wind.degree < 292.5)
                                {
                                    observation.wind = {
                                        speed:observation.wind.speed,
                                        degree:observation.wind.degree,
                                        direction:"W"
                                    }
                                } else {
                                    if(observation.wind.degree >= 292.5 && observation.wind.degree < 337.5)
                                    {
                                        observation.wind = {
                                            speed:observation.wind.speed,
                                            degree:observation.wind.degree,
                                            direction:"NW"
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
        
        if(transformOptions) { //Si le champ 'unit' est fournie, on fait ...
            if(transformOptions.unit) { //Pour vérifier la valeur de 'unit' 
                if(transformOptions.unit === 'm') { //Si c'est 'm' pour Métrique, on fait...
                    observation.temperature = parseFloat(observation.temperature.toFixed(2)); //Pour fixer la précision à 2 chiffres après la virgule
                }
                if(transformOptions.unit === 's') { //Si c'est 's' pour Scientifique, on fait...
                    observation.temperature += ZERO_KELVIN; //On converti la valeur en Kelvin (on additione la valeur).
                    observation.temperature = parseFloat(observation.temperature.toFixed(2)); //Pour fixer la précision à 2 chiffres après la virgule
                }
                if(transformOptions.unit === 'f') { //Si c'est 'f' pour Fahrenheit, on fait...
                    observation.temperature = (observation.temperature * 1.8) + 32; //On converti la valeur en Fahrenheit (on multiplie par 1.8 puis on ajoute 32)
                    observation.temperature = parseFloat(observation.temperature.toFixed(2)); //Pour fixer la précision à 2 chiffres après la virgule
                }
            }
        }
        
        observation.observationDate = dayjs(observation.observationDate).format('YYYY-MM-DD'); //Pour modifier la date
        //Pour accéder à UN élément précis
        //planet.lightspeed = 'X@Y#Z';
        //planet.lightspeed = `${planet.position.x.toSring(16)}@${planet.position.y.toSring(16)}#${planet.position.z.toSring(16)}`;
        
        let somme = 0;
        let produit = 1;
        let hexMatrix = observation.hexMatrix; //On conserve l'ancien tableau dans le nouveau
        for(let i = 0; i < hexMatrix.length; i++) { //Parcours le tableau
            somme += parseInt(observation.hexMatrix[i], 16); //La variable 'somme' va contenir la somme de chaque élément du tableau
            produit *= parseInt(observation.hexMatrix[i], 16); //La variable 'produit' va quant à elle contenir le produit de chaque élément du tableau
        }

        observation.hex = { //On ajoute le champ 'hex' à une observation
            alpha:somme, //Le premier élément sera la somme de touts éléments hexadécimale de 'hexMatrix'
            beta:produit, //Le second élément sera le produit des éléments de 'hexMatrix' en hexadécimale
            gamma:produit/somme, //Le troisième élément sera le quotient en hexadécimale du deuxième élément sur le premier
            delta:produit%somme //Le quatrième élément sera le reste de la division du second et du premier élément en hexadécimale
        }
        delete observation.hexMatrix; //Spprime le champ pour l'observation
        
        delete observation.__v; //Pour retirer le champs dans l'affichage

        return observation; //Retourne l'observation modifiée
    }
}

export default new ObservationRepositery(); //Rend le code du fichier dépôt accessible de l'extérieur