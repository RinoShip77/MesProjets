<?php

include('BDService.php');
header('Content-Type: application/json');
header('Access-Control-Allow-Origin: http://localhost:4200');

$maBD = new BDService;
$sessId = $_GET['sessId'];

$sel = "SELECT * FROM commentaires where Session_Id = $sessId";
$comms = $maBD->selection($sel);

if(isset($comms[0]))
{
    echo json_encode($comms);
}
else
    echo json_encode("erreur 18");


?>