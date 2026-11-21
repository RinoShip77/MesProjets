# Kaomia

Kaomia est un écosystème applicatif multiclient composé d'un client de bureau Electron (Vue 3), d'une application mobile Android (Kotlin) et d'un serveur central Node.js.

## Aperçu du projet
Réalisé en équipe à l'automne 2023 dans le cadre du cours de Systèmes multiclients au Cégep de Saint-Jérôme, ce projet synchronise l'expérience utilisateur entre ordinateurs et appareils mobiles autour d'une API serveur commune.

## Fonctionnalités principales
* **Client de bureau (`Electron`) :** Application Vue 3, TypeScript et Vite empaquetée avec Electron (`Kaomia.exe`) offrant une interface riche sur ordinateur.
* **Application mobile (`Android`) :** Client natif Android développé en Kotlin permettant d'interagir avec son compte et ses ressources en mobilité.
* **Serveur central (`Serveur`) :** API backend en Node.js orchestrant l'authentification, la logique métier et la synchronisation des données entre les clients.

## Technologies utilisées
* **Vue 3**, **TypeScript**, **Vite** et **Electron** pour le client de bureau.
* **Kotlin** et **Android SDK** pour l'application mobile native.
* **Node.js** et **Express** pour le serveur multiclient.
