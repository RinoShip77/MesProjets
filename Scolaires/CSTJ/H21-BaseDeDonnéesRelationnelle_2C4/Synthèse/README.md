# Synthèse — Base de Données CLSC

Ce projet synthèse regroupe les scripts SQL de création, de peuplement et de manipulation d'une base de données relationnelle pour la gestion d'un CLSC.

## Aperçu du projet
Développé à l'hiver 2021 dans le cadre du cours de Base de données relationnelle, ce projet modélise les patients (`Personnes`), les intervenants (`Intervenants`), les catégories d'emploi (`CategoriesEmploi`), les visites médicales (`Visites`) et leurs objectifs (`Objectifs`).

## Fonctionnalités principales
* **Schéma relationnel complet (`CLSC.sql`) :** Création des tables avec clés primaires auto-incrémentées, clés étrangères et contraintes d'unicité (`NAS`, `noAssuranceMaladie`).
* **Insertion de données (`OB_Ajouts.sql`) :** Requêtes `INSERT` pour enregistrer de nouveaux patients, intervenants et visites cliniques.
* **Mises à jour et opérations (`OB_Modifications.sql`) :** Scripts de modification (`UPDATE`, `DELETE`) et requêtes de suivi des dossiers médicaux.

## Technologies utilisées
* **SQL (MySQL / MariaDB)** pour la définition de schéma (DDL) et la manipulation de données (DML).
