# TicketFlow API 🎟️

TicketFlow est une API REST robuste, conteneurisée et hautement structurée conçue pour la gestion complète d'un système de billetterie de support IT. Elle intègre des opérations CRUD avancées (Bulk), des agrégations MongoDB complexes, une sécurité rigoureuse et une couverture de tests automatisés.

---

## 🚀 1. Architecture & Stack Technique

L'API utilise une **architecture en couches** (N-Tier) pour garantir la séparation des préoccupations, la maintenabilité et la testabilité :
*   **Routes** (`/routes`) : Définissent les endpoints et appliquent les middlewares.
*   **Middlewares** (`/middlewares`) : Gèrent l'authentification (JWT), la validation (Joi) et la gestion globale des erreurs.
*   **Controllers** (`/controllers`) : Gèrent les requêtes/réponses HTTP (enveloppés dans un `asyncHandler`).
*   **Services** (`/services`) : Contiennent la logique d'affaires (ex: gestion des opérations Bulk, logique conditionnelle).
*   **Repositories** (`/repositories`) : Abstraction de la base de données. Contiennent les requêtes Mongoose et les pipelines `$facet` / `$lookup`.
*   **Modèles** (`/models`) : Définition des schémas Mongoose.

**Stack :** Node.js (v22), Express 5, MongoDB / Mongoose 9, Jest / Supertest, Docker.

---

## 🛠 2. Guide d'Installation et de Démarrage (Docker)

Ce guide détaille les étapes pour lancer l'API TicketFlow via Docker, la méthode recommandée pour assurer un environnement constant.

