//Nom du fichier: TP1-1875009.ino
//Date: 2022-09-12
//Version: Version finale V0.1
//Nom du developpeur: Olivier Bourgault
//Derscription: Révision du programme de gestion de la maison connectée

/*--------------------------------------------------------------------------------------------------------------------------------------------------------*/
//Ajouts de bibiothèques de codes déja existante ou de fichiers pour compléter le code

//Les librairies de codes requises:
#include <Servo.h>              //Gestion des servo-moteurs
#include <Wire.h>               //Gestion de la connection I2C (plusieurs connections possibles)
#include <LiquidCrystal_I2C.h>  //Gestion de l'écran LCD avec la communication I2C

//Les documents complémentaires:
#include "variable.h"   //Contient les objets, les constantes ainsi que les variables pour le code
#include "fonction.h"   //Contient toutes les fonctions externes au programme principale
#include "porte.h"      //Contient les fonctions nécessaires à la gestion de la porte et du mot de passe de la maison
#include "detecteur.h"  //Contient les fonctions pour vérifier les multiples capteurs de la maison
#include "musique.h"    //Contient les données et les fonctions reliées avec les mélodies

/*--------------------------------------------------------------------------------------------------------------------------------------------------------*/
//Debut du code

void setup() {                                           //Fonction pour initialiser toutes les capteurs et objets de la maison
  Serial.begin(9600);                                    //Activer la console pour pouvoir recevoir les données
  longueurDeLaMusique = sizeof(tune) / sizeof(tune[0]);  //Initialise la valeur de la variable avec la taille du tableau de notes

  //Redirection vers d'autre fonctions:
  InitialiserEcran(0, 0, "password: ");                          //Appelle une fonction en lui passant trois paramètres pour configurer l'écran
  InitialiserVentilateur(ventilateurINAPin, ventilateurINBPin);  //Appelle une fonction en lui passant trois paramètres pour configurer le ventilateur
  InitialiserMoteur(servoFenetre, servoFenetrePin);              //Appelle une fonction en lui passant trois paramètres pour configurer le moteur de la fenêtre
  InitialiserMoteur(servoPorte, servoPortePin);                  //Appelle une fonction en lui passant trois paramètres pour configurer le moteur de la porte

  //Attribution de quelques branchements:
  pinMode(diodeBlanchePortePin, OUTPUT);  //Attribut le signal de la diode à la PIN numéro 13
  pinMode(relaisPin, OUTPUT);             //Attribut le signal du module de relais à la PIN numéro 12
  pinMode(boutonGauchePin, INPUT);        //Attribut le signal du bouton de gauche à la PIN numéro 4
  pinMode(boutonDroitePin, INPUT);        //Attribut le signal du bouton de droite à la PIN numéro 8
  pinMode(diodeJaunePin, OUTPUT);         //Attribut le signal de la diode jaune à la PIN numéro 5
  pinMode(buzzerPin, OUTPUT);             //Attribut le signal du buzzer à la PIN numéro 3
  pinMode(gazPin, INPUT);                 //Attribut le signal du détecteur de gaz à la PIN numéro A0
  pinMode(lumierePin, INPUT);             //Attribut le signal du détecteur de lumière à la PIN numéro A1
  pinMode(mouvementPin, INPUT);           //Attribut le signal du détecteur de mouvements à la PIN numéro 2
  pinMode(pluiePin, INPUT);               //Attribut le signal du détecteur de pluie à la PIN numéro A3
  pinMode(humiditeFleurPin, INPUT);       //Attribut le signal du détecteur d'humidité du sol à la PIN numéro A2

  Serial.println(F("Maison Corrigée - V1.0 - Fin du Setup"));  //Va afficher un message sur le moniteur série
}

