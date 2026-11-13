<?php
include("BDService.php");

define("SERVEUR", "localhost");
define("UTILISATEUR", "root");
define("MOTDEPASSE", "");
define("BD", "jv_synthese");

ini_set('date.timezone', 'America/New_York');

// define("SERVEUR", "techinfo-cstj.ca");
// define("UTILISATEUR", "e1875009");
// define("MOTDEPASSE", "AdaC57X5k");
// define("BD", "e1875009_jv_synthese_A22");

function retour()
{
   echo "<hr><a href='/3D4-2'>retour</a>";
}

function enteteHTML()
{
   echo "
     <!DOCTYPE html>
        <html lang='fr'>
         <head>
    <meta charset='utf-8'>
    <meta name='viewport' content='width=device-width, initial-scale=1'>
    <title>Modèle HTML</title>
    <!-- CSS et JS de Bootstrap compilés et minifiés  -->
    <link href='https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/css/bootstrap.min.css' 
    rel='stylesheet' integrity='sha384-0evHe/X+R7YkIZDRvuzKMRqM+OrBnVFBL6DOitfPri4tjfHxaWutUpFmBp4vmVor' crossorigin='anonymous'>
    <script src='https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/js/bootstrap.bundle.min.js' integrity='sha384-pprn3073KE6tl6bjs2QrFaJGz5/SUsLqktiwsUTF55Jfv3qYSDhgCecCxMW52nD2' crossorigin='anonymous'></script>

    <!-- JQuery -->
    <script src='https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js'></script>

    <!-- CSS et JS maison -->
    <link href='maison.css' rel='stylesheet'>
    <script src='maison.js'></script>
  </head>
     ";
}

function corpsHTML()
{
   echo "
      <body>";
}

function piedHTML()
{
   echo "
      </body>
      </html>";
}
