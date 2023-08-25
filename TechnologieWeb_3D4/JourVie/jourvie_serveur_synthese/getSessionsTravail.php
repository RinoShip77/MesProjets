<?php
include('biblio.php');

header('Content-type: application/json');
header('Access-Control-Allow-Origin: *');

if (isset($_GET['idDev'])) {
  $idDev = $_GET['idDev'];
} else {
  die("Erreur id dev corrompu");
}

try {
  $maBD = new BDService;

  $sel = "select Id, IdTache, TacheNumero, IdDev, Debut, Fin from sessionstravail where IdDev = $idDev";
  $tabSessTrav = $maBD->selection($sel);

  echo json_encode($tabSessTrav);
} catch (Exception $e) {
  echo  $e->getMessage();
}