### Étape 1 : Prérequis
Assurez-vous que les outils suivants sont installés sur votre machine :
1.  **Docker :** [Télécharger Docker](https://www.docker.com/products/docker-desktop)
2.  **Docker Compose :** Généralement inclus avec Docker Desktop. Vérifiez avec `docker-compose --version`.
3.  **Git :** Pour cloner le dépôt.

### Étape 2 : Configuration de l'environnement
1.  Clonez le dépôt du projet sur votre machine locale.
2.  Ouvrez un terminal à la racine du projet cloné.
3.  Créez un fichier nommé `.env` à la racine du projet. Ce fichier contiendra vos variables d'environnement.
4.  Ajoutez le contenu suivant dans votre fichier `.env` (vous pouvez modifier `JWT_SECRET` pour plus de sécurité) :
    ```env
    PORT=3000
    MONGODB_URI=mongodb://mongodb:27017/ticketflow
    JWT_SECRET=MaCleSecrete123_ou_une_vraie_longue_phrase_complexe
    CLIENT_URL=http://localhost:5173,http://localhost:4200
    ```

### Étape 3 : Construction et lancement de l'image Docker
Le fichier `docker-compose.yml` configure deux services : `api` (votre application Node.js) et `mongodb` (la base de données).

1.  Dans votre terminal, à la racine du projet, exécutez la commande suivante pour construire l'image et démarrer les conteneurs en arrière-plan :
    ```bash
    docker-compose up -d --build
    ```
2.  Docker va télécharger les images de base, installer les dépendances (via `npm ci` comme défini dans le `Dockerfile`) et lancer l'application.
3.  Vérifiez que les conteneurs tournent correctement :
    ```bash
    docker ps
    ```
    Vous devriez voir `ticketflow_api` et `ticketflow_db`.

### Étape 4 : Vérification et Seeding automatique
1.  L'API est maintenant accessible à l'adresse : `http://localhost:3000/api`.
2.  **Seeding :** Comme l'environnement par défaut dans Docker n'est pas explicitement défini sur `production`, le script `seed.js` va automatiquement populer votre base de données locale avec 5 techniciens (dont les mots de passe sont `password123`) et 50 tickets de test. Vous pourrez utiliser l'email `alice.dupont@ticketflow.com` (mot de passe : `password123`) pour tester le endpoint de login.

### Arrêt de l'environnement
Pour arrêter l'API et la base de données, exécutez :
```bash
docker-compose down
```
*(Vos données MongoDB seront conservées grâce au volume `mongo_data`)*.

---

## 📖 3. Documentation Interactive (Swagger)
L'API génère automatiquement son interface de test `OpenAPI`/`Swagger`.
Une fois le conteneur lancé, accédez à la documentation dynamique ici :

👉 **<http://localhost:3000/api/docs>**

Cette interface vous permet d'explorer toutes les routes, de lire les schémas attendus, et d'exécuter des requêtes HTTP en direct (y compris l'injection de votre token Bearer).

---

## 🔒 4. Sécurité & Limites
*   **Sanitisation des données :** Le mot de passe est haché dynamiquement avec la bibliothèque `bcrypt` via des hooks Mongoose stricts, couvrant à la fois les requêtes `save`, `insertMany` et les updates (`updateOne`, `updateMany`). Les mots de passe sont structurellement supprimés de toutes les réponses API grâce à une surcharge de la méthode `toJSON`.
*   **Helmet :** Sécurise les en-têtes HTTP.
*   **CORS :** Restreint aux origines définies par `CLIENT_URL`.
*   **Rate Limiting (Limiteurs) :**
    *   **Global :** 500 requêtes / 30 minutes.
    *   **Login (`/api/auth/login`) :** 10 requêtes / 15 minutes (Protection Anti-Bruteforce).
*   **Authentification JWT :** Requis sur les routes sensibles via l'en-tête `Authorization: Bearer <token>`.
*   **Mots de passe :** Hachés automatiquement via `bcrypt` (hook pre-save Mongoose). Exclus par défaut des requêtes GET.

---

## 📡 5. Référence Détaillée des Endpoints (API REST)

Toutes les routes commencent par le préfixe `/api`.

> 💡 **Info sur les Smart Endpoints :** Les requêtes `POST`, `PATCH` et `DELETE` sur `/technicians` et `/tickets` acceptent un objet unique OU un tableau d'objets, permettant des opérations en lot (Bulk). En cas de succès partiel lors d'un `POST` en lot, l'API renvoie un code HTTP 207.

### 🔑 Connexions (Authentification)

#### `POST /auth/login`
Authentifie un technicien et retourne un token JWT (valide 1 jour).
*   **Authentification :** Aucune.
*   **Body (JSON) :**
    ```json
    {
      "email": "alice.dupont@ticketflow.com",
      "password": "password123"
    }
    ```
*   **Réponse Succès (200) :** Retourne le `token` et les données du technicien (sans le mot de passe).

#### `POST /auth/logout`
Déconnecte l'utilisateur courant. L'API retourne un message de succès. C'est au client de supprimer le token JWT stocké localement.
*   **Authentification :** Requise (Bearer Token).

---

### 📊 Tableau de bord (Dashboard)

#### `GET /dashboard?type=tickets`
Retourne les statistiques agrégées des tickets via un pipeline `$facet` MongoDB.
*   **Authentification :** Requise (Bearer Token).
*   **Réponse Succès (200) :**
    *   `overview` : Totaux par statut et taux de résolution.
    *   `criticality` : Matrice des priorités actives et compte des "tickets zombies" (inactifs depuis > 7 jours).
    *   `departments` : Répartition des tickets par département ("hotspots").

#### `GET /dashboard?type=technicians`
Retourne les statistiques globales sur les techniciens et évalue leur charge de travail via un `$lookup`.
*   **Authentification :** Requise (Bearer Token).
*   **Réponse Succès (200) :**
    *   `overview` : Total, répartition par niveau (1, 2, 3), et compte des techniciens disponibles.
    *   `readyForDispatch` : Liste des techniciens ayant 0 ticket actif.
    *   `workloadMatrix` : Tableau détaillant les tickets actifs et résolus par technicien.

---

### 👨‍💻 Techniciens

#### `GET /technicians`
Liste tous les techniciens enregistrés (le mot de passe est toujours exclu de la réponse).
*   **Authentification :** Aucune.

#### `GET /technicians/:id`
Récupère les détails d'un technicien spécifique par son ID MongoDB.
*   **Authentification :** Aucune.

#### `POST /technicians`
Crée un ou plusieurs nouveaux techniciens. Le niveau doit être compris entre 1 et 3.
*   **Authentification :** Requise (Bearer Token).
*   **Body (JSON) :** Objet unique ou tableau d'objets.
    ```json
    {
      "name": "Nouveau Tech",
      "email": "tech@ticketflow.com",
      "password": "password123",
      "level": 2
    }
    ```

#### `PATCH /technicians/:id` (ou `PATCH /technicians`)
Met à jour un technicien spécifique (via l'URL `:id`) ou effectue une mise à jour en lot (via l'URL `/`). Les champs sont optionnels pour permettre des mises à jour partielles.
*   **Authentification :** Requise (Bearer Token).
*   **Body pour mise à jour unique (PATCH /technicians/:id) :** `{ "level": 3 }`
*   **Body pour mise à jour en lot (PATCH /technicians) :**
    ```json
    {
      "ids": ["id1", "id2"],
      "updateData": { "level": 3 }
    }
    ```

#### `DELETE /technicians/:id` (ou `DELETE /technicians`)
Supprime un technicien (via l'URL `:id`) ou plusieurs techniciens en lot (via l'URL `/`).
*   **Authentification :** Requise (Bearer Token).
*   **Body pour suppression en lot (DELETE /technicians) :** `{ "ids": ["id1", "id2"] }`

---

### 🎫 Tickets

#### `GET /tickets`
Liste les tickets avec pagination et fonctionnalités de filtrage avancées. Les détails du technicien assigné et des auteurs de notes sont automatiquement joints (`populate`).
*   **Authentification :** Aucune.
*   **Query Parameters :**
    *   `page` (défaut: 1) / `limit` (défaut: 10)
    *   `status` : Filtre exact (ex: `Open`, `In progress`, `Resolved`, `Closed`)
    *   `search` : Recherche par expression régulière insensible à la casse sur le titre.
    *   `sortBy` / `orderBy` (ex: `sortBy=priority&orderBy=desc`)

#### `GET /tickets/:id`
Récupère les détails complets d'un ticket spécifique.
*   **Authentification :** Aucune.

#### `POST /tickets`
Crée un ou plusieurs tickets.
*   **Authentification :** Requise (Bearer Token).
*   **Body (JSON) :** Objet unique ou tableau d'objets.
    ```json
    {
      "title": "Problème de connexion VPN",
      "description": "Impossible de me connecter au réseau distant depuis ce matin.",
      "status": "Open",
      "originDepartment": "TI",
      "priority": 3
    }
    ```

#### `PATCH /tickets/:id` (ou `PATCH /tickets`)
Met à jour un ticket (via l'URL `:id`) ou applique une modification en lot (via l'URL `/`).
*   **Authentification :** Requise (Bearer Token).
*   **Body (JSON) :** Fonctionne de la même manière que la mise à jour des techniciens.

#### `POST /tickets/:id/notes`
Ajoute une nouvelle note (sous-document) à un ticket existant. L'ID du technicien est extrait du Token JWT ; le champ `technician` dans le body est donc optionnel.
*   **Authentification :** Requise (Bearer Token).
*   **Body (JSON) :**
    ```json
    {
      "text": "Diagnostic en cours. J'ai redémarré le routeur."
    }
    ```

#### `DELETE /tickets/:id` (ou `DELETE /tickets`)
Supprime un ou plusieurs tickets.
*   **Authentification :** Requise (Bearer Token).
*   **Body (JSON) :** Fonctionne de la même manière que la suppression des techniciens.

---

## 🧪 6. Tests Automatisés
Le projet intègre une suite de tests unitaires (Jest) et de tests d'intégration (Supertest).
Pour lancer les tests (sans Docker) :
```bash
npm run test
```

---

## 📮 7. Collection Postman
Une collection Postman (`TicketFlow.postman_collection.json`) est incluse.
1.  Importez-la dans Postman.
2.  Assurez-vous que l'environnement pointe vers `http://localhost:3000/api`.
3.  Exécutez la requête **Login** du dossier **Connections**. Le token sera automatiquement extrait et stocké pour toutes les requêtes subséquentes (nécessitant l'authentification).
