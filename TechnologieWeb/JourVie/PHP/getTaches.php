<?php
include('BDService.php');

header('Content-type:application/json');
header('Access-Control-Allow-Origin:*');

$maBD = new BDService();

$pId = $_GET['projetID'];
$reqSql = "select * from taches where ProjetAssigne_Id = $pId";

$tabTaches = $maBD->Selection($reqSql);

//var_dump($tabDev);

if (isset($tabTaches[0]))
{
   echo json_encode($tabTaches);
}
else
   echo json_encode("Erreur");

