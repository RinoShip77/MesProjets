<?php

include('BDService.php');
header('Content-Type: application/json');
header('Access-Control-Allow-Origin: http://localhost:4200');

ini_set('date.timezone', 'America/New_York');

$maBD = new BDService;
$tacId = $_GET['tacId'];
$tacNum = $_GET['tacNum'];
$devId = $_GET['devId'];

$d = Date('Y-m-d H:i:s');
$ins = "insert into sessionstravail values(null, $tacId, '$tacNum', '$d', null, $devId)";
$res = $maBD->insertion($ins);

if ($res)
	echo $res;
else
	echo -1; 



?>