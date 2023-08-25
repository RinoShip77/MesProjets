<?php
include('biblio.php');

header('Content-type: application/json');
header('Access-Control-Allow-Origin: *');

if (isset($_GET['idSess'])) {
  $idSess = $_GET['idSess'];
} else {
  die(json_encode("Erreur la session est indéfini"));
}

try {
  $maBD = new BDService;

  $sel = "select * from commentaires where IdSession = $idSess";
  $NbComms = $maBD->selection($sel);

  echo json_encode($NbComms);
} catch (Exception $e) {
  echo json_encode($e->getMessage());
}
