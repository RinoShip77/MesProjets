# QuickConnect

QuickConnect est une application de bureau en Python avec interface CustomTkinter permettant de mesurer la vitesse et les performances de sa connexion Internet.

## Aperçu du projet
Ce projet offre un tableau de bord visuel doté d'un cadran analogique (jauge de vitesse) qui exécute un test de bande passante en arrière-plan pour afficher la latence, le débit descendant, le débit montant, le fournisseur d'accès et l'adresse IP du serveur.

## Fonctionnalités principales
* **Mesure complète de la connexion :** Calcul précis de la latence (`ms`), de la vitesse de téléchargement (`Download Mbps`) et de téléversement (`Upload Mbps`).
* **Cadran de vitesse interactif :** Jauge graduée (`Meter`) avec zones colorées (rouge, jaune, vert) s'animant dynamiquement pendant et après le test.
* **Identification réseau :** Détection automatique du fournisseur de services Internet (`Service`) et de l'adresse IP (`Server`).
* **Exécution asynchrone :** Lancement du test réseau dans un fil d'exécution séparé (`threading`) pour maintenir la fluidité de l'interface.

## Technologies utilisées
* **Python 3** et **CustomTkinter** pour l'interface graphique moderne.
* **speedtest-cli (`speedtest`)** pour la mesure des performances réseau.
* **tkdial (`Meter`)** et **Pillow (`PIL`)** pour le cadran de vitesse et la gestion des icônes.
* **Threading** et **NumPy** pour l'exécution non bloquante et l'animation initiale de la jauge.
