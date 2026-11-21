# TP02 — Déploiement Kubernetes Mosquitto & Node-RED

TP02 est un manifeste Kubernetes déployant un courtier MQTT Eclipse Mosquitto et une instance Node-RED préconfigurée avec volumes, ConfigMaps et Secrets.

## Aperçu du projet
Réalisé à l'hiver 2023 dans le cadre du cours de Déploiement de serveurs Internet, le fichier `420-4d4-tp02.yml` orchestre la mise en place d'une architecture de messagerie IoT sous Kubernetes.

## Fonctionnalités principales
* **Déploiement Eclipse Mosquitto (`eclipse-mosquitto:1.6.2`) :** Pod MQTT configuré sur le port `8080` avec montage de volumes pour la configuration (`ConfigMap`) et les identifiants chiffrés (`Secret` en lecture seule).
* **Instance Node-RED préconfigurée :** Déploiement de l'environnement de programmation visuelle par flux avec injection d'un schéma de flux par défaut.
* **Gestion déclarative Kubernetes :** Définition unifiée des `Deployments`, `Services`, `ConfigMaps` et `Secrets` dans un manifeste YAML unique.

## Technologies utilisées
* **Kubernetes** et **YAML (`420-4d4-tp02.yml`)** pour l'orchestration des pods, services, ConfigMaps et Secrets.
* **Eclipse Mosquitto (MQTT)** et **Node-RED** pour la messagerie et l'automatisation des flux.
