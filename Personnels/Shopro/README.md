# Shopro

Shopro est une boutique en ligne fictive développée en HTML, CSS et JavaScript permettant de parcourir un catalogue de produits, de filtrer par catégorie et de gérer un panier d'achats.

## Aperçu du projet
Ce projet simule une expérience complète de commerce électronique en récupérant dynamiquement des articles (électronique, bijoux, vêtements) et en offrant une navigation fluide avec fenêtres modales pour la fiche détaillée des produits, l'authentification et le panier.

## Fonctionnalités principales
* **Catalogue et filtrage par catégories :** Affichage des produits sous forme de grille avec filtrage dynamique par catégorie depuis la barre latérale ou le menu latéral (`Offcanvas`).
* **Panier d'achats interactif :** Ajout d'articles au panier, visualisation du contenu dans une fenêtre modale dédiée et simulation du passage à la caisse (`Checkout`).
* **Fiches produits et connexion :** Fenêtres modales pour consulter les détails d'un produit ou se connecter à un compte utilisateur.
* **Mode clair/sombre et traduction :** Basculement du thème sauvegardé dans `localStorage` et intégration du widget Google Translate.

## Technologies utilisées
* **HTML5** et **CSS3** pour la structure de la boutique.
* **Bootstrap 5** et **Font Awesome** pour les cartes, les fenêtres modales, le menu `Offcanvas` et la gestion du thème sombre.
* **JavaScript (ES Modules)** et **CryptoJS** pour le chargement dynamique du catalogue, la gestion du panier et la logique applicative.
