# Météomania

Météomania est une API RESTful en Node.js, Express et MongoDB permettant de collecter et de consulter des observations météorologiques.

## Aperçu du projet
Réalisé à l'automne 2021 pour le cours de Service d'échange de données, ce serveur backend expose des routes REST structurées selon le patron Repository/Model pour gérer des relevés météo provenant de différentes stations d'observation.

## Fonctionnalités principales
* **Architecture en couches :** Séparation claire entre les routes (`observations.routes.js`), le dépôt de données (`observation.repositery.js`) et le modèle Mongoose (`observation.model.js`).
* **Opérations CRUD & Filtrage :** Recherche, création et transformation d'observations météorologiques avec conversion en notation pointée (`objectToDotNotation.js`).
* **Validation et tests d'API :** Gestion centralisée des erreurs (`middlewares/errors.js`) et suite complète de requêtes de test (`tests.json`).

## Technologies utilisées
* **Node.js** et **Express** pour le serveur HTTP et le routage REST.
* **MongoDB** et **Mongoose** pour la persistance des observations météorologiques.
* **dotenv** et **Chalk** pour la configuration d'environnement et la journalisation console.
