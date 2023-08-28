<?php
include('biblio.php');

header('Content-type: application/json');
header('Access-Control-Allow-Origin: *');

if (isset($_GET['mat'])) {
  $mat = $_GET['mat'];
} else {
  die("Erreur le matricule est indéfini");
}

if (isset($_GET['mdp'])) {
  $mdp = $_GET['mdp'];
} else {
  die("Erreur le mot de passe est indéfini");
}

try {
  $maBD = new BDService;

  $sel = "select Id, Matricule, Prenom, Nom, IdProjet from developpeurs where Matricule='$mat' and MotDePasse='$mdp'";
  $tabDevs = $maBD->selection($sel);

  if (count($tabDevs) != 1) {
    echo json_encode('Erreur le developpeur existe pas');
  } else {
    // On a trouvé un développeur qui correspond
    $sel = "select nom from projets where Id = " . $tabDevs[0]['IdProjet'];
    $tabNomsProj = $maBD->selection($sel);

    $tabDevs[0]['NomProjet'] =  $tabNomsProj[0]['nom'];

    $sel = "select * from sessionstravail where IdDev = " . $tabDevs[0]['Id'] . " and " . " Fin is null";
    $tabSessTrav = $maBD->selection($sel);

    if (empty($tabSessTrav[0])) {
      $tabDevs[0]['Etat'] = 'inactif';
    } else {
      $tabDevs[0]['Etat'] = 'actif';
    }

    echo json_encode($tabDevs[0]);
  }
} catch (Exception $e) {
  echo  $e->getMessage();
}
