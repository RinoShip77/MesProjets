//----------------------------------------
//  Fichier : saisie.component.ts
//  Développeur: Olivier Bourgault
//  Date: 2022-10-06
//-----------------------------------------

import { Component, EventEmitter, OnInit, Output } from '@angular/core';

@Component({
  selector: 'app-saisie',
  templateUrl: './saisie.component.html',
  styleUrls: ['./saisie.component.css']
})
export class SaisieComponent implements OnInit {
  //VARIABLES
  @Output() citationValide: EventEmitter<string> = new EventEmitter<string>(); //Déclare un lanceur d'élément pour communiquer entre les modules
  visible: boolean = true;//Indique la visibilité des grilles
  citation: string = "Le chat est parvenu a attraper la souris avec ses pattes."; //Elle va contenir la phrase par défaut

  //--------------------------------------------
  //Constructeur du module
  //--------------------------------------------
  constructor() { }
  
  //--------------------------------------------
  //Fonction pour le démarrage du module
  //--------------------------------------------
  ngOnInit(): void {
  }

  //--------------------------------------------
  //Fonction qui va vérifier si la phrase de l'utilisateur est valide et va ensuite l'envoyer à l'extérieur du fichier
  //--------------------------------------------
  validerCitation() {
    if (this.estValide(this.citation)) { //Si la saisie répond aux critères, ...
      this.visible = false; //Rend le module visible par l'utilisateur
      alert("Votre citation est valide."); //Avise l'utilisateur
      this.citationValide.emit(this.citation); //On envoi la citation à l'externe pour la traiter
    }
  }

  //--------------------------------------------
  //Fonction qui va tester chaque critères pour savoir si la chaîne de carctères est valide
  //--------------------------------------------
  estValide(citation: string) { //Pour savoir si la citation est valide, ...
    if (citation.length < 35) { //On vérifie la si la citation fait moins de 35 caractères
      alert("La citation n'est pas assez longue.\nElle doit avoir au minimum trente-cinq caractères.\nIl manque " + (35 - citation.length) + " caractères pour la valider."); //Donne une rétroaction à l'utilisateur sur la cause de l'erreur
      return false; //On retourne faux
    }

    if (citation.length > 100) { //On vérifie la si la citation fait plus de 100 caractères
      alert("La citation est trop longue.\nElle doit avoir au maximum cent caractères.\nCette saisie à " + (citation.length - 100) + " caractères de trop."); //Donne une rétroaction à l'utilisateur sur la cause de l'erreur
      return false; //On retourne faux
    }

    for (var i = 0; i < citation.length; i++) {
      if (citation.charCodeAt(i) > 128) { //S'assure que chaque caractère n'est pas un caractère accentué ou diacritique
        alert("Les caractères spéciaux ne sont pas autorisés.\nChaque caractère doit avoir un code d'encodage\ninférieur à cent vingt-huit.\nVous devez revoir le caractère « " +  citation[i] + " » pour continuer."); //Donne une rétroaction à l'utilisateur sur la cause de l'erreur
        return false; //On retourne faux
      }
    }
    return true; //Si la citation est conforme, on retourne vrai
  }
}