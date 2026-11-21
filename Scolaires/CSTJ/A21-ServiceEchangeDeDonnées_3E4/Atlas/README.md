# Atlas

Atlas est une application web cliente en HTML, Bootstrap, jQuery et Axios permettant de consulter un bestiaire de monstres issu d'un service web REST.

## Aperçu du projet
Développé à l'automne 2021 dans le cadre du cours de Service d'échange de données, ce projet interroge une API distante avec Axios pour afficher la liste complète des monstres ainsi qu'une page détaillée pour chaque créature.

## Fonctionnalités principales
* **Tableau dynamique des monstres (`index.html`) :** Récupération asynchrone et affichage des statistiques (`Name`, `Health`, `Damage`, `Speed`, `Critical`).
* **Fiche détaillée (`details.html`) :** Consultation des caractéristiques complètes et de l'illustration d'un monstre sélectionné.
* **Communication HTTP avec Axios :** Requêtes REST asynchrones et manipulation dynamique du DOM via jQuery.

## Technologies utilisées
* **HTML5**, **CSS3** et **Bootstrap 5** pour la mise en page des tableaux et des fiches.
* **JavaScript**, **jQuery 3.6** et **Axios** pour la consommation de l'API REST.
