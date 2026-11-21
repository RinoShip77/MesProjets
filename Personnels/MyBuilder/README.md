# MyBuilder

MyBuilder est une plateforme web de commerce électronique permettant de configurer, visualiser et commander un ordinateur sur mesure, déclinée à travers plusieurs frameworks frontend et un serveur backend Node.js.

## Aperçu du projet
Ce projet sépare l'application en une API RESTful adossée à une base de données MySQL et une série d'interfaces clientes équivalentes réalisées avec différentes technologies web (**HTML/JS**, **React**, **Vue.js** et **SvelteKit**), afin de comparer leurs approches tout en offrant un parcours complet d'assemblage de PC et de paiement.

## Fonctionnalités principales
* **Configurateur de PC personnalisé :** Consultation du catalogue de composants informatiques et sélection des pièces pour assembler une configuration complète.
* **Implémentations frontend multiples :** Interfaces clientes développées en HTML/CSS/JS natif, React, Vue.js et SvelteKit consommant la même API.
* **Gestion du panier et paiement :** Calcul dynamique du coût de la configuration et intégration de la passerelle de paiement **Stripe**.
* **API Backend et simulation :** Serveur Express connecté à MySQL (avec jeu de données SQL inclus) ainsi qu'une configuration Mockoon pour les tests d'API.

## Technologies utilisées
* **HTML5, CSS3, JavaScript**, **React**, **Vue.js** et **SvelteKit** pour les différentes versions de l'interface utilisateur.
* **Node.js** et **Express** pour l'API REST côté serveur.
* **MySQL** pour la persistance du catalogue de composants et des commandes.
* **Stripe API** pour le traitement sécurisé des paiements.
