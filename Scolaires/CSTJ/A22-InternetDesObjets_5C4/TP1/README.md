# TP1 — Gestion de Maison Connectée

TP1 est un programme modulaire en C/C++ pour Arduino assurant la gestion des accès, des capteurs et des alertes sonores d'une maquette de maison connectée.

## Aperçu du projet
Développé à l'automne 2022 dans le cadre du cours d'Internet des objets, ce projet structure le code embarqué en fichiers d'en-tête spécialisés (`porte.h`, `detecteur.h`, `musique.h`, `fonction.h`, `variable.h`) pour contrôler la sécurité et le confort de la maison.

## Fonctionnalités principales
* **Contrôle d'accès par mot de passe (`porte.h`) :** Saisie du code en Morse à l'aide des boutons gauche/droite, affichage sur écran LCD I2C et ouverture motorisée de la porte.
* **Surveillance environnementale (`detecteur.h`) :** Détection de gaz (`A0`), de luminosité (`A1`), de pluie (`A3`) et de mouvements (`pin 2`) avec fermeture automatique de la fenêtre et activation du relais/ventilateur.
* **Alertes et mélodies (`musique.h`) :** Diffusion de mélodies et d'alarmes sonores sur le piézo-buzzer (`pin 3`).

## Technologies utilisées
* **C / C++ (Arduino)** avec architecture modulaire en fichiers `.h` et `.ino`.
* **Bibliothèques :** `Servo.h`, `Wire.h` et `LiquidCrystal_I2C.h`.
* **Matériel IoT :** Maquette de maison intelligente, servomoteurs, relais, buzzer, écran LCD I2C et capteurs analogiques/numériques.
