//--------------------------------
//
//--------------------------------
export class Joueur {
  id = 0;
  nom: string = '';
  motDePasse: string = '';
  courriel = '';
  jwt = '';
}

//--------------------------------
//
//--------------------------------
export class JoueurCandidat extends Joueur {
  choisi = false;
}