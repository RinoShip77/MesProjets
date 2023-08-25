//----------------------------------------
//  Fichier: outils.ts
//  Développeur: Olivier Bourgault
//  Date: 2022-12-14
//  Projet: Jourvie
//-----------------------------------------

// Variables pour accéder aux fichiers PHP
export const SERVEUR_URL = 'http://localhost/1875009/PHP/jourvie_serveur_synthese/'; // Sur mon poste
//export const SERVEUR_URL = 'https://1875009.techinfo-cstj.ca/A22_Technologie_Web/PHP/jourvie_serveur_synthese/'; // Sur le serveur du cégep

//-------------------------------------------
// Fonction pour afficher un message sur l'écrean ou dans la console
//-------------------------------------------
export function tr(msg: string, dlg = 1, cons = 1) {
  if (dlg == 1) {
    alert(msg);
  }
  if (cons == 1) {
    console.log(msg);
  }
}