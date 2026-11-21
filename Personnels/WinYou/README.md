# WinYou

WinYou est un générateur de formulaires graphiques dynamiques en PowerShell utilisant Windows Forms.

## Aperçu du projet
Ce projet permet de concevoir et d'afficher des fenêtres Windows Forms entièrement personnalisables à partir de fichiers de configuration modulaires (`configs/`), en séparant la sélection du profil de configuration (`StaticForm`) de la génération dynamique des contrôles (`DynamicForm`).

## Fonctionnalités principales
* **Sélection dynamique de configuration :** Détection automatique des profils `.ps1` présents dans le dossier `configs/` et affichage dans une liste déroulante initiale.
* **Génération de formulaires sur mesure :** Construction automatique de la fenêtre, des contrôles et de la mise en page selon la configuration choisie.
* **Personnalisation visuelle avancée :** Fenêtres avec bordures arrondies via l'API Win32 (`gdi32.dll`) et gestion interactive des événements de validation ou d'annulation.

## Technologies utilisées
* **PowerShell** pour le chargement modulaire des scripts et la logique de génération dynamique.
* **Windows Forms (.NET)** et **System.Drawing** pour le rendu des composants d'interface graphique.
* **API Win32 (`gdi32.dll`)** pour la découpe personnalisée des fenêtres aux coins arrondis.
