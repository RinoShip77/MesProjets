<?php
include('biblio.php');

header('Content-type: application/json');
header('Access-Control-Allow-Origin: *');

if (isset($_POST['idDev'])) {
  $idDev = $_POST['idDev'];
} else {
  die(json_encode("Erreur l'id du dév est indéfini"));
}

if (isset($_POST['contenu'])) {
  $contenu = $_POST['contenu'];
} else {
  die(json_encode("Erreur le contenu est indéfini"));
}

if (isset($_POST['idSession'])) {
  $idSession = $_POST['idSession'];
} else {
  die(json_encode("Erreur l'id de session de travail est indefini"));
}

try {
  $maBD = new BDService;

  $d = date('Y-m-d H:i:s');

  $ins = "insert into commentaires value(null,  '$contenu', '$d', $idSession, $idDev)";
  $idComm = $maBD->insertion($ins);

  echo json_encode("$idComm");
} catch (Exception $e) {
  echo  $e->getMessage();
}
