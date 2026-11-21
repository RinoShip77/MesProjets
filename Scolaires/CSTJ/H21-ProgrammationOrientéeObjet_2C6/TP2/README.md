# TP2 — Gestion Hospitalière Médecins & Patients

TP2 est une application en C# illustrant l'héritage et la gestion de collections à travers un système de suivi des médecins et des patients.

## Aperçu du projet
Réalisé à l'hiver 2021 pour le cours de Programmation orientée objet, ce projet met en œuvre une classe de base `Personne` dont héritent `Medecin` et `Patient`, orchestrées par les classes `GestionnaireMedecins` et `GestionnairePatients`.

## Fonctionnalités principales
* **Héritage et polymorphisme :** Classe mère `Personne` factorisant les attributs communs, spécialisée par les sous-classes `Medecin` et `Patient`.
* **Gestionnaires de collections :** Classes `GestionnaireMedecins` et `GestionnairePatients` assurant l'ajout, la recherche, l'association et le filtrage des dossiers.
* **Traitement et affichage :** Menu et opérations de gestion exécutés depuis `Program.cs`.

## Technologies utilisées
* **C# (.NET Framework)** et **Visual Studio** pour la hiérarchie de classes, l'héritage et la manipulation de listes génériques (`List<T>`).
