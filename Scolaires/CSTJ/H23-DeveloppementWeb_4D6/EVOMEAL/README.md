# EVOMEAL

EVOMEAL est une application web de commerce électronique alimentaire développée avec le framework PHP Symfony, le moteur de gabarits Twig et une base de données MySQL.

## Aperçu du projet
Réalisé à l'hiver 2023 dans le cadre du cours de Développement Web, ce projet propose un catalogue de repas et produits alimentaires classés par catégories, un système d'authentification client, un panier de commande et une interface d'administration.

## Fonctionnalités principales
* **Catalogue de repas par catégories :** Exploration des produits (`products`) avec prix, quantité en stock, description détaillée, image et filtrage par catégorie (`categories`).
* **Authentification et profils (`users`) :** Inscription, connexion sécurisée, gestion des rôles (`roles` JSON) et des coordonnées de livraison (adresse, ville, code postal, province, téléphone).
* **Architecture MVC Symfony & Docker :** Migrations Doctrine, gabarits Twig, tests PHPUnit et configuration `docker-compose.yml`.

## Technologies utilisées
* **PHP 8** et **Symfony** pour l'architecture MVC, la sécurité et le routage.
* **Twig**, **HTML5**, **CSS3** et **Bootstrap** pour le rendu des vues côté serveur.
* **MySQL / MariaDB** et **Doctrine ORM** (`creation.sql`, `migrations/`) pour la persistance des données.
* **Docker Compose** pour l'environnement de base de données et de messagerie.
