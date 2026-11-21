# 1875009_TP1 — Audit & Sécurité MySQL

1875009_TP1 est un ensemble de scripts SQL avancés pour MySQL mettant en œuvre la journalisation d'audit, des déclencheurs (triggers), des procédures/fonctions stockées et des requêtes analytiques.

## Aperçu du projet
Développé à l'hiver 2024 dans le cadre du cours de Sécurité des données au Cégep de Saint-Jérôme, ce projet sécurise et trace les opérations sensibles sur une base de données commerciale (crédits clients, paliers de fidélité et inventaire de pièces).

## Fonctionnalités principales
* **Tables de paliers et de journaux d'audit (`bd.sql`) :** Création des paliers clients (`Bronze`, `Silver`, `Gold`, `Platinum`, `Black`) et des tables de traçabilité `credits_logs` et `inventaire_logs`.
* **Déclencheurs de sécurité (`triggers.sql`) :** Enregistrement automatique de chaque variation de crédit ou de stock (`blades`, `rachets`, `bits`) avec l'identifiant du technicien et l'horodatage.
* **Routines et requêtes analytiques (`routines.sql`, `requetes.sql`) :** Procédures stockées, fonctions de conversion (USD/CAD, rabais selon le palier) et script unifié (`tout.sql`).

## Technologies utilisées
* **SQL / MySQL** (DDL, DML, Triggers, Stored Procedures, Functions, Views et contraintes d'intégrité).
