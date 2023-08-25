//Nom du fichier: fonction.h
//Date: 2022-09-12
//Version: Version finale V0.1
//Nom du developpeur: Olivier Bourgault
//Derscription: Toutes les fonctions nécessaires au fonctionnement de différentes tâches dans la maison connectée

/*--------------------------------------------------------------------------------------------------------------------------------------------------------*/

void InitialiserEcran(int colonne = 0, int ligne = 0, String texte = "") {  //Fonction pour configurer l'écran
  mylcd.init();                                                             //Initialiser l'écran LCD
  mylcd.backlight();                                                        //Allume le rétroéclairage
  mylcd.setCursor(colonne, ligne);                                          //Place le curseur pour commencer à écrire
  mylcd.print(texte);                                                       //Affiche du texte sur l'écran
}

void InitialiserMoteur(Servo moteur, int pin = 0) {  //Fonction qui va préparer le servomoteur
  moteur.attach(pin);                                //Faire que le moteur se connecte au bon branchement
  moteur.write(angleNul);                            //Change l'angle du moteur pour le mettre à 0°
  delay(300);                                        //Ajoute un délai
}

void InitialiserVentilateur(int pinINA = 0, int pinINB = 0) {  //Fonction  pour configurer le ventilateur
  pinMode(pinINA, OUTPUT);                                     //Met le branchement digitale en mode de sortie
  digitalWrite(pinINA, HIGH);                                  //Allume le branchement INA
  pinMode(pinINB, OUTPUT);                                     //Met le branchement digitale en mode de sortie
  digitalWrite(pinINB, HIGH);                                  //Allume le branchement INB
}