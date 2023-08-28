<?php
include('biblio.php');

//header('Content-type: application/json');
header('Access-Control-Allow-Origin: *');

if (isset($_POST['idTac'])) {
  $idTac = $_POST['idTac'];
} else {
  die(json_encode("Erreur l'id de tache de la session de travail est indefini"));
}

if (isset($_POST['tacNum'])) {
  $tacNum = $_POST['tacNum'];
} else {
  die(json_encode("Erreur le numéro de tâche de la session de travail est indéfini"));
}

if (isset($_POST['idDev'])) {
  $idDev = $_POST['idDev'];
} else {
  die(json_encode("Erreur l'id de  développeur de la session de travail est indéfini"));
}

try {
  $maBD = new BDService;

  $d = date('Y-m-d H:i:s');

  $ins = "insert into sessionstravail value(null, $idTac, '$tacNum', '$d' , null, $idDev )";
  $idSessTrav = $maBD->insertion($ins);

  echo json_encode("$idSessTrav");
} catch (Exception $e) {
  echo  $e->getMessage();
}
