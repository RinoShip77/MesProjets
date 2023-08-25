<?php
include('biblio.php');

header('Content-type: application/json');
header('Access-Control-Allow-Origin: *');

try {
  $maBD = new BDService;

  $sel = "select * from developpeurs";
  $tabDevs = $maBD->selection($sel);

  echo json_encode($tabDevs);
} catch (Exception $e) {
  echo  $e->getMessage();
}
