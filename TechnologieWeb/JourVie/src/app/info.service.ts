//------------------------------------------
//   fichier : info.service.ts
//   Dev : Olivier Bourgault
//   Date: 2021-11-21
//   Projet: JourVie
//------------------------------------------
import { Injectable } from '@angular/core';

@Injectable({
  providedIn: 'root'
})
export class InfoService {
  messages: string[] = [];

  //----------------------------------
  //
  //----------------------------------

  constructor() { }

  //----------------------------------
  //
  //----------------------------------

  ajouter(msg: string) {
    this.messages.push(msg);
  }

  //----------------------------------
  //
  //----------------------------------

  vider() {
    this.messages = [];
  }
}
