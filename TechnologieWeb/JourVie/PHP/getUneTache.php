<?php

include('BDService.php');
header('Content-Type: application/json');
header('Access-Control-Allow-Origin: http://localhost:4200');

$maBD = new BDService;
$sessId = $_GET['sessId'];

$sel = "SELECT TacheId FROM sessionstravail where Id = $sessId";
$tabTacheIds = $maBD->selection($sel);

if(isset($tabTacheIds[0]))
{
	$sel = "select * from taches where Id = " . $tabTacheIds[0]['TacheId'];
	$tabTaches = $maBD->selection($sel);
	if (isset($tabTaches[0]))
       echo json_encode($tabTaches[0]);
    else
	   echo json_encode("erreur aucune tâche pour session $sessId");	
		   
}
else
    echo json_encode("erreur aucune session avec le Id $sessId");


?>