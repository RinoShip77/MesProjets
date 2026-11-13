/* 
   -----------------------------------------------------------------------
   Projet:         Épreuve Synthèse
   Nom du fichier: 1875009-SYN4201C4-2021 - Uno
   Auteur:         Olivier Bourgault
   Date:           2021.11.15
   -----------------------------------------------------------------------
   Description:    {
     Programmer un système d'alarme
   }
   -----------------------------------------------------------------------
   M-A-J: 
   2021-11-14 OB-V1
   2021-11-19 OB-V2
   2021-11-21 OB-V3
   2021-11-22 OB-V4
   2021-11-28 OB-V5
   2021-12-05 OB-V6
   -----------------------------------------------------------------------
*/
#include <Wire.h> //Bibliothèque pour le port 'i2c'
#include <Adafruit_NeoPixel.h> //Inclure la bibliothèque pour la barrette de LED
#include "rgb_lcd.h" //Bibliothèque pour l'écran LCD
#include "DHT.h" //Bibliothèque pour le détecteur de température
#include <SoftwareSerial.h> //Biblioth`que pour communiquer entre le Arduio Uno et le Arduino Mega
#include "DS1307.h" //Bibliothèque pour l'horloge
#include "code.alarme.h" //Inclus la bibliothèque locale

//Barette de LED
const int stripPin = 2; //Quelle PIN est connectée au NEOPIXELS
const int stripNombre = 10; //Combien de LED sur notrebarrette NEOPIXELS
const int stripIntensite = 50; //À combien on allumer les LED de la barrette de LED
Adafruit_NeoPixel strip(stripNombre, stripPin, NEO_GRB + NEO_KHZ800); //On crée un objet pour la barrette de LED

//Écran LCD
const int colorR = 255; //Initialise la couleur rouge de l'affichage de l'écran LCD
const int colorG = 255; //Établis l'écran LCD lors de l'affichage de couleur vert
const int colorB = 255; //Constante pour la couleur bleu de l'écran LCD
rgb_lcd lcd; //Crée un objet de LCD, donc initialise la LCD avec le code de la bibliothèque

//Potentiomètre
const int potPin = A0; //Potentiomètre à résistance variable
int potVal = 0; //Variable pour le potentiometre

//Bouton
const int boutonPin = 6; //Bouton momentané sur ce branchement
bool boutonAppuye = false; //Indique si le bouton est enfoncé ou non
int boutonCount = 0; //Compte le nombre de fois qu'on a appuyé sur le bouton

//Détecteur de mouvements
const int moveSensorPin = 3; //Détecteur de mouvements sur ce branchement
String moveSensorVal = "OFF"; //Contiendra la valeur lue sur le détecteur de mouvements

//LED
const int DELPin = 4; //LED sur ce branchement

//Sonde de température
#define DHTTYPE DHT11 //Va définir le type de détecteur de température on va utiliser
const int DHTPIN = 3; //Sonde de température connectée sur ce branchement
DHT dht(DHTPIN, DHTTYPE); //On crée un objet pour le détecteur de température

//Communication vers Arduino Mega
SoftwareSerial mySerial(8, 7); //Pour établir la connection entre les Arduino sur ce port

//Horloge
DS1307 clock; //Définit un objet pour l'horloge

//Variables locales supplémentaires
//Pour le système d'alarme
bool systemeArmee = false; //Indique si le système est armée ou non
bool interfaceConfiguration = false; //Indique si le programme est dans sa zone de configuration
const String codeSystemeAlarme = "4 2 0 3"; //Correspond au code du système d'alarme
bool validationCode = false; //Indique si le code entré sera valide
codesAlarme unCodeAlarme = systeme_enligne; //Déclaration d'une énumération pour connaître l'état du système

//Pour la tempérture
const float temperatureMax = 30; //Représente la température maximale

//Pour les délais
unsigned long tempsDepart = 0; //Contient le nombre de millisecondes depuis le démarrage du système
unsigned long tempsBouton = 0; //Contient le nombre de millisecondes depuis l'appui sur le bouton
unsigned long tempsSaisieCode = 0; //Contient le nombre de millisecondes depuis la saisie du code
const int delais = 1000; //Correspond à un délais local de une seconde

