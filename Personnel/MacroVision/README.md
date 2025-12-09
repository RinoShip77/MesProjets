# 👁️ MacroVision

## Application d'Analyse Nutritionnelle par IA

MacroVision est une application mobile (iOS et Android) construite avec Flutter qui utilise le modèle **Gemini** de Google pour analyser les images d'aliments et estimer instantanément leur valeur nutritionnelle (calories, macronutriments, etc.).

-----

## ✨ Fonctionnalités Principales

  * **Analyse d'Image par IA :** Capturez ou sélectionnez une image pour recevoir une analyse nutritionnelle détaillée en temps réel.
  * **Estimation de Portion :** L'IA estime la taille de la portion en grammes, que l'utilisateur peut affiner manuellement.
  * **Journal de Bord (SQLite) :** Toutes les analyses sont sauvegardées localement (SQLite) pour un suivi historique.
  * **Tableau de Bord :** Visualisez votre consommation de calories et de macronutriments par jour ou par semaine.
  * **Profil Utilisateur :** Personnalisation des objectifs caloriques et des unités (métrique/impérial) en fonction du profil (âge, poids, niveau d'activité, objectif).
  * **Thèmes Dynamiques :** Supporte les thèmes clairs/sombres et les couleurs personnalisées.

-----

## 🚀 Démarrage Rapide

Ces instructions vous permettront d'obtenir une copie opérationnelle du projet sur votre machine locale à des fins de développement et de test.

### Prérequis

Assurez-vous que les logiciels suivants sont installés sur votre système :

  * **Flutter SDK** (version stable recommandée).
  * **Dart SDK**.
  * **Un éditeur de code** (VS Code ou Android Studio).
  * **Xcode** (pour iOS) et **Android Studio** (pour Android) pour configurer les environnements natifs.

### 1\. Cloner le dépôt

```bash
git clone https://www.wordreference.com/fren/d%C3%A9p%C3%B4t
cd macro_vision
```

### 2\. Installer les dépendances

```bash
flutter pub get
```

### 3\. Configuration de l'API Gemini

Ce projet dépend du service **Gemini** pour l'analyse d'image. Vous devez obtenir votre propre clé API.

1.  **Obtenir la Clé :** Créez une clé API sur [Google AI Studio].

2.  **Créer le Fichier `.env` :** À la racine du projet (`macro_vision/`), créez un fichier nommé **`.env`**.

3.  **Ajouter la Clé :** Ajoutez la clé API dans ce fichier :

    ```bash
    # Fichier: .env
    GEMINI_API_KEY="VOTRE_CLÉ_API_ICI"
    # Email de feedback
    FEEDBACK_EMAIL="votre.email@example.com"
    ```

### 4\. Exécuter l'application

Vous pouvez lancer l'application sur un simulateur ou un appareil physique :

```bash
flutter run
```

-----

## 🤖 Intégration Gemini

Le cœur de l'application réside dans le service `GeminiService`.

### Fichier Clé : `lib/services/gemini_service.dart`

Ce service utilise la méthode **`generateContent`** pour envoyer une image (encodée en Base64) et un prompt JSON (System Instruction) qui guide le modèle Gemini Pro Vision à retourner un objet JSON structuré contenant les faits nutritionnels.

**Prompt d'Analyse (Simplifié) :**

> "Analyze this image of food. Estimate the portion size in grams and provide the following nutritional facts in a JSON format: foodName, portionInGrams, calories, totalFat, saturatedFat, etc."

Le service inclut également une logique robuste pour nettoyer et décoder la réponse JSON brute de l'IA.

-----

## 💾 Persistance des Données

  * **Base de Données (SQLite) :** La persistance de l'historique est gérée via le package `sqflite` (voir `lib/services/database_service.dart`).
  * **Profil Utilisateur (SharedPreferences) :** Les réglages de thème, les objectifs macro et le profil utilisateur sont stockés localement à l'aide de `shared_preferences`.

-----

## 🎨 Thèmes et Design

Le projet utilise le package `provider` pour la gestion de l'état du thème (`lib/services/theme_provider.dart`), permettant aux utilisateurs de basculer facilement entre les thèmes clair, sombre et plusieurs options de couleurs personnalisées basées sur Material 3.

-----

## 🤝 Contribution

Les contributions sont les bienvenues \! Si vous trouvez un bug ou souhaitez ajouter une fonctionnalité, n'hésitez pas à :

1.  **Fork** ce dépôt.
2.  Créer une branche (`git checkout -b feature/nouvelle-fonctionnalité`).
3.  Commit vos changements (`git commit -am 'feat: Ajout d\'une nouvelle fonctionnalité'`).
4.  Pousser vers la branche (`git push origin feature/nouvelle-fonctionnalité`).
5.  Soumettre une **Pull Request**.

-----

## 📄 Licence

Ce projet est sous licence MIT. Voir le fichier `LICENSE` pour plus de détails.

-----

## 📧 Contact

Pour toute question ou commentaire, veuillez contacter : `[Votre Nom]` à `[votre.email@example.com]` (ou l'e-mail dans votre fichier `.env`).