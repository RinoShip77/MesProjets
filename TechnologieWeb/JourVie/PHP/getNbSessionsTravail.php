<?php

include('BDService.php');
header('Content-Type: application/json');
header('Access-Control-Allow-Origin: http://localhost:4200');

$maBD = new BDService;
$devId = $_GET['devId'];

$sel = "SELECT * FROM sessionstravail WHERE DevId = $devId";
$nbSessionTravail = $maBD->selection($sel);

if(isset($nbSessionTravail[0]))
{
    echo json_encode($nbSessionTravail);
}
else
    echo json_encode("erreur aucune session de travail pour ce développeur");
?>