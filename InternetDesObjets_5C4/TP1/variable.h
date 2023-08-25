//Nom du fichier: variable.h
//Date: 2022-09-12
//Version: Version finale V0.1
//Nom du developpeur: Olivier Bourgault
//Derscription: Toutes les variables nécessaires aux bon fonctionnement du programme pour la maison connectée

/*--------------------------------------------------------------------------------------------------------------------------------------------------------*/
//Déclarations d'objets pour le programme

//L'adresse de communications avec l'écran I2C est 0x27, on écrit 16 charactères à chaque lignes sur deux lignes au total
LiquidCrystal_I2C mylcd(0x27, 16, 2);  //Définir l'instance (ou l'objet) I2C

//Créer les instances pour les servo-moteurs
Servo servoPorte;    //Moteur de la porte
Servo servoFenetre;  //Moteur de la fenêtre

/*--------------------------------------------------------------------------------------------------------------------------------------------------------*/
//Définitions de plusieurs variables et quelques constantes pour le bon fonctionnement du programme
//Des constantes globales:
const long delai = 500;     //Déclarations d'une constante pour l'intervale
const int anglePlat = 180;  //Déclarations d'une constante pour l'angle de 180°
const int angleNul = 0;     //Déclarations d'une constante pour l'angle de 0°

//Le moniteur série:
int consoleTexte = 0;  //Va contenir le texte sur la console pour contrôler l'entièreté de la maison

//La diode électroluminescente blanche:
const int diodeBlanchePortePin = 13;  //Assigne la PIN 13 du Arduino à la constante de la diode jaune

//Le module relais:
const int relaisPin = 12;  //Assigne la PIN 12 du Arduino à la constante du module relais pour assurer l'ajustement automatique et la sécurité

//Les mots de passes du système:
String motDePasseTemp = "";  //string type variable motDePasseTemp
String motDePasse = "";      //string type variable motDePasse

//Le bouton de gauche:
const int boutonGauchePin = 4;             //Assigne la PIN 4 du Arduino à la constante du bouton de gauche
const int boutonGaucheCompteurValMax = 5;  //Valeur maximale du compteur
const int boutonGaucheCompteurValMin = 1;  //Valeur minimale du compteur
int boutonGaucheCompteur = 0;              //Déclaration d'une variable qui va contenir le nombre de fois où le bouton a été pressé
int boutonGaucheVal = 0;                   //Initialisation de la variable qui va contenir le statut du bouton (appuyé ou non)

//Le boutons de droite:
const int boutonDroitePin = 8;              //Assigne la PIN 8 du Arduino à la constante du bouton de droite
const int boutonDroiteCompteurValMax = 15;  //Valeur maximale du compteur
int boutonDroiteCompteur = 0;               //Déclaration d'une variable qui va contenir le nombre de fois où le bouton a été pressé
int boutonDroiteVal = 0;                    //Initialisation de la variable qui va contenir le statut du bouton (appuyé ou non)

//Le ventilateur:
const int ventilateurINBPin = 6;  //Assigne la PIN 6 du Arduino à une des deux constantes du ventilateur
const int ventilateurINAPin = 7;  //Assigne la PIN 7 du Arduino à une des deux constantes du ventilateur
String ventilateurTexte = "";     //Variable qui contiendra la chaîne de carctères sur la console pour contrôler le ventilateur
int ventilateurVal = 0;           //Va contenir la valeur qui correspondra à la vitesse du ventilateur

//La diode électroluminescente jaune:
const int diodeJaunePin = 5;  //Assigne la PIN 5 du Arduino à la constante de la diode jaune
String diodeJauneTexte = "";  //Variable qui contiendra la chaîne de carctères sur la console pour contrôler la diode
int diodeJauneVal = 0;        //Va contenir la valeur qui correspondra à l'état de la diode

//Le moteur de la fenêtre:
const int servoFenetrePin = 9;  //Assigne la PIN 9 du Arduino à la constante du moteur de la fenêtre
String servoFenetreTexte = "";  //Variable qui contiendra la chaîne de carctères sur la console pour contrôler le moteur de la fenêtre
int servoFenetreAngle = 0;      //Va contenir la valeur qui correspondra à l'angle de rotation (0° ou 180°) de la roue dentelée (ouverte ou fermée)

//Le moteur de la porte:
const int servoPortePin = 10;  //Assigne la PIN 10 du Arduino à la constante du moteur de la porte
String servoPorteTexte = "";   //Variable qui contiendra la chaîne de carctères sur la console pour contrôler le moteur de la porte
int servoPorteAngle = 0;       //Va contenir la valeur qui correspondra à l'angle de rotation (0° ou 180°) de la porte

//L'avertisseur sonore:
const int buzzerPin = 3;      //Attribut le signal du buzzer à la constante
int longueurDeLaMusique = 0;  //Va contenir le nombre de caractères (ou de notes) à jouer pour obtenir la musique souhaitée

//Le détecteur de fumée:
const int gazPin = A0;      //Assigne la PIN analogue A0 du Arduino à la constante du détecteur de gaz
const int gazMaxVal = 700;  //Valeur maximale nécessaire pour déclancher l'alarme du détecteur de gaz
const int gazMinVal = 100;  //Valeur minimale pour arrêter l'alarme du détecteur de gaz
int gazFlagVal = 0;         //Indicateur de la présence ou l'absence de gaz
int gazVal = 0;             //Va contenir la quantité de gaz que le capteur va détecter

//Le capteur de cellule photoélectrique:
const int lumierePin = A1;      //Assigne la PIN analogue A1 pour le détecteur de lumière
const int lumiereMinVal = 300;  //Valeur minimale pour arrêter l'alarme du détecteur de lumière
int lumiereFlagVal = 0;         //Indicateur de la présence ou l'absence de gaz
int lumiereVal = 0;             //Va contenir la quantité de lumière que le capteur va détecter

//Le détecteur de mouvements:
const int mouvementPin = 2;  //PIN pour du capteur d'infarouge
int mouvementVal = 0;        //État du détecteur de mouvements

//Le capteur de vapeur:
const int pluiePin = A3;      //Attribut la PIN analogue A3 pour le détecteur de vapeur
const int pluieMaxVal = 800;  //Valeur maximale pour arrêter l'alarme du détecteur de vapeur
const int pluieMinVal = 30;   //Valeur minimale pour arrêter l'alarme du détecteur de vapeur
int pluieFlagVal = 0;         //Indicateur de la présence ou l'absence de vapeur
int pluieVal = 0;             //Va contenir la quantité de vapeur que le capteur va détecter

//Le détecteur d'humidité du sol (pour les plantes):
const int humiditeFleurPin = A2;     //Attribut la PIN analogue A2 pour le détecteur d'humidité
const int humiditeFleurMaxVal = 10;  //Valeur maximale pour arrêter l'alarme du détecteur d'humidité
const int humiditeFleurMinVal = 50;  //Valeur minimale pour arrêter l'alarme du détecteur d'humidité
int humiditeFleurFlagVal = 0;        //Indicateur de la présence ou l'absence d'humidité
int humiditeFleurVal = 0;            //Va contenir la quantité d'humidité que le capteur va détecter