# Synthèse — Cluster Kubernetes (Nextcloud, Mattermost & PHP)

Ce projet synthèse déploie une infrastructure infonuagique complète sous Kubernetes regroupant Nextcloud, Mattermost, un cluster de 10 serveurs PHP, MetalLB et un contrôleur Ingress NGINX.

## Aperçu du projet
Réalisé à l'hiver 2023 pour l'épreuve synthèse du cours de Déploiement de serveurs Internet, ce projet contient un manifeste Kubernetes déclaratif (`1875009-tp03.yml`) isolé dans l'espace de nom `1875009-tp03` ainsi qu'un rapport d'architecture (`PartieA.docx`) et des captures de validation.

## Fonctionnalités principales
* **Haute disponibilité PHP :** Déploiement de 10 réplicas d'un serveur web PHP exposés derrière un service et un contrôleur Ingress.
* **Services collaboratifs auto-hébergés :** Déploiement complet de **Nextcloud** (avec sa base de données et volumes persistants) et de la messagerie d'équipe **Mattermost**.
* **Routage réseau & Équilibrage de charge :** Intégration de **MetalLB** (`LoadBalancer`), d'**Ingress-NGINX** et configuration DNS locale (`hosts`) pour le routage par noms de domaine.

## Technologies utilisées
* **Kubernetes (`kubectl`)** et **YAML (`1875009-tp03.yml`)** pour l'orchestration des conteneurs, Namespaces, Deployments, Services, PersistentVolumes et Ingress.
* **MetalLB** et **NGINX Ingress Controller** pour l'exposition réseau.
* **Docker**, **Nextcloud**, **Mattermost** et **PHP/Apache**.