void setup() //Initialisation du Arduino
{
  Serial.begin(115200); //Initialiser la console

  //Barrette de LED
  pinMode(stripPin, OUTPUT); //Barrette de LED
  strip.begin(); //Initialise l'objet de labarrette de LED
  strip.show(); //Étteint toutes les LED
  strip.setBrightness(stripIntensite); //Initialise l'intensité de l'allumage
  
  //Écran LCD
  lcd.begin(16, 2); //Initialise l'affichage de l'écran LCD
  lcd.setRGB(0, colorG, 0); //Initialise les couleurs de l'affichage

  //Potentiomètre
  pinMode(potPin, INPUT); //Initialise le potentiometre en entrée
  pinMode(potPin, INPUT); //On utilise le connecteur analogue du potentiomètre

  //Bouton
  pinMode(boutonPin, INPUT); //Initialise le bouton en entrée

  //Détecteur de mouvements
  pinMode(moveSensorPin, INPUT); //Initialise le détecteur de mouvements en entrée

  //LED
  pinMode(DELPin, OUTPUT);  //Initialise la LED Externe en sortie

  //Sonde de température
  Wire.begin(); //pour parler au DHT
  dht.begin(); //Initialise le DHT (détecteur de tempéreture)

  //Horloge
  clock.begin(); //Dit à l'horloge de s'activer
	clock.fillByYMD(2021,11,22); //22 novembre 2021
	clock.fillByHMS(8,53,00); //8:51:00
	clock.fillDayOfWeek(MON); //Lundi
  clock.setTime(); //Inscrit l'heure sur l'horloge

  //Initialisation de l'horloge interne
  tempsDepart = millis();
  tempsBouton = millis();
  tempsSaisieCode = millis();

  //Affichage des données initiales :
  //Affichage du détecteur de mouvement sur la console
  if(digitalRead(moveSensorPin))
  {
    moveSensorVal = "ON";
  }
  Serial.print("Détecteur de mouvement: ");
    Serial.println(moveSensorVal);

  //Affichage de la valeur du potentiomètre sur la console
  Serial.print("Potentiomètre: ");
    Serial.println(map(analogRead(potPin), 0, 1023, 0, 255));

  //Affichage du détecteur de température sur la console
  float temp_hum_val[2] = {0};
  if(!dht.readTempAndHumidity(temp_hum_val))
  {
    Serial.print("Température: "); 
    Serial.print(int(temp_hum_val[1]));
      Serial.println("c");
  }

  //Affichage de la valeur du bouton sur la console
  if(digitalRead(boutonPin))
  {
    boutonCount++;
  }
  Serial.print("Accumulateur du bouton: ");
    Serial.println(boutonCount);
  boutonCount = 0; //Réinitialise le comteur du bouton

  //Affichage de la date et l'heure sur la console
  Serial.print("Temps: ");
    Serial.print(clock.year, DEC);
  Serial.print(".");
    Serial.print(clock.month, DEC);
  Serial.print(".");
    Serial.print(clock.dayOfMonth, DEC);
  Serial.print(" ");
    Serial.print(clock.hour, DEC);
  Serial.print(":");
    Serial.print(clock.minute, DEC);
  Serial.print(":");
    Serial.println(clock.second, DEC);

  //Communication vers Arduino Mega
  mySerial.begin(115200); //Initialise la console pour l'autre arduino

  //Envoi un message à la centrale
  mySerial.write(unCodeAlarme); //Envoyer l'état du système d'alarme à la centrale
}

