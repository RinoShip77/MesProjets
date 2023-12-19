import { Component, EventEmitter, Output } from '@angular/core';
import { Joueur } from '../modele/joueur';
import { urlServeur, tr, MAX_FICHIER_VOLUME, getURLAvatar } from '../utile';
import { Poker420Service } from '../poker420.service';

@Component({
  selector: 'app-parametre',
  templateUrl: './parametre.component.html',
  styleUrls: ['./parametre.component.css'],
})
export class ParametreComponent {
  visible = false;
  joueurConnecte: Joueur = new Joueur();
  svrURL = urlServeur;
  fichierATeleverser: any;
  formData = new FormData();
  file: any;
  file_data: any = '';
  televersementValide: boolean = false;

  @Output() quitterParametre = new EventEmitter<Joueur>();

  //--------------------------------
  //
  //--------------------------------
  constructor(private pk420Srv: Poker420Service) { }

  //--------------------------------
  //
  //--------------------------------
  onOuvrir(j: Joueur) {
    this.televersementValide = false;
    this.visible = true;
    this.joueurConnecte = j;
  }

  //--------------------------------
  //
  //--------------------------------
  accueil(j: Joueur) {
    this.televersementValide = false;
    this.visible = true;
    this.joueurConnecte = j;
  }

  //------------------------------------
  //
  //------------------------------------
  getAvatar() {
    return getURLAvatar(this.joueurConnecte.id);
  }

  //------------------------------------
  //
  //------------------------------------
  executerTeleversement() {
    //tr("On procède au téléversement!");
    if (this.fichierATeleverser) {
      this.pk420Srv.televerseFichier(this.file_data).subscribe((res) => {
        tr('Téléversement terminé:' + res);
        this.televersementValide = false;
      });
    } else {
      tr('ERREUR: Le fichier à téléverser est vide');
    }
  }

  //------------------------------------
  //
  //------------------------------------
  fileChange(event: any) {
    const fileList: FileList = event.target.files;

    if (fileList.length > 0) {
      this.fichierATeleverser = fileList[0];
      tr(this.fichierATeleverser.name + ' dim:' + this.fichierATeleverser.size + ' type:' + this.fichierATeleverser.type);

      if (this.validerFichier()) {
        let formData = new FormData();
        formData.append('file', this.fichierATeleverser, this.fichierATeleverser.name);
        formData.append('joueurId', '' + this.joueurConnecte.id);
        formData.append('extension', '' + this.extraitExtension(this.fichierATeleverser.name));
        formData.append('acces', this.joueurConnecte.jwt);

        this.file_data = formData;
        this.televersementValide = true;
      }
    }
  }

  //------------------------------------
  //
  //------------------------------------
  annulerTeleverse() {
    //On doit retourner à l'accueil
    this.visible = false;
    this.quitterParametre.emit(this.joueurConnecte);
  }

  //------------------------------------
  //
  //------------------------------------
  validerFichier() {
    let ret = false;

    if (this.fichierATeleverser.size <= MAX_FICHIER_VOLUME) {
      let extension = this.extraitExtension(this.fichierATeleverser.name);

      if (extension?.toLowerCase() == 'png') {
        ret = true;
      }

      if (!ret) {
        tr('Erreur: extension de fichier non supportée', true);
      }
    } else {
      ret = false;
      tr('Erreur: Fichier trop volumineux. Maximum 500 kB et le fichier a ' + (this.fichierATeleverser.size / 1024).toFixed(0) + ' kB', true, true);
    }

    return ret;
  }

  //------------------------------------
  //
  //------------------------------------
  extraitExtension(nomFichier: string) {
    let extension = nomFichier.split('.').pop();
    tr("l'extension du fichier est " + extension);
    
    return extension;
  }
}
