
//------------------------------------------
//   fichier : retroaction.component.html
//   Dev : Olivier Bourgault
//   Date: 2021-11-21
//   Projet: JourVie
//------------------------------------------

import { Component, OnInit } from '@angular/core';
import { InfoService } from '../info.service';

@Component({
  selector: 'app-retroaction',
  templateUrl: './retroaction.component.html',
  styleUrls: ['./retroaction.component.css']
})
export class RetroactionComponent implements OnInit {

  constructor(public infoSrv: InfoService) { }

  ngOnInit(): void {
  }

}
