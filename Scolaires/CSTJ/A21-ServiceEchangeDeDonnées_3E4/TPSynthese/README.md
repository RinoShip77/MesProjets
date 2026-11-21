# TPSynthèse — API de Gestion de Pizzerias

Ce projet synthèse est un service web RESTful complet en Node.js, Express et MongoDB gérant un réseau de pizzerias, leurs clients et leurs commandes.

## Aperçu du projet
Développé en équipe à l'automne 2021 pour l'épreuve synthèse du cours de Service d'échange de données, ce serveur met en œuvre une architecture REST permettant de gérer les succursales (`pizzerias`), les clients (`customers`) et le cycle de vie des commandes (`orders`).

## Fonctionnalités principales
* **Gestion multi-ressources :** Endpoints dédiés pour les pizzerias, les clients et les commandes avec relations et sous-ressources.
* **Validation et persistance NoSQL :** Modèles Mongoose, dépôts de données (Repositories) et jeux de données JSON d'initialisation (`pizzerias.json`, `customers.json`, `orders.json`).
* **Traitement des erreurs et pagination :** Middlewares personnalisés pour normaliser les réponses HTTP et valider les paramètres de requêtes.

## Technologies utilisées
* **Node.js** et **Express** pour l'architecture de l'API REST.
* **MongoDB** et **Mongoose** pour la modélisation et le stockage des documents.
* **JavaScript (ES Modules)**, **Chalk** et **dotenv** pour la configuration du serveur.
