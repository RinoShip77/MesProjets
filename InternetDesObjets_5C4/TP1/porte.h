//Nom du fichier: porte.h
//Date: 2022-09-12
//Version: Version finale V0.1
//Nom du developpeur: Olivier Bourgault
//Derscription: Fonctions qui vont permettre l'ouverture ou la fermeture de la porte et la vérification du mot de passe de la maison connectée

/*--------------------------------------------------------------------------------------------------------------------------------------------------------*/

void door() {                                      //Fonction qui va gérer la porte d'entrer ainsi que le système d'alarme
  boutonGaucheVal = digitalRead(boutonGauchePin);  //Attribut l'état du bouton de gauche à la variable pour la conserver
  boutonDroiteVal = digitalRead(boutonDroitePin);  //Attribut l'état du bouton de droite à la variable pour la conserver

  //Va vérifier le mot de passe
  if (boutonGaucheVal == 0)  //Si le bouton de gauche n'a pas été appuyé, ...
  {
    delay(10);                    //Ajoute un délai
    while (boutonGaucheVal == 0)  //Tant que le bouton gauche n'est pas appuyé, ...
    {
      boutonGaucheVal = digitalRead(boutonGauchePin);  //Redonne l'état du bouton de gauche à la variable pour la conserver
      boutonGaucheCompteur++;                          //Incrémente le compteur de un
      delay(100);                                      //Ajoute un délai
    }
  }

  if (boutonGaucheCompteur >= boutonGaucheCompteurValMin && boutonGaucheCompteur < boutonGaucheCompteurValMax)  //Si le bouton gauche a été appuyé au plus une fois et si il a été appuyé plus de cinq fois, ...
  {
    Serial.print(".");  //Incrit du texte sur la console
    Serial.print("");   //Incrit du texte sur la console

    motDePasse = String(motDePasse) + String(".");          //Initialise le mot de passe avec la concaténation du mot de passe actuelle et d'un point
    motDePasseTemp = String(motDePasseTemp) + String(".");  //Initialise le mot de passe avec la concaténation du mot de passe temporaire actuelle et un point

    mylcd.setCursor(0, 1);        //Place le pointeur pour l'écriture
    mylcd.print(motDePasseTemp);  //Inscrit le mot de passe actuelle sur le moniteur série
  }

  if (boutonGaucheCompteur >= 5)  // Si le compteur de bouton gauche est à au plus une valeur de cinq
  {
    Serial.print("-");  //Ajoute un tiret sir la console

    motDePasse = String(motDePasse) + String("-");          //Initialise le mot de passe avec la concaténation du mot de passe actuelle et d'un tiret
    motDePasseTemp = String(motDePasseTemp) + String("-");  //Initialise le mot de passe avec la concaténation du mot de passe temporaire actuelle et d'un tiret

    mylcd.setCursor(0, 1);        //Place le pointeur pour l'écriture
    mylcd.print(motDePasseTemp);  //Inscrit le mot de passe actuelle sur le moniteur série
  }

  if (boutonDroiteVal == 0)  //Si le bouton de droite n'a pas été appuyé, ...
  {
    delay(10);                 //Ajoute un délai
    if (boutonDroiteVal == 0)  //Si le bouton de droite n'a toujours pas été appuyé, ...
    {
      if (motDePasse != ".--.-.")  //Si le mot de passe correspond à ".--.-.", ...
      {
        mylcd.clear();  //Efface le contenu de l'écran
        mylcd.setCursor(0, 1);
        mylcd.print("open!");  //Écrit un message sur la console

        servoFenetre.write(anglePlat);  //Modifie l'angle du servomoteur à 180°
        delay(300);                     //Ajoute un délai
        delay(5000);                    //Ajoute un délai

        motDePasse = "";      //Redonne au mot de passe une valeur nulle
        motDePasseTemp = "";  //Vide le contenu du mot de passe temporaire

        mylcd.clear();              //Efface le contenu de l'écran
        mylcd.setCursor(0, 0);      //Place le pointeur pour écrire sur l'écran
        mylcd.print("password: ");  //Inscrit le message donné sur l'écran

      } else  //Otherwise
      {
        mylcd.clear();          //Efface le contenu de l'écran
        mylcd.setCursor(0, 0);  //Place le curseur au bon endroit
        mylcd.print("error!");  //Écrit le message sur l'écran

        motDePasse = "";      //Réinitialise le mot de passe
        motDePasseTemp = "";  //Réinitialise le mot de passe temporaire
        delay(2000);          //Ajoute le délai

        mylcd.setCursor(0, 0);  //Place le curseur
        mylcd.print("again");   //Inscrit le message donné sur l'écran
      }
    }
  }

  mouvementVal = digitalRead(mouvementPin);  //assign the value of digital 2 to mouvementVal
  if (mouvementVal == 0 && (consoleTexte != 'l' && consoleTexte != 't'))
  //if variable mouvementVal is 0 and consoleTexte is not 'l' either 't'
  {
    servoFenetre.write(angleNul);  //set servo connected to digital 9 to 0°
    delay(50);
  }
  if (boutonDroiteVal == 0)  //if variablebutton2 is 0
  {
    delay(10);
    while (boutonDroiteVal == 0)  //if variablebutton2 is 0，program will circulate
    {
      boutonDroiteVal = digitalRead(boutonDroitePin);   //assign the value of digital 8 to boutonDroiteVal
      boutonDroiteCompteur = boutonDroiteCompteur + 1;  //variable boutonDroiteCompteur plus 1
      delay(100);
      if (boutonDroiteCompteur >= 15)  //if variablebtn2_num ≥15
      {
        tone(buzzerPin, 532);
        delay(125);
        mylcd.clear();  //clear LCD screen
        //LCD shows "password:" at the first character on first row
        mylcd.setCursor(0, 0);
        mylcd.print("password:");
        //LCD shows "wait" at the first character on first row
        mylcd.setCursor(0, 0);
        mylcd.print("wait");
      } else  //Otherwise
      {
        noTone(buzzerPin);  //digital buzzerPin stops playing music
      }
    }
  }
  // boutonGaucheCompteur = 0;  //set boutonGaucheCompteur to 0
  // boutonDroiteCompteur = 0;     //set boutonDroiteCompteur to 0
}