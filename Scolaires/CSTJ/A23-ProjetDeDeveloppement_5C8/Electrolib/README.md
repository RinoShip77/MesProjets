# Electrolib

Electrolib est une plateforme complète de bibliothèque numérique composée d'une application cliente Angular/Electron et d'une API backend Symfony.

## Aperçu du projet
Réalisé en équipe à l'automne 2023 dans le cadre du cours de Projet de développement au Cégep de Saint-Jérôme, ce projet permet aux usagers d'emprunter, de réserver et de consulter des livres numériques tout en offrant aux bibliothécaires un panneau de gestion complet.

## Fonctionnalités principales
* **Client Angular & Bureau (`Electrolib (Angular)`) :** Catalogue interactif avec recherche multicritère, filtres par genres, lecteur d'extraits, gestion des emprunts, favoris et tableau de bord d'administration.
* **Serveur API Symfony (`Electrolib (Symfony)`) :** Backend PHP/Symfony gérant l'authentification, les livres, les emprunts, les réservations, les avis et la persistance en base de données relationnelle.
* **Distribution multiplateforme :** Application accessible sur le Web et empaquetée sous forme d'installateur Windows (`Electrolib-1.0.0 Setup.exe`).

## Technologies utilisées
* **Angular** et **TypeScript** pour l'application frontend.
* **Symfony (PHP)** et **Doctrine ORM** pour l'API REST et la logique métier côté serveur.
* **MySQL / MariaDB** pour la base de données de la bibliothèque.
