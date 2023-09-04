<?php
include('biblio.php');

header('Content-type: application/json');
header('Access-Control-Allow-Origin: *');

if (isset($_GET['idProj'])) {
  $idProj = $_GET['idProj'];
} else {
  die("Erreur le projet est indéfini");
}

try {
  $maBD = new BDService;

  $sel = "select Id, IdProjet, Numero, Titre, Description from taches where IdProjet = $idProj";
  $tabTaches = $maBD->selection($sel);

  if (count($tabTaches) == 0) {
    echo json_encode("Erreur aucune tâche pour projet $IdProj ($sel)");
  } else {
    // On a trouvé les tâche du projet
    echo json_encode($tabTaches);
  }
} catch (Exception $e) {
  echo  $e->getMessage();
}
