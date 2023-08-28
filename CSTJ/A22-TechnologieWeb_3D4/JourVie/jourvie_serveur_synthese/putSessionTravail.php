<?php
include('biblio.php');

header('Content-type: application/json');
header('Access-Control-Allow-Origin: *');

if (isset($_GET['id'])) {
  $id = $_GET['id'];
} else {
  die("Erreur id de session de travail corrompu");
}

try {
  $maBD = new BDService;

  $d = date('Y-m-d H:i:s');

  $upd = "update sessionstravail set Fin = '$d' where Id = $id";
  $ndRowsUpd = $maBD->maj($upd);

  if ($ndRowsUpd == 0  || $ndRowsUpd > 1) {
    echo json_encode("Erreur corruption de la table des sessions de travail ($upd)");
  } else {
    $sel = "select Id, IdTache, TacheNumero, IdDev, Debut, Fin from sessionstravail where Id = $id";
    $tabSessTrav = $maBD->selection($sel);
    
    echo json_encode($tabSessTrav[0]);
  }
} catch (Exception $e) {
  echo  $e->getMessage();
}
