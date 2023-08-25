<?php
include('BDService.php');

header('Content-type:application/json');
header('Access-Control-Allow-Origin:*');

$maBD = new BDService();

$mat = $_GET['matricule'];
$reqSql = "select * from developpeurs where matricule = '$mat'";

$tabDev = $maBD->Selection($reqSql);

//var_dump($tabDev);

if (isset($tabDev[0]))
{
   $nomProjet = $maBD->selection("select Nom from projets where Id = " . $tabDev[0]['ProjetAssigne_Id']);
   $tabDev[0]['NomProjet'] = $nomProjet[0]['Nom'];
   
   $tabSessionActive = $maBD->selection("select * from sessionstravail where DevId=" . $tabDev[0]['Id'] . " and fin is null");
   
   if (isset($tabSessionActive[0]))
	  $tabDev[0]['Etat'] = 'actif';
   else
	  $tabDev[0]['Etat'] = 'inactif';
   
   echo json_encode($tabDev[0]);
}
else
   echo json_encode("Erreur");

