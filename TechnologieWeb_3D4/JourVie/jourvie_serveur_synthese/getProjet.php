<?php
include('biblio.php');

header('Content-type: application/json');
header('Access-Control-Allow-Origin: *');

if (isset($_GET['idProj'])) {
  $idProj = $_GET['idProj'];
} else {
  die("Erreur le id de projet est inexistant");
}

try {
  $maBD = new BDService;

  $sel = "select * from projets where Id = $idProj";
  $tabProjet = $maBD->selection($sel);

  if (count($tabProjet) == 0) {
    echo json_encode("Erreur aucun projet pour l'id $idProj ($sel)");
  } else {
    echo json_encode($tabProjet[0]);
  }
} catch (Exception $e) {
  echo  $e->getMessage();
}
