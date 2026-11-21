# AccessyHelp

AccessyHelp est un outil en PowerShell doté d'une interface graphique Windows Forms permettant d'analyser l'accessibilité d'un site web selon les critères WCAG.

## Aperçu du projet
Ce projet propose un formulaire interactif permettant de saisir l'URL d'un site web, des identifiants optionnels et le niveau de conformité souhaité (**WCAG Level A** ou **WCAG Level AA**) afin d'inspecter automatiquement les éléments de la page (comme la présence des attributs alternatifs `alt` sur les images) et de générer un rapport HTML horodaté.

## Fonctionnalités principales
* **Interface graphique Windows Forms :** Fenêtre personnalisée aux bordures arrondies facilitant la saisie de l'URL, des identifiants et du niveau WCAG à vérifier.
* **Analyse automatisée du DOM :** Récupération et filtrage des balises d'images de la page cible via `Invoke-WebRequest` selon les critères d'accessibilité sélectionnés.
* **Génération de rapports HTML :** Création automatique d'un dossier quotidien dans `reports/` contenant le rapport d'analyse horodaté.
* **Gestion des erreurs interactive :** Boîtes de dialogue dédiées pour signaler les erreurs d'exécution ou relancer une analyse.

## Technologies utilisées
* **PowerShell** pour la logique d'analyse web, le traitement des requêtes et la génération des rapports.
* **Windows Forms (.NET)** et **System.Drawing** pour la conception de l'interface utilisateur graphique.
* **API Win32 (`gdi32.dll`)** pour le rendu personnalisé des bordures arrondies de la fenêtre.
