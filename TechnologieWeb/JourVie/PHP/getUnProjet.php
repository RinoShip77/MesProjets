<?php

include('BDService.php');
header('Content-Type: application/json');
header('Access-Control-Allow-Origin: http://localhost:4200');

$maBD = new BDService;
$projetId = $_GET['projetId'];

$sel = "SELECT * FROM projets where Id = $projetId";
$projet = $maBD->selection($sel);

if(isset($projet[0]))
{
    echo json_encode($projet);
}
else
    echo json_encode("erreur aucun projet pour ce developpeur");
?>