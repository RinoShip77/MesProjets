# CitationMystere

CitationMystere est un jeu web interactif de décryptage de citations développé avec Angular et TypeScript.

## Aperçu du projet
Réalisé à l'automne 2022 dans le cadre du cours de Technologies Web (TP1), ce projet propose une grille de lettres mélangées où le joueur doit reconstituer une citation cachée colonne par colonne.

## Fonctionnalités principales
* **Grille de jeu dynamique (`GrilleComponent`) :** Affichage des colonnes de lettres disponibles et des cases de la citation à compléter.
* **Saisie et validation (`SaisieComponent`) :** Sélection interactive des caractères (`Caractere`), vérification instantanée de la citation et gestion des espaces.
* **Architecture par composants Angular :** Communication réactive entre le composant de saisie et la grille de décryptage.

## Technologies utilisées
* **Angular** et **TypeScript** pour la logique des composants et le modèle de données (`Caractere`).
* **HTML5** et **CSS3** pour la mise en forme de la grille de citation.