void loop() //Boucle infinie
{
  float temp_hum_val[2] = {0}; //Contiendra les données du détecteur de température
  potVal = map(analogRead(potPin), 0, 1023, 0, 9); //Obtient la valeur du potentiomètre

  if(millis() <= (delais * 10)) { //Affichage sur l'écran LCD pendant 10 secondes
    lcd.setCursor(0, 0); //Place le curseur sur la première case de la première rangée de l'écran LCD
      lcd.print("Alarme 420-1C4"); //Affiche un premier message à l'écran
    lcd.setCursor(0, 1); //Place le curseur sur la première case de la deuxième rangée de l'écran LCD
      lcd.print("Dormez en paix"); //Affiche un second message à l'écran
  } else {
    unCodeAlarme = alarme_inactive; //Envoyer un code d'inactivité à la centrale
    mySerial.write(unCodeAlarme);

    if(delaisAtteint()) {
      interfaceConfiguration = true; //On change la valeur de la variable locale
      lcd.clear(); //Efface le contenu de l'écran
        lcd.setRGB(colorR, 0, 0); //Met l'écran en rouge
      String messageBase = messageConfiguration(); //Le message sera le résultat d'une fonction
      for(int position = 0; position <= messageBase.length() - 16; position++) //Va itérer selon la longueur de la chaîne et la valeur de la variable locale
      {
        afficherCaracteres(position, messageBase); //Appele une fonction avec la position du caractère à imprimer et la chaîne complète de caractères
      }
      tempsDepart = millis(); //Mettre la variable locale au temps présent

      if(interfaceConfiguration) { //Si le programme est dans sa configuration, ...
        if(digitalRead(boutonPin)) { //Si le bouton est enfoncé, ...
          boutonAppuye = true; //On change la valeur de la variable locale
          while(digitalRead(boutonPin)); //Tant que le bouton est enfoncé
        }

        if(((millis() - tempsDepart) > (delais * 30)) && !boutonAppuye) { //Si Le bouton n'a pas été appuyé dans la période de delai, ...
          lcd.clear(); //Efface le contenu de l'écran
          lcd.setRGB(0, 0, 0); // Éteindre le LCD
          delay(10000); //Met le système en veille pendant dix secondes
        }

        if(boutonAppuye) { //Allumer le LCD, peut importe son état, si le bouton a été appuyé, ...
          boutonCount++; //Incrémente l'accumulateur du bouton
          boutonAppuye = false; //On change la valeur de la variable locale
          digitalWrite(DELPin, HIGH); //Allume la DEL sur le Arduino
          lcd.setRGB(colorR, colorG, colorB); //Allume l'écran
            lcd.clear();
          lcd.setCursor(0, 0); //Place le curseur sur la première case de la première rangée de l'écran LCD
            lcd.print("Entrez le code:"); //Affiche un premier message à l'écran
          saisirCode(); //Fonction qui va gérer la saisie du code
          flashBaretteRougeBleu(); //Fait clignoter la barette de LED
          tempsBouton = millis(); //Réinitialise le temps du bouton
        }
      }
    }
    digitalWrite(DELPin, LOW); //Éteint la DEL sur le Arduino
  
    if(digitalRead(moveSensorPin)) { //Si on détecte du mouvement, ...
      unCodeAlarme = detection_mouvement; //Envoyer un code de détection de mouvement à la centrale
      mySerial.write(unCodeAlarme);
      while(digitalRead(moveSensorPin)); //Tant que le détecteur est actif
      moveSensorVal = "ON"; //Conserve la valeur du détecteur de mouvement dans une variable locale
    }

    if(!dht.readTempAndHumidity(temp_hum_val) && temp_hum_val[1] > temperatureMax) { //Si la température est supérieure à la limite, ...
      unCodeAlarme = temperature_depassee; //Envoyer un code de température trop élevée à la centrale
      mySerial.write(unCodeAlarme);
      while(temp_hum_val[1] > temperatureMax); //Tant que la température est élevée
    }

    if(systemeArmee) { //Si le sytème est arméee, ...
      if(!dht.readTempAndHumidity(temp_hum_val))
      {
        clock.getTime(); //Obtient les données de l'horloge
        lcd.clear(); //Efface le contenu de l'écran ultérieur

        lcd.setCursor(0, 0); //Place le curseur sur la première case de la première rangée de l'écran LCD<
        //Affiche la température ambiante
          lcd.print("Tmp: "); 
        lcd.print(int(temp_hum_val[1]));
          lcd.print("c ");

        //Affiche le détecteur de mouvements
        lcd.print("Mov:");
          lcd.print(moveSensorVal);

        lcd.setCursor(9, 1); //Place le curseur sur la première case de la deuxième rangée de l'écran LCD
        //Affiche l'heure actuelle
          lcd.print(clock.hour);
        lcd.print(":");
          lcd.print(clock.minute);
        lcd.print(":");
          lcd.println(clock.second);

        unCodeAlarme = alarme_active; //Envoyer un code qui indique que l'alarme est activée à la centrale
        mySerial.write(unCodeAlarme);
      }
    }
  }
}

