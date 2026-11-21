# Phoneword

Phoneword est une application multiplateforme développée en .NET MAUI qui convertit des numéros de téléphone alphanumériques en numéros standards et permet de lancer l'appel.

## Aperçu du projet
Ce projet traduit les mnémoniques téléphoniques (comme `1-555-NETMAUI`) en leur équivalent numérique (`1-555-6386284`) selon la correspondance standard des touches de clavier téléphonique, puis offre la possibilité de composer directement le numéro obtenu via le composeur natif de l'appareil.

## Fonctionnalités principales
* **Traduction alphanumérique instantanée :** Conversion automatique des lettres (`A-Z`) en chiffres (`2-9`) grâce au module `PhonewordTranslator`.
* **Activation dynamique de l'appel :** Déverrouillage du bouton d'appel uniquement lorsqu'un numéro valide a été traduit.
* **Intégration au composeur téléphonique :** Boîte de dialogue de confirmation et ouverture du numéroteur natif du système (`PhoneDialer`).

## Technologies utilisées
* **C#** et **.NET MAUI** pour la logique de conversion et l'exécution multiplateforme (Android, iOS, Windows, macOS).
* **XAML** pour la conception de l'interface utilisateur.
* **Microsoft.Maui.ApplicationModel.Communication** pour l'accès aux fonctionnalités d'appel natives.
