import { InfoJoueur } from './infoJoueur';
//--------------------------------
//
//--------------------------------
export class InfoPartie {
  id = 0;
  debut = '';
  joueurs: InfoJoueur[] = new Array();
  brasse = 0;
  bouton = 0;
  etape = 'PRE_FLOP';
  prochain = 2;
  fin = '';
  idGagnant = 0;
}