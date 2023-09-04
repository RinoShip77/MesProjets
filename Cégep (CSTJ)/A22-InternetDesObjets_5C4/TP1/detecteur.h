//Nom du fichier: detecteur.h
//Date: 2022-09-12
//Version: Version finale V0.1
//Nom du developpeur: Olivier Bourgault
//Derscription: Algorithme pour gérer la lecture de tous les capteurs de la maison intelligentes

/*--------------------------------------------------------------------------------------------------------------------------------------------------------*/

void gererCapteur() {  //Fonction qui va permettre la gestion et la récolte de donné de tous les capteurs
  /**********************************Capteur de gaz***********************************************/
  gazVal = analogRead(gazPin);  //Attribue la valeur analogue à la variable
  if (gazVal > gazMaxVal) {     //Si la valeur du gaz actuelle est supérieure à la limite de gaz, ...
    gazFlagVal = 1;             //Indicateur de présence de gazVal

    while (gazVal == 1) {    //Tant que du gaz est présent, ...
      tone(buzzerPin, 150);  //Envoie un signal sonore de 500 hertz
      delay(1500);           //Ajoute un délais
      noTone(buzzerPin);     //Arrête le bruit
      delay(250);            //Ajoute un délais
    }
  } else if (gazVal < gazMinVal) {  //Si la valeur de gaz est inférieure à la limite inférieure
    gazFlagVal = 0;                 //Indique qu'il n'y a plus de gaz
  }

  /********************************Capteur de lumière*********************************************/
  if (lumiereVal < lumiereMinVal) {            //Si la valeur de lumière est inférieur à la limite, ...
    lumiereFlagVal = 1;                        //Il y a de la lumière
    mouvementVal = digitalRead(mouvementPin);  //Initialise la variable avec la lecture effectuée sur le capteur de mouvement

    if (mouvementVal == 1)  //Si ça bouge, ...
    {
      digitalWrite(diodeBlanchePortePin, HIGH);  //Va allumer la diode jaune
      Serial.println("IL Y A DU MOUVEMENT!");    //Imprime un avertissement sur la console
      delay(10000);                              //Ajoute un délai

      while (mouvementVal == 1) {  //Tant que du gaz est présent, ...
        tone(buzzerPin, 150);      //Envoie un signal sonore de 500 hertz
        delay(1500);               //Ajoute un délais
        noTone(buzzerPin);         //Arrête le bruit
        delay(250);                //Ajoute un délais
      }
    } else {
      digitalWrite(diodeBlanchePortePin, LOW);  //Éteint la diode jaune
    }
  } else {
    lumiereFlagVal = 0;  //Remet la variable à zéro
  }

  /*********************************Capteur de pluie**********************************************/
  pluieVal = analogRead(pluiePin);       //Initialise la variable avec la lecture effectuée sur le capteur de mouvement
  if (pluieVal > pluieMaxVal) {          //Si la valeur de pluie actuelle est supérieure à la limite de pluie, ...
    pluieFlagVal = 1;                    //Il pleut
    Serial.println("SAUVE QUI PLEUT!");  //Imprime le message sur la console
    servoPorte.write(anglePlat);         //Change l'angle du servomoteur pour atteindre 180°
    pluieVal = analogRead(pluiePin);     //Attribut la lecture sur le détecteur de pluie à la variable

    while (mouvementVal == 1) {  //Tant que du gaz est présent, ...
      tone(buzzerPin, 150);      //Envoie un signal sonore de 500 hertz
      delay(1500);               //Ajoute un délais
      noTone(buzzerPin);         //Arrête le bruit
      delay(250);                //Ajoute un délais
    }
  } else if (pluieVal < pluieMinVal) {  //Si la valeur du gaz actuelle est inférieur à la limite de pluie, ...
    pluieFlagVal = 0;                   //Remet la variable à zéro
  }
  servoPorte.write(angleNul);  //Change l'angle du servomoteur pour atteindre 0°

  /*********************************Capteur d'humidité********************************************/
  humiditeFleurVal = analogRead(humiditeFleurPin);  //Initialise la variable avec la lecture effectuée sur le capteur d'humidité
  if (humiditeFleurVal > humiditeFleurMinVal) {     //Si la valeur d'humidité actuelle est supérieure à la limite d'humidité, ...
    humiditeFleurFlagVal = 1;                       //S'est humide

    while (mouvementVal == 1) {  //Tant que du gaz est présent, ...
      tone(buzzerPin, 150);      //Envoie un signal sonore de 500 hertz
      delay(1500);               //Ajoute un délais
      noTone(buzzerPin);         //Arrête le bruit
      delay(250);                //Ajoute un délais
    }

    if (humiditeFleurFlagVal == 1 && humiditeFleurVal < humiditeFleurMaxVal) {  //Si s'est humide et que la valeur de l'humidité actuelle est supérieur à la limite d'humidité, ...
      humiditeFleurFlagVal = 0;                                                 //Remet la variable à zéro
    }
  }
  door();  //Appelle une fonction externe
}