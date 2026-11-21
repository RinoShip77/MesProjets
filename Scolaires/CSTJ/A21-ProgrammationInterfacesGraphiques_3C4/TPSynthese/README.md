# TPSynthèse — Réseau Social & Marketplace WPF

TPSynthèse est une application de bureau en C# et WPF reproduisant un mur de publications sociales et un espace Marketplace à partir de données Excel.

## Aperçu du projet
Développé à l'automne 2021 pour l'épreuve synthèse du cours de Programmation d'interfaces graphiques, ce projet utilise des contrôles utilisateurs réutilisables (`PostUserControl`, `OfferUserControl`) pour afficher un fil d'actualité et une boutique d'annonces.

## Fonctionnalités principales
* **Mur social (`FacebookWindow`) :** Fil de publications interactif construit à l'aide du composant personnalisé `PostUserControl`.
* **Espace petites annonces (`MarketplaceWindow`) :** Catalogue d'offres commerciales affiché sous forme de cartes via `OfferUserControl`.
* **Importation de données (`TP2_Data.xlsx`) :** Chargement des utilisateurs, publications et articles du Marketplace depuis un classeur de données.

## Technologies utilisées
* **C#** et **.NET** pour la logique métier, les modèles de classes et la liaison de données.
* **WPF (XAML)** et **UserControls** pour la modularité des composants graphiques.
