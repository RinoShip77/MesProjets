/* 
   -----------------------------------------------------------------------
   Projet:         Épreuve Synthèse
   Nom du fichier: 1875009-SYN4201C4-2021 - Mega
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
#include "code.alarme.h" //Inclus la bibliothèque locale

//Avertisseur sonore
const int buzzerPin = 4; //Avertisseur sonore sur ce branchement

void setup() {
  Serial.begin(115200); //Port série pour la console de débogage
  Serial2.begin(115200); // Port série pour la réception des codes du client UNO

  //Avertisseur sonore
  pinMode(buzzerPin, OUTPUT); //Initialise l'avertisseur sonore en sortie
}

void loop() {
  codesAlarme code; //Déclaration d'une variable locale qui est basée sur l'énumération locale
  if(Serial2.available()) {
    code = Serial2.read();

    // Tester les événements du système d'alarme
    if(code == systeme_enligne) { //Si le système client est en ligne, ...
      //On fait sonner deux fois l'avertisseur sonore
      buzzer(500);
      buzzer(500);
    }

    if(code == alarme_inactive) { //Si le système est inactif, ...
      //On fait sonner l'avertisseur sonore
      buzzer(1000);
    }

    if(code == alarme_active) { //Si l'alarme est activée, ...
      Serial.println("Systeme activé"); //Affiche un message sur la console
    }

    if(code == code_valide) { //Si le code saisie est correct, ...
      //On fait sonner l'avertisseur sonore
      buzzer(500);
    }

    if(code == code_invalide) { //Si le code saisie est incorret, ...
      //On fait sonner trois fois l'avertisseur sonore
      buzzer(500);
      buzzer(500);
      buzzer(500);
    }

    if(code == detection_mouvement) { //Si le système a détectée du mouvement, ...
      //On fait sonner quatre fois l'avertisseur sonore
      buzzer(500);
      buzzer(500);
      buzzer(500);
      buzzer(500);
    }
    
    if(code == temperature_depassee) { //Si c'est un cas de température trop élevée, ...
      //On fait sonner cinq fois l'avertisseur sonore
      buzzer(500);
      buzzer(500);
      buzzer(500);
      buzzer(500);
      buzzer(500);
    }
  }
}

void buzzer(int duree) { //Fait un beep avec le buzzer
  //Fait vibrer la buzzer
  tone(buzzerPin, 500, duree);
  delay(duree);
  noTone(buzzerPin);
  delay(duree);
}