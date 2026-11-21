# Let'Speech

Let'Speech est une application de bureau en Python dotée d'une interface graphique Tkinter qui convertit du texte écrit en synthèse vocale (Text-to-Speech).

## Aperçu du projet
Ce projet permet à l'utilisateur de saisir ou de coller un texte en anglais dans une fenêtre dédiée, de personnaliser les paramètres de lecture (voix et vitesse d'élocution) et d'écouter immédiatement le rendu vocal ou de l'exporter sous forme de fichier audio.

## Fonctionnalités principales
* **Synthèse vocale instantanée :** Lecture à haute voix du texte saisi directement depuis l'interface graphique.
* **Personnalisation de la voix et du débit :** Sélection du timbre de voix (`Male` ou `Female`) et réglage de la vitesse de lecture (`Slow`, `Normal` ou `Fast`).
* **Exportation audio en MP3 :** Sauvegarde de l'enregistrement généré dans un répertoire choisi par l'utilisateur avec un nommage automatique basé sur la date du jour.

## Technologies utilisées
* **Python 3** pour la logique applicative et la gestion des fichiers.
* **Tkinter** (`ttk.Combobox`, `filedialog`) pour la conception de l'interface graphique.
* **pyttsx3** pour le moteur de synthèse vocale hors ligne.
