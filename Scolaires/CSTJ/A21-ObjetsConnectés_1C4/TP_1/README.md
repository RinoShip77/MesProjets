# TP_1 — Clignotement ajustable par potentiomètre

TP_1 est un programme embarqué en C/C++ pour Arduino permettant de contrôler la fréquence de clignotement d'une DEL externe à l'aide d'un bouton-poussoir et d'un potentiomètre.

## Aperçu du projet
Développé à l'automne 2021 pour le cours d'Objets connectés, ce montage électronique sur bouclier Grove lit la valeur analogique d'un potentiomètre pour ajuster dynamiquement le délai d'allumage et d'extinction d'une DEL lorsque le bouton est enfoncé.

## Fonctionnalités principales
* **Lecture analogique en temps réel :** Conversion de la position du potentiomètre (`A0`) en délai de clignotement avec seuil minimal de sécurité (`20 ms`).
* **Activation par bouton-poussoir :** Lecture numérique de l'état du bouton (`D3`) pour activer ou interrompre le cycle lumineux sur la DEL (`D2`).
* **Télémétrie sur port série :** Affichage continu de la valeur du délai (`valeurDelay`) dans le moniteur série à `9600 bauds`.

## Technologies utilisées
* **C / C++ (Arduino)** pour la logique de contrôle des entrées/sorties numériques et analogiques.
* **Matériel Arduino & Grove :** Carte Arduino, bouclier Grove, DEL externe (`D2`), bouton-poussoir (`D3`) et potentiomètre (`A0`).
