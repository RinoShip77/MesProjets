//Nom du fichier: musique.h
//Date: 2022-09-12
//Version: Version finale V0.1
//Nom du developpeur: Olivier Bourgault
//Derscription: Code nécessaire à la gestion des musiques de la maison connectée

/*--------------------------------------------------------------------------------------------------------------------------------------------------------*/

//Definitions des constantes pour toutes les fréquences sonores a utiliser
const int D0 = -1;
const int D1 = 262;
const int D2 = 293;
const int D3 = 329;
const int D4 = 349;
const int D5 = 392;
const int D6 = 440;
const int D7 = 494;
const int M1 = 523;
const int M2 = 586;
const int M3 = 658;
const int M4 = 697;
const int M5 = 783;
const int M6 = 879;
const int M7 = 987;
const int H1 = 1045;
const int H2 = 1171;
const int H3 = 1316;
const int H4 = 1393;
const int H5 = 1563;
const int H6 = 1755;
const int H7 = 1971;

const int WHOLE = 1;
const int HALF = 0.5;
const int QUARTER = 0.25;
const int EIGHTH = 0.25;
const int SIXTEENTH = 0.625;

//Definit un tableau qui précise les fréquences du son
int tune[] = {
  M3, M3, M4, M5, M5, M4, M3, M2, M1, M1, M2, M3, M3,
  M2, M2, M3, M3, M4, M5, M5, M4, M3, M2, M1, M1, M2,
  M3, M2, M1, M1, M2, M2, M3, M1, M2, M3, M4, M3, M1,
  M2, M3, M4, M3, M2, M1, M2, D5, D0, M3, M3, M4, M5,
  M5, M4, M3, M4, M2, M1, M1, M2, M3, M2, M1, M1
};

//Déclare un tableau qui dicte le tempo de la musique
float durt[] = {
  1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1 + 0.5, 0.5,
  1 + 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1 + 0.5,
  0.5, 1 + 1, 1, 1, 1, 1, 1, 0.5, 0.5, 1, 1, 1, 0.5,
  0.5, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0.5,
  0.5, 1, 1, 1, 1, 1 + 0.5, 0.5, 1 + 1
};


void birthday() {  //Fonction qui définit la musique d'anniversaire
  tone(3, 294);    //Le buzzer va émettre un signal sonore de 294 hertz
  delay(250);      //Ajoute un délai
  tone(3, 440);    //Le buzzer va émettre un signal sonore de 440 hertz
  delay(250);      //Ajoute un délai
  tone(3, 392);    //Le buzzer va émettre un signal sonore de 392 hertz
  delay(250);      //Ajoute un délai
  tone(3, 532);    //Le buzzer va émettre un signal sonore de 532 hertz
  delay(250);      //Ajoute un délai
  tone(3, 494);    //Le buzzer va émettre un signal sonore de 494 hertz
  delay(500);      //Ajoute un délai
  tone(3, 392);    //Le buzzer va émettre un signal sonore de 392 hertz
  delay(250);      //Ajoute un délai
  tone(3, 440);    //Le buzzer va émettre un signal sonore de 440 hertz
  delay(250);      //Ajoute un délai
  tone(3, 392);    //Le buzzer va émettre un signal sonore de 392 hertz
  delay(250);      //Ajoute un délai
  tone(3, 587);    //Le buzzer va émettre un signal sonore de 587 hertz
  delay(250);      //Ajoute un délai
  tone(3, 532);    //Le buzzer va émettre un signal sonore de 532 hertz
  delay(500);      //Ajoute un délai
  tone(3, 392);    //Le buzzer va émettre un signal sonore de 392 hertz
  delay(250);      //Ajoute un délai
  tone(3, 784);    //Le buzzer va émettre un signal sonore de 784 hertz
  delay(250);      //Ajoute un délai
  tone(3, 659);    //Le buzzer va émettre un signal sonore de 659 hertz
  delay(250);      //Ajoute un délai
  tone(3, 532);    //Le buzzer va émettre un signal sonore de 532 hertz
  delay(250);      //Ajoute un délai
  tone(3, 494);    //Le buzzer va émettre un signal sonore de 494 hertz
  delay(250);      //Ajoute un délai
  tone(3, 440);    //Le buzzer va émettre un signal sonore de 440 hertz
  delay(250);      //Ajoute un délai
  tone(3, 698);    //Le buzzer va émettre un signal sonore de 698 hertz
  delay(375);      //Ajoute un délai
  tone(3, 659);    //Le buzzer va émettre un signal sonore de 659 hertz
  delay(250);      //Ajoute un délai
  tone(3, 532);    //Le buzzer va émettre un signal sonore de 532 hertz
  delay(250);      //Ajoute un délai
  tone(3, 587);    //Le buzzer va émettre un signal sonore de 587 hertz
  delay(250);      //Ajoute un délai
  tone(3, 532);    //Le buzzer va émettre un signal sonore de 532 hertz
  delay(500);      //Ajoute un délai
}

void Ode_to_Joy()  //Fonction qui va jouer la symphonie n° 9 de Beethoven
{
  for (int x = 0; x < longueurDeLaMusique; x++) {  //Boucle qui va itérer selon la longueur de la musique
    tone(buzzerPin, tune[x]);                      //Attribut le signal du buzzer à la PIN numéro 3
    delay(300 * durt[x]);                          //Ajoute un délais
  }
}

void music1() {  //Fonction qui va jouer une musique précise
  birthday();    //Appelle une fonction externe
}

void music2() {  //Fonction qui va jouer une musique précise
  Ode_to_Joy();  //Appelle un fonction interne du fichier
}

void Son() {             //Une fonction qui va simplement permettre d'entendre un "bip"
  tone(buzzerPin, 150);  //Envoie un signal sonore de 500 hertz
  delay(1000);           //Ajoute un délais
  noTone(buzzerPin);     //Arrête le bruit
  delay(250);            //Ajoute un délais
}