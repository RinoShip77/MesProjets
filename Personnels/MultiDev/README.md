# MultiDev

MultiDev est une application d'introduction développée en .NET MAUI illustrant la création d'une interface multiplateforme adaptative.

## Aperçu du projet
Ce projet constitue une première expérimentation avec l'environnement **.NET Multi-platform App UI (.NET MAUI)**, mettant en œuvre une fenêtre réactive capable de s'exécuter et de s'ajuster sur différentes plateformes (Windows, Android, iOS et macOS) à partir d'une base de code unique.

## Fonctionnalités principales
* **Mise en page adaptative :** Redimensionnement fluide des composants visuels et du défilement (`ScrollView`, `VerticalStackLayout`) selon la taille de l'écran.
* **Compteur interactif :** Gestion des événements de clic avec mise à jour dynamique du texte et annonce d'accessibilité via `SemanticScreenReader`.
* **Prise en charge de l'accessibilité :** Intégration des propriétés sémantiques (`SemanticProperties`) pour la lecture d'écran.

## Technologies utilisées
* **C#** et **.NET MAUI** pour la logique applicative multiplateforme.
* **XAML** pour la déclaration de l'interface utilisateur et des styles partagés.
