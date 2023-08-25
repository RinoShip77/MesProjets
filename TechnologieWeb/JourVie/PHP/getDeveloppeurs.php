<?php

include('BDService.php');
header('Content-Type: application/json');
header('Access-Control-Allow-Origin: http://localhost:4200');

$maBD = new BDService;

$sel = "SELECT * FROM developpeurs";
$developpeurs = $maBD->selection($sel);

if(isset($developpeurs[0]))
{
    echo json_encode($developpeurs);
}
else
    echo json_encode("Erreur");
?>