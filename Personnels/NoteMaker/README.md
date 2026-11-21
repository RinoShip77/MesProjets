# NoteMaker

NoteMaker est un éditeur de texte moderne en Python avec interface CustomTkinter intégrant la dictée vocale, la synthèse vocale et la correction grammaticale.

## Aperçu du projet
Ce projet revisite le bloc-notes classique en lui apportant une interface à onglets soignée (avec thèmes clair, sombre et système) ainsi que des outils intelligents permettant de dicter ses notes au microphone, de les faire lire à haute voix ou d'en corriger automatiquement la grammaire.

## Fonctionnalités principales
* **Gestion multi-onglets :** Création dynamique d'onglets pour éditer plusieurs fichiers texte (`.txt`) simultanément, avec ouverture et sauvegarde rapides.
* **Dictée vocale (Speech-to-Text) :** Transcription directe de la voix captée par le microphone vers l'éditeur de texte.
* **Lecture vocale (Text-to-Speech) :** Lecture audio intégrale du contenu de l'onglet actif.
* **Vérificateur grammatical intégré :** Analyse et correction automatique des fautes grammaticales du texte en un clic.
* **Thèmes d'interface :** Sélecteur de mode d'affichage (`system`, `dark`, `light`).

## Technologies utilisées
* **Python 3** et **CustomTkinter** pour l'interface graphique moderne à onglets.
* **SpeechRecognition** pour la reconnaissance et la transcription vocale.
* **pyttsx3** pour la synthèse vocale hors ligne.
* **LanguageTool (`language_tool_python`)** pour l'analyse et la correction grammaticale.