void loop() {      //Fonction qui va s'exécuter en boucle (sans arrêt)
  gererCapteur();  //Appelle une fonction externe pour automatiser les différents objets

  if (Serial.available() > 0)  //Si la console contient des caractères, on fait le code qui suit
  {
    consoleTexte = Serial.read();  //Va conserver les caractères lues sur la console dans une variable locale
    GestionMoteurConsole();        //Appelle une fonction du même fichier
  }

  switch (consoleTexte) {                        //Définition d'une fonction qui va choisir la section de code à exécuter selon le carctère de la console
    case 'a':                                    //Si c'est 'a', ...
      digitalWrite(diodeBlanchePortePin, HIGH);  //Allume la diode de la porte
      break;                                     //On sort de la boucle

    case 'b':                                   //Si c'est 'b', ...
      digitalWrite(diodeBlanchePortePin, LOW);  //Éteint la diode de la porte
      break;                                    //On sort de la boucle

    case 'c':                         //Si c'est 'c', ...
      digitalWrite(relaisPin, HIGH);  //Allume le module de relais
      break;                          //On sort de la boucle

    case 'd':                        //Si c'est 'd', ...
      digitalWrite(relaisPin, LOW);  //Éteint le module de relais
      break;                         //On sort de la boucle

    case 'e':  //Si c'est 'e', ...
      //music1();                                  //Joue la musique d'anniversaire
      Son();  //Appelle une fonction externe pour jouer une simple note
      break;  //On sort de la boucle

    case 'f':  //Si c'est 'f', ...
      //music2();                                  //Joue la symphonie nᵒ 9
      Son();  //Appelle une fonction externe pour jouer une simple note
      break;  //On sort de la boucle

    case 'g':  //Si c'est 'g', ...
      //noTone(buzzerPin);                         //On arrête la musique
      Son();  //Appelle une fonction externe pour jouer une simple note
      break;  //On sort de la boucle

    case 'h':                      //Si c'est 'h', ...
      Serial.println(lumiereVal);  //Imprime la valeure du détecteur de lumière sur une nouvelle ligne du moniteur série
      delay(100);                  //Ajoute un délai
      break;                       //On sort de la boucle

    case 'i':                  //Si c'est 'i', ...
      Serial.println(gazVal);  //Imprime la valeure du détecteur de gaz sur une nouvelle ligne du moniteur série
      delay(100);              //Ajoute un délai
      break;                   //On sort de la boucle

    case 'j':                            //Si c'est 'j', ...
      Serial.println(humiditeFleurVal);  //Imprime la valeure du détecteur d'humidité dans le sol sur une nouvelle ligne du moniteur série
      delay(100);                        //Ajoute un délai
      break;                             //On sort de la boucle

    case 'k':                    //Si c'est 'k', ...
      Serial.println(pluieVal);  //Imprime la valeure du détecteur de pluie sur une nouvelle ligne du moniteur série
      delay(100);                //Ajoute un délai
      break;                     //On sort de la boucle

    case 'l':                         //Si c'est 'l', ...
      servoFenetre.write(anglePlat);  //Change l'angle de la fenêtre pour qu'il atteigne 180°
      delay(500);                     //Ajoute un délai
      break;                          //On sort de la boucle

    case 'n':                       //Si c'est 'n', ...
      servoPorte.write(anglePlat);  //Change l'angle de la porte pour qu'il atteigne 180°
      delay(500);                   //Ajoute un délai
      break;                        //On sort de la boucle

    case 'p':                             //Si c'est 'p', ...
      digitalWrite(diodeJaunePin, HIGH);  //Allume la diode
      break;                              //On sort de la boucle

    case 'q':                            //Si c'est 'q', ...
      digitalWrite(diodeJaunePin, LOW);  //Éteint la diode
      break;                             //On sort de la boucle

    case 'r':                                 //Si c'est 'r', ...
      digitalWrite(ventilateurINAPin, LOW);   //Change le sens de rotation du ventilateur
      digitalWrite(ventilateurINBPin, HIGH);  //Fait tourner le ventilateur dans le sens anti-horaire le plus rapidement possible
      break;                                  //On sort de la boucle

    case 's':                                //Si c'est 's', ...
      digitalWrite(ventilateurINAPin, LOW);  //Change le sens de rotation du ventilateur
      digitalWrite(ventilateurINBPin, LOW);  //Arrête la rotation du ventilateur
      break;                                 //On sort de la boucle
  }
}

void GestionMoteurConsole() {                                 //Fonction qui va gerer les cas où on veut contrôler les moteurs
  switch (consoleTexte) {                                     //Définition d'une fonction qui va choisir la section de code à exécuter selon le carctère de la console
    case 't':                                                 //Si c'est 't', ...
      servoFenetreTexte = Serial.readStringUntil('#');        //Assigne à la variable les caractères de la console qui précédent le dièse
      servoFenetreAngle = String(servoFenetreTexte).toInt();  //Transforme ces caractères en une valeur numérique et on la sauvegarde dans la variable de l'angle
      servoFenetre.write(servoFenetreAngle);                  //Change l'angle du moteur pour celle dans la variable
      delay(300);                                             //Ajoute un délai
      break;                                                  //On sort de la boucle

    case 'u':                                             //Si c'est 'u', ...
      servoPorteTexte = Serial.readStringUntil('#');      //Assigne à la variable les caractères de la console qui précédent le dièse
      servoPorteAngle = String(servoPorteTexte).toInt();  //Transforme ces caractères en une valeur numérique et on la sauvegarde dans la variable de l'angle
      servoPorte.write(servoPorteAngle);                  //Change l'angle du moteur pour celle dans la variable
      delay(300);                                         //Ajoute un délai
      break;                                              //On sort de la boucle

    case 'v':                                           //Si c'est 'v', ...
      diodeJauneTexte = Serial.readStringUntil('#');    //Assigne à la variable les caractères de la console qui précédent le dièse
      diodeJauneVal = String(diodeJauneTexte).toInt();  //Transforme ces caractères en une valeur numérique et on la sauvegarde dans la variable
      analogWrite(diodeJaunePin, diodeJauneVal);        //Donne la valeur de la variable à la diode
      break;                                            //On sort de la boucle

    case 'w':                                             //Si c'est 'w', ...
      ventilateurTexte = Serial.readStringUntil('#');     //Assigne à la variable les caractères de la console qui précédent le dièse
      ventilateurVal = String(ventilateurTexte).toInt();  //Transforme ces caractères en une valeur numérique et on la sauvegarde dans la variable
      digitalWrite(ventilateurINAPin, LOW);               //Change le sens de rotation du ventilateur
      analogWrite(ventilateurINBPin, ventilateurVal);     //Donne la valeur de la variable au ventilateur. Plus la valeur est grande, plus le ventilateur tourne vite
      break;                                              //On sort de la boucle
  }
}