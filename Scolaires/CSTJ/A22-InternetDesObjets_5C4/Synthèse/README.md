# Synthèse — Maison Connectée Multi-Arduino

Ce projet synthèse est un système domotique complet programmé en C/C++ faisant collaborer deux cartes Arduino (ArduinoMaison et ArduinoMega) pour automatiser une maison connectée.

## Aperçu du projet
Réalisé à l'automne 2022 dans le cadre du cours d'Internet des objets, ce projet orchestre plusieurs capteurs environnementaux (gaz, lumière, humidité du sol, infrarouge) et actionneurs (servomoteurs de porte et fenêtre, ventilateur, écran LCD I2C) avec communication série entre les deux microcontrôleurs.

## Fonctionnalités principales
* **Contrôle domotique automatisé (`ArduinoMaison`) :** Gestion des servomoteurs d'ouverture de porte et de fenêtre (`Servo.h`), du ventilateur, de l'éclairage DEL et de l'écran LCD I2C (`0x27`).
* **Passerelle et coordination (`ArduinoMega`) :** Communication inter-cartes via `SoftwareSerial` pour centraliser la télémétrie et les commandes.
* **Surveillance multi-capteurs :** Lecture en continu des capteurs de gaz, de luminosité, d'humidité du sol et de présence infrarouge avec authentification par mot de passe.

## Technologies utilisées
* **C / C++ (Arduino)** pour le micrologiciel embarqué des deux cartes.
* **Bibliothèques Arduino :** `Servo.h`, `LiquidCrystal_I2C.h` et `SoftwareSerial.h`.
* **Matériel IoT :** Maquette de maison connectée Keyestudio, Arduino Uno, Arduino Mega, capteurs et servomoteurs.
