# Tenretni

Tenretni est une application mobile Android en Kotlin destinée aux techniciens réseau pour superviser des passerelles (Gateways), des billets de support (Tickets), des clients et la topologie réseau.

## Aperçu du projet
Développé à l'hiver 2022 dans le cadre du cours d'Applications mobiles, ce projet consomme une API REST distante pour afficher l'état du réseau, localiser les clients sur une carte, inspecter les passerelles matérielles et traiter les billets d'assistance technique.

## Fonctionnalités principales
* **Gestion des billets et des clients :** Consultation des tickets de support (`TicketRepository`), de leurs priorités et de la localisation des clients (`CustomerRepository`, `Coordinate`).
* **Supervision des passerelles (`GatewayRepository`) :** Inspection des passerelles réseau, de leur configuration (`Config`), de leur connexion (`Connection`) et redémarrage/mise à jour à distance.
* **Visualisation de la topologie (`NetworkRepository`) :** Surveillance en temps réel de l'état des nœuds du réseau Tenretni.

## Technologies utilisées
* **Kotlin** et **Android Jetpack** (Navigation Component, ViewModel, Fragments).
* **API REST & Coroutines Kotlin** (`DataSource` et `Repository`) pour les appels réseau asynchrones.
* **Material Design Components** et lecteur de codes QR / cartes pour l'interface technicien.
