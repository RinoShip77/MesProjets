<?php
include('biblio.php');

header('Content-type: application/json');
header('Access-Control-Allow-Origin: *');

if (isset($_GET['idSessTrav'])) {
  $idSessTrav = $_GET['idSessTrav'];
} else {
  die("Erreur id de session de travail corrompu");
}

try {
  $maBD = new BDService;

  $sel = "select Id, IdTache, TacheNumero, IdDev, Debut, Fin from sessionstravail where Id = $idSessTrav";
  $tabSessTrav = $maBD->selection($sel);

  if (count($tabSessTrav) == 0) {
    echo json_encode("Erreur aucune session de travail pour l'id $tabSessTrav ($sel)");
  } else {
    echo json_encode($tabSessTrav[0]);
  }
} catch (Exception $e) {
  echo  $e->getMessage();
}
