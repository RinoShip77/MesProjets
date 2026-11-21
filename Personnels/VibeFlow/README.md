# VibeFlow

VibeFlow est un assistant de développement intelligent en Python propulsé par le modèle Gemini de Google, accessible aussi bien en ligne de commande (CLI) que via une API REST FastAPI.

## Aperçu du projet
Ce projet met en place un agent conversationnel doté d'une mémoire de session (`VibeFlowAgent`) capable de répondre à des questions de programmation, d'analyser des fichiers de code locaux à la volée et d'exposer ses fonctionnalités à travers un serveur web léger.

## Fonctionnalités principales
* **Interface en ligne de commande (CLI) interactive :** Boucle de discussion en temps réel dans le terminal avec maintien du contexte conversationnel.
* **Analyse de fichiers locaux (`/read`) :** Commande dédiée permettant d'injecter le contenu d'un fichier source local accompagné d'une instruction pour obtenir une revue ou une explication de code.
* **API RESTful intégrée :** Points de terminaison HTTP (`GET /` et `POST /chat`) permettant d'interroger l'agent IA depuis des applications externes.
* **Gestion robuste des erreurs :** Exceptions personnalisées et journalisation (`logging`) pour l'initialisation et la communication avec l'API Gemini.

## Technologies utilisées
* **Python 3** pour l'architecture modulaire (`core`, `api`, `utils`) et l'outil CLI.
* **Google GenAI SDK (`google-genai`)** et **Gemini 2.5 Flash** pour le moteur d'intelligence artificielle et la gestion des sessions de clavardage.
* **FastAPI**, **Pydantic** et **Uvicorn** pour l'exposition de l'API REST.
* **python-dotenv** pour la configuration sécurisée des variables d'environnement (`GEMINI_API_KEY`).
