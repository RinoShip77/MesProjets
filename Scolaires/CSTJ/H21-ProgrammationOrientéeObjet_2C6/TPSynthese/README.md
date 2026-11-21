# TPSynthèse — Bibliothèque Musicale en C#

TPSynthèse est une application console en C# permettant de gérer, rechercher et analyser une bibliothèque musicale complète (artistes, albums, chansons et interprétations).

## Aperçu du projet
Développé à l'hiver 2021 pour l'épreuve synthèse du cours de Programmation orientée objet, ce système charge des données musicales depuis des fichiers, les organise dans une hiérarchie d'objets (`ItemMusical`, `Album`, `Artiste`, `Chanson`, `Interpretation`) et offre un menu interactif de consultation et de statistiques.

## Fonctionnalités principales
* **Modèle de domaine musical riche :** Classe abstraite/parente `ItemMusical` déclinée en `Album`, `Artiste`, `Chanson` et `Interpretation`, regroupées dans `Bibliotheque`.
* **Système de menus interactifs (`Menus.cs`, `OptionMenu.cs`) :** Navigation fluide en console avec filtrage par intervalles (`Intervalle.cs`) et critères de recherche.
* **Statistiques et persistance (`StatistiquesFichiers.cs`) :** Calcul de métriques sur le catalogue musical et lecture/écriture de fichiers.

## Technologies utilisées
* **C# (.NET Framework)** et **Visual Studio** pour la programmation orientée objet avancée, la gestion des flux de fichiers et l'interface console.
