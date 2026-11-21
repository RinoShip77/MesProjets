# Streamly

Streamly est une plateforme web complète de streaming vidéo reposant sur une interface React et une API REST Node.js/Express connectée à une base de données MySQL.

## Aperçu du projet
Ce projet propose une expérience de vidéo à la demande (VOD) avec sélection de profil utilisateur, navigation dans un catalogue de films et vidéos, filtrage par genre, recherche textuelle, lecteur vidéo intégré et interface d'administration pour gérer le catalogue et les profils.

## Fonctionnalités principales
* **Catalogue et recherche avancée :** Exploration des vidéos avec recherche par titre ou description, filtrage multi-genres, tri (par titre ou date) et pagination.
* **Lecteur vidéo intégré :** Lecture fluide des flux vidéo (incluant la prise en charge HLS) via un lecteur multimédia moderne.
* **Gestion des profils utilisateurs :** Sélection, création, modification et suppression de profils avec avatars personnalisés.
* **Interface d'administration :** Opérations CRUD complètes (`/api/admin/videos` et `/api/admin/users`) pour ajouter, modifier ou supprimer des vidéos et des utilisateurs.

## Technologies utilisées
* **React 19**, **Vite** et **React Router** pour l'application frontend monopage.
* **Bootstrap 5**, **Plyr** et **hls.js** pour l'habillage visuel et le lecteur de flux vidéo.
* **Node.js** et **Express** pour le serveur backend RESTful.
* **MySQL (`mysql2`)** pour le stockage relationnel des vidéos, des genres et des utilisateurs.
