# TP01 — Gestionnaire de Jeux Vidéo WPF

TP01 est une application de bureau en C# et WPF permettant d'administrer un catalogue de jeux vidéo et leurs catégories.

## Aperçu du projet
Développé à l'hiver 2022 dans le cadre du cours d'Évolution des applications, ce projet (`Gestionnaire`) offre une fenêtre principale multi-onglets (`PrincipalManager.xaml`) ainsi que des boîtes de dialogue dédiées pour ajouter, modifier et organiser des jeux (`Jeu.cs`) et des catégories (`Categorie.cs`).

## Fonctionnalités principales
* **Gestionnaire principal par onglets (`PrincipalManager.xaml`) :** Interface centralisée permettant de parcourir les jeux, les catégories et les vues complémentaires (`Tab3.xaml`).
* **Opérations CRUD sur les catégories et les jeux :** Fenêtres modales dédiées (ex. `Windows/Category/AddCategory.xaml`) pour enrichir le catalogue.
* **Modèle objet structuré :** Classes métier `Jeu` et `Categorie` assurant la validation et la liaison de données WPF.

## Technologies utilisées
* **C# (.NET)** pour la logique métier et la gestion des événements.
* **WPF (XAML)** pour l'interface graphique multi-fenêtres.
