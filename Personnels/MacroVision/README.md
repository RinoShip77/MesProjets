# MacroVision

MacroVision est une application mobile multiplateforme développée avec Flutter qui utilise l'intelligence artificielle Gemini de Google pour analyser des photos de repas et estimer leur valeur nutritionnelle.

## Aperçu du projet
Ce projet facilite le suivi alimentaire quotidien en permettant de photographier un plat ou d'importer une image afin d'obtenir automatiquement une estimation de la taille de la portion, des calories et de la répartition des macronutriments, tout en conservant un historique complet sur l'appareil.

## Fonctionnalités principales
* **Analyse nutritionnelle par IA :** Reconnaissance visuelle des aliments et estimation automatique des portions, calories, lipides, glucides et protéines via Gemini Vision.
* **Journal alimentaire local :** Sauvegarde des analyses dans une base de données locale pour consulter l'historique des repas jour après jour.
* **Tableau de bord et statistiques :** Visualisation claire de la consommation calorique et des objectifs nutritionnels quotidiens ou hebdomadaires.
* **Profil et thèmes personnalisables :** Adaptation des objectifs selon le profil de l'utilisateur (âge, poids, niveau d'activité) et prise en charge des thèmes Material 3 (clair, sombre et palettes personnalisées).

## Technologies utilisées
* **Flutter** et **Dart** pour le développement de l'interface mobile multiplateforme (Android, iOS, Web, Desktop).
* **API Google Gemini** (`GeminiService`) pour l'analyse multimodale d'images et l'extraction structurée en JSON.
* **SQLite (`sqflite`)** et **SharedPreferences** pour la persistance locale de l'historique et des préférences utilisateur.
* **Provider** pour la gestion d'état réactive et la personnalisation des thèmes.
