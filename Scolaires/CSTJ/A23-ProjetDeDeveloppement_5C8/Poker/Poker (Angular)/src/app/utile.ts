export function tr(message: string, onScreen: boolean = false, onConsole: boolean = true) {
  if (onScreen) {
    alert(message);
  }

  if (onConsole) {
    console.log(message);
  }
}

//------------------------------------
//
//------------------------------------
export function getURLAvatar(joueurId: number) {
  // en ajoutant le param bidon du GET (random=) on force le refresh de l'image!
  //let urltmp = urlServeur + '../images/joueurs/' + joueurId + '.png' + '?random=' + Math.random();

  // en enlevant le param bidon du GET (random=) on enlève l'erreur de dév de la console du fureteur!
  let urltmp = urlServeur + '../images/joueurs/' + joueurId + ".png";
  return urltmp;
}

export const urlServeur = 'http://localhost/1875009/poker420-sf/public/index.php/';

export const MAX_FICHIER_VOLUME: number = 500 * 1048;