void saisirCode() { //Affichera le code à l'écran LCD
  String valeur = "";

  Serial.println(boutonCount);
  switch (boutonCount) { //Selon la valeur numérique de l'accumulateur du bouton
    case 1:      
      valeur += "*"; //Ajoute l'astérix au message
      valeur += potVal; //Ajoute la valeur du potentiomètre
      valeur += " 2 3 4 OK"; //Ajoute la suite du code
      break;
    case 2:
      valeur += "1 *"; //Ajoute l'astérix au message
      valeur += potVal; //Ajoute la valeur du potentiomètre
      valeur += " 3 4 OK"; //Ajoute la suite du code
      break;
    case 3:
      valeur += "1 2 *"; //Ajoute l'astérix au message
      valeur += potVal; //Ajoute la valeur du potentiomètre
      valeur += " 4 OK"; //Ajoute la suite du code
      break;
    case 4:
      valeur += "1 2 3 *"; //Ajoute l'astérix au message
      valeur += potVal; //Ajoute la valeur du potentiomètre
      valeur += " OK"; //Ajoute la suite du code
      break;
    case 5:
      valeur += "1 2 3 4 *OK"; //Ajoute un message de confirmation
      boutonCount = 0; //Réinitialise le compteur du bouton
      if(valeur.substring(0, 7) == codeSystemeAlarme) { //Si la caîne correspond, ...
        tempsSaisieCode = millis(); //Remet le temps quand on a entré le code égale au temps courant
        validationCode = true; //Le code est valide
      }
      break;
    }

  if(!validationCode) { //Si le code est invalide, ...
    unCodeAlarme = code_invalide; //Envoyer un code qui indique que le code entrée est incorrecte à la centrale
    mySerial.write(unCodeAlarme);
  } else { //Sinon, ...
    systemeArmee = true; //Le système est maintenant armée
    unCodeAlarme = code_valide; //Envoyer un code qui indique que le code entrée est correcte à la centrale
    mySerial.write(unCodeAlarme);
  }

  lcd.setCursor(0, 1); //Place le curseur sur la première case de la première rangée de l'écran LCD
    lcd.print(valeur); //Imprime le code sur l'écran LCD
}

void flashBaretteRougeBleu() { //Fait clignoter lla barette de LED de rouge à bleu
  afficherRougeSurNeoPixel(); //Allume les LED en rouges
  afficherBleuSurNeoPixel(); //Allume les LED en bleu
  afficherRougeSurNeoPixel(); //Allume les LED en rouges
  eteindreNeoPixel(); //Éteint toutes la barette
}

void afficherRougeSurNeoPixel() { //Allume toutes les LED présentes sur la barette en rouge
  strip.clear(); //Éteint la barette de LED
  for(int pixel = 0; pixel <= stripNombre; pixel++) { //Boucle pour parcourir les LED de la barette
    strip.setPixelColor(pixel, strip.Color(colorR, 0, 0)); //Donne une couleur à une LED préise
  }
  strip.show(); //Allume les LED de la barette
  delay(500); //Force la fonction à attedre une demie seconde
}

void afficherBleuSurNeoPixel() { //Allume toutes les LED présentes sur la barette en bleu
  strip.clear(); //Éteint la barette de LED
  for(int pixel = 0; pixel <= stripNombre; pixel++) { //Boucle pour parcourir les LED de la barette
    strip.setPixelColor(pixel, strip.Color(0, 0, colorB)); //Donne une couleur à une LED préise
  }
  strip.show(); //Allume les LED de la barette
  delay(500); //Force la fonction à attedre une demie seconde
}

void eteindreNeoPixel() { //Éteint toutes les LED présentes sur la barette
  strip.clear(); //Éteint la barette de LED
  for(int pixel = 0; pixel <= stripNombre; pixel++) { //Boucle pour parcourir les LED de la barette
    strip.setPixelColor(pixel, strip.Color(0, 0, 0)); //Donne une couleur à une LED préise
  }
  strip.show(); //Allume les LED de la barette
  delay(500); //Force la fonction à attedre une demie seconde
}

