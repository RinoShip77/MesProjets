<?php

include('BDService.php');
header('Content-Type: application/json');
header('Access-Control-Allow-Origin: http://localhost:4200');

$maBD = new BDService;
$devId = $_GET['devId'];

$sel = "SELECT * FROM sessionstravail where DevId = $devId order by debut desc";
$sessionTravail = $maBD->selection($sel);

if(isset($sessionTravail[0]))
{
    echo json_encode($sessionTravail);
}
else
    echo json_encode("erreur aucune session de travail pour ce développeur");
?>