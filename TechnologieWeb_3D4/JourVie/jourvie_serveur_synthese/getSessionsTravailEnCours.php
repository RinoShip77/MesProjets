<?php
include('biblio.php');

header('Content-type: application/json');
header('Access-Control-Allow-Origin: *');

try {
  $maBD = new BDService;

  $sel = "select * from sessionstravail where Fin is null";
  $tabSessTrav = $maBD->selection($sel);

  echo json_encode($tabSessTrav);
} catch (Exception $e) {
  echo  $e->getMessage();
}
