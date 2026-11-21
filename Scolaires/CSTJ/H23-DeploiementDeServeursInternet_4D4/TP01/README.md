# TP01 — Architecture Multi-Conteneurs Docker Compose

TP01 est une infrastructure multi-conteneurs orchestrée avec Docker Compose réunissant NGINX, WordPress, MariaDB, phpMyAdmin, PostgreSQL, pgAdmin 4 et Percona Monitoring (PMM).

## Aperçu du projet
Développé à l'hiver 2023 dans le cadre du cours de Déploiement de serveurs Internet, ce projet segmente les services en deux réseaux Docker privés (`reseauWP` et `reseauPMM`) avec persistance des données et personnalisation d'image via `Dockerfile`.

## Fonctionnalités principales
* **Réseau Web & CMS (`reseauWP`) :** Portail d'accueil **NGINX** (port `80`), site **WordPress** personnalisé par `Dockerfile` avec thème `simple-style` et extension `code-prettify` (port `88`), base **MariaDB** (port `3307`) et **phpMyAdmin** (port `82`).
* **Réseau Base de données & Télémétrie (`reseauPMM`) :** Serveur **PostgreSQL** (port `5432`), interface **pgAdmin 4** (port `81`) et supervision **Percona PMM Server** (port `83`).
* **Isolation et persistance :** Variables d'environnement centralisées dans `.env` et volumes locaux garantissant la conservation des données.

## Technologies utilisées
* **Docker** et **Docker Compose (`docker-compose.yml`, `Dockerfile`)** pour la conteneurisation et le cloisonnement réseau.
* **NGINX**, **WordPress**, **MariaDB**, **PostgreSQL**, **phpMyAdmin**, **pgAdmin 4** et **Percona PMM**.