bool delaisAtteint() //Fonction pour confirmer si on a attendue assez longtemps
{
  static unsigned long tempsDepart = millis();
  if ((millis() - tempsDepart) > delais) { //Si nous avons atteint le delais
    return true;
    tempsDepart = millis(); //Remplacer la variable locale par le moment courant
  } else {
    return false;
  }
}

String messageConfiguration() { //Va retourner le message d'accueil
  String message = "Systeme d'alarme 420-1C4. Nous sommes "; //On ajoute le début du message, ...

  //On ajoute ensuite plusieurs données à la chîne de caractères, ...
  message += nomDuJour();           //- Le résultat d'une fonction
  message += " le ";                //- Une chaîne de caractères
  message += clock.dayOfMonth;      //- Une valeur numérique
  message += " ";                   //- Une chaîne de caractères
  message += nomDuMois();           //- La valeur d'une fonction
  message += " ";                   //- Une chaîne de caractères
  message += clock.year + 2000;     //- Une valeur numérique à laquelle on ajoute le siècle actuelle
  message += " et il est ";         //- Une chaîne de caractères
  message += clock.hour;            //- Une valeur numérique
  message += ":";                   //- Une chaîne de caractères
  message += clock.minute;          //- Une valeur numérique
  message += ":";                   //- Une chaîne de caractères
  message += clock.second;          //- Une valeur numérique

  message += ". Pour la configuration du systeme, appuyer sur le bouton de panique..."; //Pour ensuite ajouter la fin de la phrase

  return message; //Finalement, on retourne toutes les données en les concaténant dans une seule chaine de caractères
}

String nomDuJour() { //Va retouner le nom en français du jour de la semaine
  String jour = ""; //On déclare la chaîne de caractères 

  clock.getTime(); //Obtient les données de l'horloge

  switch (clock.dayOfWeek) //Selon la valeur numérique du jour de la semaine de l'horloge, on va attribuer le nom en français de celui-ci
	{
		case 1:
		  jour = "lundi";
		  break;
		case 2:
		  jour = "mardi";
		  break;
		case 3:
		  jour = "mercredi";
		  break;
		case 4:
		  jour = "jeudi";
		  break;
		case 5:
		  jour = "vendredi";
		  break;
		case 6:
		  jour = "samedi";
		  break;
		case 7:
		  jour = "dimanche";
		  break;
	}

  return jour; //Finalement, on retourne le jour de la semaine
}

String nomDuMois() { //Va retouner le nom en français du mois de l'année
  String mois = ""; //On déclare la chaîne de caractères 

  clock.getTime(); //Obtient les données de l'horloge

  switch (clock.month) //Selon la valeur numérique du mois de l'année de l'horloge, on va attribuer le nom en français de celui-ci
	{
		case 1:
		  mois = "janvier";
		  break;
		case 2:
		  mois = "février";
		  break;
		case 3:
		  mois = "mars";
		  break;
		case 4:
		  mois = "avril";
		  break;
		case 5:
		  mois = "mai";
		  break;
		case 6:
		  mois = "juin";
		  break;
		case 7:
		  mois = "juillet";
		  break;
		case 8:
		  mois = "aout";
		  break;
		case 9:
		  mois = "septembre";
		  break;
		case 10:
		  mois = "octobre";
		  break;
		case 11:
		  mois = "novembre";
		  break;
		case 12:
		  mois = "décembre";
		  break;
	}

  return mois; //Finalement, on retourne le mois de l'année
}

void afficherCaracteres(int position, String message)
{
  lcd.setCursor(0, 0); //Place le curseur sur la première case de la première rangée de l'écran LCD
  for(int nombre = position; nombre <= position + 15; nombre++) { //Va itérer selon la condition et la valeur de la variable locale
    lcd.print(message.charAt(nombre)); //Imprime un caractère sur l'écran
  }
  lcd.print(" "); //Décale le tout vers la gauche ...
  delay(250); //Attendre un peu, dans le but de ralentir le défilement ...
}