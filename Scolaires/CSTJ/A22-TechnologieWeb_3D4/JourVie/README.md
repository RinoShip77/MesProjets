# JourVie

JourVie est une application web full-stack combinant un client Angular en TypeScript et un serveur backend en PHP.

## Aperçu du projet
Réalisé à l'automne 2022 comme travail synthèse (TP3) du cours de Technologies Web, ce projet met en place une plateforme interactive communiquant avec une API PHP (`jourvie_serveur_synthese`) via un service Angular dédié (`JvService`).

## Fonctionnalités principales
* **Service de communication HTTP (`jv.service.ts`) :** Centralisation des appels asynchrones entre l'interface Angular et les scripts PHP du serveur.
* **Interface d'administration (`AdminComponent`) :** Vue dédiée à la gestion et au suivi des données de l'application.
* **Architecture Client-Serveur :** Séparation complète entre le frontend SPA Angular (`src/app`) et le backend PHP (`jourvie_serveur_synthese`).

## Technologies utilisées
* **Angular** et **TypeScript** pour l'application cliente et la gestion des services HTTP.
* **PHP** pour le traitement des requêtes côté serveur (`jourvie_serveur_synthese`).
* **HTML5** et **CSS3** pour la présentation visuelle.
