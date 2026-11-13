<?php
include('biblio.php');

header('Content-type: application/json');
header('Access-Control-Allow-Origin: *');

if (isset($_GET['idDev'])) {
  $idDev = $_GET['idDev'];
} else {
  die(json_encode("Erreur le dév est indéfini"));
}

try {
  $maBD = new BDService;

  $sel = "select * from commentaires where IdDev = $idDev";
  $tabComms = $maBD->selection($sel);

  echo json_encode($tabComms);
} catch (Exception $e) {
  echo json_encode($e->getMessage());
}
