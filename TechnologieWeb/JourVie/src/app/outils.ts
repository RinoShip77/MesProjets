//------------------------------------------
//   fichier : outils.ts
//   Dev : Olivier Bourgault
//   Date: 2021-11-21
//   Projet: JourVie
//------------------------------------------

export function tr(msg: string, cons: boolean = false, alerte: boolean = false) {
   if (cons)
      console.log(msg);

   if (alerte)
      alert(msg);
}

//----------------------------------
//
//----------------------------------

export function fusoMTL() {
   let londres = new Date().getTime();
   return londres - (4 * 60 * 60 * 1000);
}

//----------------------------------
//
//----------------------------------

export const serveurURL = 'http://localhost/1875009/Synthese/synthese_serveur/';