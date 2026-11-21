# Converto

Converto est une application web de conversion d'unités et de dimensions développée avec Angular et TypeScript.

## Aperçu du projet
Développé à l'automne 2022 dans le cadre du cours de Technologies Web (TP2), ce projet permet de convertir instantanément des valeurs entre différentes unités de mesure à travers une interface réactive.

## Fonctionnalités principales
* **Conversion multi-dimensions (`DimensionsComponent`) :** Sélection de la catégorie de mesure, de l'unité source et de l'unité cible avec calcul en temps réel.
* **Moteur de conversion typé (`conversions.ts`) :** Tables de facteurs de conversion et classes utilitaires (`Conversion`, `outils.ts`) assurant la précision des calculs.
* **Liaison de données bidirectionnelle :** Mise à jour instantanée des résultats dès la modification des champs numériques.

## Technologies utilisées
* **Angular** et **TypeScript** pour l'architecture modulaire et les calculs de conversion.
* **HTML5** et **CSS3** pour l'interface utilisateur.
