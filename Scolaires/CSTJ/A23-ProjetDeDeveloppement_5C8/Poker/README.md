# Poker Full-Stack (Angular & Symfony)

Poker est une application web full-stack de jeu de poker associant une interface cliente Angular en TypeScript à un serveur backend Symfony.

## Aperçu du projet
Développé à l'automne 2023 en introduction au cours de Projet de développement, ce projet fait évoluer le jeu de poker en déportant la gestion des parties, des joueurs et de la persistance sur un serveur Symfony (`Poker (WAMP - Symfony)`).

## Fonctionnalités principales
* **Application cliente (`Poker (Angular)`) :** Interface de table de jeu réactive communiquant avec le serveur pour tirer les cartes, gérer les manches et afficher les scores.
* **Serveur backend (`Poker (WAMP - Symfony)`) :** API Symfony exécutée sous environnement WAMP assurant la logique serveur et la sauvegarde des données de jeu.
* **Communication REST Client-Serveur :** Échanges JSON asynchrones entre le frontend TypeScript et les contrôleurs PHP.

## Technologies utilisées
* **Angular** et **TypeScript** pour le client web monopage.
* **Symfony (PHP)** et **WAMP** pour le serveur d'application et l'API REST.
