# Synthèse — Système d'alarme Arduino

Ce projet synthèse est un système d'alarme intelligent programmé en C/C++ pour microcontrôleurs Arduino Uno et Arduino Mega.

## Aperçu du projet
Réalisé à l'automne 2021 dans le cadre de l'épreuve synthèse du cours d'Objets connectés, ce système assure la surveillance d'un environnement à l'aide de capteurs, d'un écran LCD RGB, d'une barrette de DEL NeoPixel et d'une communication série entre deux cartes Arduino.

## Fonctionnalités principales
* **Architecture double microcontrôleur :** Répartition des tâches entre un Arduino Uno et un Arduino Mega communicant par port série logiciel (`SoftwareSerial`).
* **Affichage et signalisation lumineuse :** Écran LCD RGB I2C (`rgb_lcd.h`) affichant l'état de l'alarme et la température (`DHT.h`), couplé à une barrette DEL adressable (`Adafruit_NeoPixel`).
* **Armement et détection d'intrusion :** Gestion des états du système d'alarme, déclenchement d'alertes visuelles et sonores et contrôle d'accès.

## Technologies utilisées
* **C / C++ (Arduino IDE)** pour la programmation embarquée des microcontrôleurs.
* **Bibliothèques matériel :** `Wire.h` (I2C), `Adafruit_NeoPixel.h`, `rgb_lcd.h`, `DHT.h` et `SoftwareSerial.h`.
* **Matériel :** Cartes Arduino Uno et Mega, bouclier Grove, écran LCD RGB, capteur DHT et barrette NeoPixel.
