<?php

include('BDService.php');
header('Content-Type: application/json');
header('Access-Control-Allow-Origin: http://localhost:4200');

ini_set('date.timezone', 'America/New_York');

$maBD = new BDService;
$sessId = $_GET['sessId'];
$devId = $_GET['devId'];
$contenu = $_GET['contenu'];
$contenuClean = $maBD->neutralise($contenu);

$d = Date('Y-m-d H:i:s');
$ins = "insert into commentaires values(null, '$contenuClean', '$d', $sessId, $devId)";
$res = $maBD->insertion($ins);

if ($res)
	echo json_encode($res);
else
	echo json_encode("erreur insertion commentaire"); 



?>