# Synthèse — Système de Ventes d'Automobiles (ES_VA)

Ce projet synthèse (ES_VA) est une application de gestion de ventes automobiles en C# et WPF structurée selon une architecture multicouche (UI, BLL, DAL) connectée à une base de données SQL.

## Aperçu du projet
Réalisé à l'hiver 2022 pour l'épreuve synthèse du cours d'Évolution des applications, ce projet met en pratique la séparation des responsabilités en isolant la couche de logique d'affaires (`1875009_BLL`) et la persistance SQL (`donneesventes.sql`).

## Fonctionnalités principales
* **Architecture en couches (`ES_VA.sln`) :** Séparation modulaire incluant la bibliothèque de logique métier (`1875009_BLL`) et les modèles d'entités (comme `Province.cs`).
* **Base de données de ventes (`donneesventes.sql`) :** Script SQL complet contenant la structure et les données initiales des véhicules, clients, provinces et transactions.
* **Sécurité et chiffrement :** Intégration de packages cryptographiques (`BouncyCastle`) et gestion des configurations applicatives.

## Technologies utilisées
* **C# (.NET)** et **WPF** pour l'application de bureau et la bibliothèque de classes (`1875009_BLL`).
* **SQL (MySQL / MariaDB)** pour la base de données relationnelle (`donneesventes.sql`).
