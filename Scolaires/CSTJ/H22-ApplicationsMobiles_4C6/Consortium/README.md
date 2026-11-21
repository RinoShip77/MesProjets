# Consortium

Consortium est une application mobile native Android développée en Kotlin permettant de gérer un commerçant (Trader) et ses livraisons de ressources.

## Aperçu du projet
Réalisé à l'hiver 2022 dans le cadre du cours d'Applications mobiles, ce projet met en œuvre l'architecture MVVM, la base de données locale Room (`AppDatabase`) et la navigation entre écrans pour suivre et créer des livraisons de marchandises.

## Fonctionnalités principales
* **Écran d'accueil animé (`SplashActivity`) :** Chargement initial du profil du commerçant (`Trader`) et accès au tableau de bord.
* **Suivi des livraisons (`DeliveriesActivity`) :** Liste déroulante (`RecyclerView` avec `DeliveryRecyclerViewAdapter`) affichant l'historique des livraisons effectuées.
* **Création de livraison (`NewDeliveryActivity`) :** Formulaire interactif avec validation permettant d'enregistrer une nouvelle livraison dans la base de données locale.

## Technologies utilisées
* **Kotlin** et **Android SDK** pour le développement natif Android.
* **Architecture MVVM** (`ViewModel`, `LiveData` / `StateFlow`, `Repository`).
* **Room Database (`AppDatabase`)** pour la persistance locale SQLite.
