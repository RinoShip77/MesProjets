# CompareTools

CompareTools est une suite d'outils en PowerShell dotée d'interfaces graphiques Windows Forms permettant de comparer le contenu et l'intégrité de deux répertoires ou de deux environnements applicatifs.

## Aperçu du projet
Réalisé lors d'un stage à la Chambre des communes du Canada (été 2023), ce projet regroupe deux scripts complémentaires (`ApplicationsComparison` et `FoldersComparison`) ainsi qu'une bibliothèque de fonctions partagées (`Functions`) pour automatiser l'audit des déploiements entre serveurs (Production, Test, Développement) ou entre dossiers locaux et générer un rapport comparatif complet.

## Fonctionnalités principales
* **Comparaison d'applications multi-environnements (`applicationComparison.ps1`) :** Sélection d'une application et de deux environnements (`ProdServer`, `ProdTestServer`, `DevServer`, `DevTestServer`, etc.) alimentés par fichier CSV pour comparer automatiquement leurs répertoires réseau.
* **Comparaison directe de dossiers (`folderComparison.ps1`) :** Interface Windows Forms permettant de renseigner et valider deux chemins de répertoires locaux ou distants à analyser.
* **Vérification structurelle et cryptographique :** Analyse comparative de l'arborescence (`Compare-Object`), vérification des empreintes de fichiers (`Get-FileHash`) pour distinguer les fichiers identiques des fichiers uniques, et extraction des différences ligne par ligne en CSV selon des critères d'exclusion (`differencesCriteria.csv`).
* **Génération de rapports HTML :** Création automatique d'un rapport visuel horodaté dans `reports/` résumant la comparaison de contenu et de hachage.

## Technologies utilisées
* **PowerShell** pour la logique de comparaison de fichiers, le calcul d'empreintes SHA256, l'analyse CSV et l'exportation des rapports HTML.
* **Windows Forms (.NET)** et **System.Drawing** pour les boîtes de dialogue et les formulaires interactifs.
* **API Win32 (`gdi32.dll`)** pour le rendu personnalisé des fenêtres aux bordures arrondies.
* **HTML5** et **CSS3** pour la mise en forme des tableaux du rapport généré.
