// clignotement_ajustable_avec_potentiomètre
// Clignotement ajustable de la LED externe à l'aide d'un bouton pressoir et d'un potentiomètre
// 2020-09-19 OB Version finale V0.1
// Début du code
// Définition des variables constante
const int LEDPIN = 2; // La LED externe est branché sur le port D2 du bouclier GROVE
const int boutonPIN = 3; // Le bouton pressoir est branché sur le port D3 du bouclier GROVE
const int potPIN = A0; // Le potentiomètre est branché sur le port A0 du bouclier GROVE
//Définition des variables non constante
int boutonEnfonce = 0; // La valeur initiale de boutonEnfonce est 0 pour l'instant
int valeurDelay = 0; // La valeur initiale de valeurDelay est 0 pour l'instant
// Initialisation des PIN
void setup() // Section éxécuté au branchement
{ // Début de la fonction setup()
  pinMode(LEDPIN, OUTPUT); // Led externe
  pinMode(boutonPIN, INPUT); // Bouton
  pinMode(potPIN, INPUT); // Potentiomètre
  Serial.begin(9600); // Initialisation du port série à une certaine vitesse
} // Fin de la fonction setup()
// Programme
void loop() // Éxécutée pour toujours
{ // Début de la fonction loop()
  boutonEnfonce = digitalRead(boutonPIN); // Donne la valeur 1(enfoncé) ou 0(pas enfoncé) à boutonEnfonce
  valeurDelay = analogRead(potPIN) / 10; // Attribut la valeur du potentiomètre divisé par dix à valeurDelay
  if (valeurDelay < 20) // Si valeurDelay est inférieur à vingt, ...
  { // Début du bloc de condition
    valeurDelay = 20; // La viable valeurDelay se voit attribuer la valeur de vingt
  } // Fin du bloc de condition
  Serial.println(valeurDelay); // La veluer de valeurDelay s'affiche sur le console
  // Deuxième bloc de condition
  if (boutonEnfonce == 1) // Si boutonEnfoncé est égale à un, ...
  { // Début du bloc de condition
    delay(valeurDelay); // Ajoute un délai de la valeur de valeurDelay
    digitalWrite(LEDPIN, HIGH); // Alume la LED
    delay(valeurDelay); // Ajoute un délai de la valeur de valeurDelay
    digitalWrite(LEDPIN, LOW); // Éteint la LED
  } // Fin du bloc de condition
  else // Sinon, ...
  { // Début du bloc
    digitalWrite(LEDPIN, LOW); // Éteint la LED
  } // Fin du bloc
} // Fin de la fonction loop()
