<?php

include('BDService.php');
header('Content-Type: application/json');
header('Access-Control-Allow-Origin: http://localhost:4200');

ini_set('date.timezone', 'America/New_York');

$maBD = new BDService;
$sessId = $_GET['sessId'];

$d = Date('Y-m-d H:i:s');
$maj = "update sessionstravail set fin='$d' where Id= $sessId";
$res = $maBD->miseAJour($maj);

if ($res)
	echo json_encode($res);
else
	echo json_encode(-1); 

?>