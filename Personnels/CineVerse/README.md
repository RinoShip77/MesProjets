# CineVerse

CineVerse est une application web de recherche et de découverte de films reposant sur un serveur Express et l'API IMDb.

## Aperçu du projet
Ce projet offre une interface moderne et rapide permettant de rechercher des œuvres cinématographiques en interrogeant un point de terminaison IMDb via un serveur proxy Node.js équipé d'un système de mise en cache en mémoire.

## Fonctionnalités principales
* **Recherche de films dynamique :** Affichage des résultats sous forme de grille de cartes détaillées à partir d'un mot-clé.
* **Système de cache côté serveur :** Mise en cache des requêtes API (TTL de 60 secondes) pour accélérer les recherches répétées et réduire les appels réseau.
* **Sélecteur de thèmes multiples :** Basculement instantané entre les modes Système, Clair, Sombre et Néon.

## Technologies utilisées
* **HTML5** et **CSS3** pour la mise en page adaptative et les thèmes personnalisés.
* **JavaScript (ES Modules)** pour la logique de recherche et le rendu dynamique côté client.
* **Node.js** et **Express** pour le serveur backend, le routage et le proxy d'API avec cache.
