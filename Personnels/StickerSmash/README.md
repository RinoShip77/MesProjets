# StickerSmash

StickerSmash est une application mobile multiplateforme développée avec React Native et Expo permettant de personnaliser des photos en y ajoutant des autocollants (emojis).

## Aperçu du projet
Ce projet offre un éditeur d'images intuitif où l'utilisateur peut sélectionner une photo depuis la galerie de son appareil, choisir un autocollant parmi une liste d'emojis, le positionner et le redimensionner par gestes tactiles, puis sauvegarder la création finale.

## Fonctionnalités principales
* **Sélection d'image :** Importation d'une photo depuis la bibliothèque multimédia de l'appareil via `expo-image-picker`.
* **Ajout et manipulation d'autocollants :** Sélecteur modal d'emojis avec prise en charge des gestes tactiles (déplacement et mise à l'échelle) sur l'image.
* **Exportation et sauvegarde :** Capture du canevas modifié et enregistrement de la nouvelle image dans la galerie locale (ou téléchargement sur le Web).
* **Navigation par onglets :** Structure multi-écrans (`Home` et `About`) gérée avec `expo-router`.

## Technologies utilisées
* **React Native**, **Expo** et **TypeScript** pour le développement mobile et web multiplateforme.
* **Expo Router** pour la navigation basée sur les fichiers.
* **React Native Gesture Handler** et **React Native Reanimated** pour les interactions tactiles fluides.
* **react-native-view-shot** et **dom-to-image** pour la capture et l'exportation de l'image annotée.
