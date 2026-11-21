# Poker (Angular)

Poker est un jeu de cartes interactif développé avec Angular et TypeScript simulant des rondes de poker et l'évaluation automatique des mains.

## Aperçu du projet
Développé à l'automne 2022 dans le cadre du cours de Technologies Web, ce projet modélise en programmation orientée objet un paquet de cartes, des joueurs, des rondes de jeu et un évaluateur algorithmique déterminant la combinaison gagnante.

## Fonctionnalités principales
* **Modélisation complète du jeu (`app/modeles/`) :** Classes dédiées pour les cartes (`Carte`), le paquet mélangé (`Paquet`), les joueurs (`Joueur`) et le déroulement d'une manche (`Ronde`).
* **Évaluateur de mains (`Evaluateur`) :** Algorithme détectant et comparant automatiquement les combinaisons de poker (paire, double paire, brelan, suite, couleur, full, carré, quinte flush).
* **Interface de table interactive :** Distribution visuelle des cartes et affichage des résultats de chaque ronde.

## Technologies utilisées
* **Angular** et **TypeScript** pour la logique objet du jeu et l'évaluation des mains.
* **HTML5** et **CSS3** pour le rendu visuel des cartes et de la table de jeu.
