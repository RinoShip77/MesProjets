# GrindWall

GrindWall est une application multiplateforme en .NET MAUI qui combine le blocage d'applications de divertissement avec un système gamifié d'exercices physiques.

## Aperçu du projet
Ce projet transforme le temps d'écran en récompense : l'application surveille et bloque l'accès aux jeux ou applications distrayantes jusqu'à ce que l'utilisateur accomplisse des quêtes sportives (comme des séries de squats), convertissant l'effort physique en minutes de jeu débloquées.

## Fonctionnalités principales
* **Tableau de bord d'activité :** Anneau de progression dynamique affichant le nombre de squats effectués, les calories brûlées et le temps de jeu gagné.
* **Système de quêtes et d'historique :** Vues dédiées pour suivre les défis quotidiens (`Quests`), les jeux surveillés (`Games`), l'historique des performances (`History`) et le profil utilisateur (`Profile`).
* **Blocage d'applications multiplateforme :** Service de surveillance en arrière-plan vérifiant les permissions d'accès à l'utilisation et restreignant les applications ciblées sur ordinateur et mobile.
* **Interface adaptative :** Navigation optimisée avec barre supérieure sur bureau et barre d'onglets sur appareil mobile.

## Technologies utilisées
* **C#** et **.NET MAUI** pour le développement multiplateforme (Windows, Android, iOS) suivant l'architecture MVVM.
* **XAML** pour la conception des vues réactives, des anneaux de progression et des animations.
* **Services natifs (Android / Windows)** pour la détection des applications actives et la gestion des permissions système.
