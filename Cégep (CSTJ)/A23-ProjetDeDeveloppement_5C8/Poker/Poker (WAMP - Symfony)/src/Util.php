<?php

namespace App;

use Jose\Component\Core\AlgorithmManager;
use Jose\Component\Signature\Algorithm\HS256;
use Jose\Component\Core\JWK;
use Jose\Component\Signature\JWSBuilder;
use Jose\Component\Signature\Serializer\CompactSerializer;
use Jose\Component\Signature\JWSVerifier;
use Jose\Component\Signature\Serializer\JWSSerializerManager;

class Util
{
  private static $cle = 'AMnJrfU6op3JZEXgdyOz8LlhxU3MN3fGDSFbfh6_nmxNFj01rRw4cM39GYd1NiSxX8f3uzwLe6c7F0bOs2PVkfh_BiQ1rTRLs_bnek23wasSBNTqVkKvDpNtjABIN7J0vPFDkydwHCW4xkATcAGEhnSRsVXpt2ZXLX7HwjE_FkU';

  //-----------------------------------
  //
  //-----------------------------------
  public static function genereJWToken($idJoueur)
  {
    $algorithmManager = new AlgorithmManager([
      new HS256()
    ]);

    //Notre clé
    $jwk = new JWK([
      'kty' => 'oct',
      'k' => self::$cle
    ]);

    // Instantiation du JWSignature Builder
    $jwsBuilder = new JWSBuilder($algorithmManager);

    $payload = json_encode([
      'id' => "$idJoueur",
      'exp' => time() + 3600
    ]);

    $jws = $jwsBuilder
      ->create()
      ->withPayLoad($payload)
      ->addSignature($jwk, ['alg' => 'HS256'])
      ->build();

    $serializer = new CompactSerializer(); // The serializer
    $msg = "Génération d'un JWT pour ($idJoueur) : " . json_encode($jws);

    //Util::logmsg($msg);
    return $serializer->serialize($jws, 0); // We serialize the signature at index 0.
  }

  //-----------------------------------
  //
  //-----------------------------------
  public static function   JWTokenEstValide($token)
  {
    if ($token == null) {
      return false;
    }

    $algorithmManager = new AlgorithmManager([
      new HS256(),
    ]);
    // On instantie le JWS Verifier.
    $jwsVerifier = new JWSVerifier($algorithmManager);

    //Notre clé
    $jwk = new JWK([
      'kty' => 'oct',
      'k' => self::$cle
    ]);

    // The serializer manager. We only use the JWS Compact Serialization Mode.
    $serializerManager = new JWSSerializerManager([
      new CompactSerializer(),
    ]);

    $jws = $serializerManager->unserialize($token);

    // We verify the signature. This method does NOT check the header.
    // Les params sont:
    // - L’objet JWS,
    // - La clé,
    // - L’indice de la signature à vérifier
    $estValide = $jwsVerifier->verifyWithKey($jws, $jwk, 0);

    return $estValide;
  }

  //-----------------------------------
  //
  //-----------------------------------
  public static function logmsg($msg = "", $traceUp = false, $ligne = true, $afficheDate = true)
  {
    //return;	
    if ($traceUp) {
      $journal = fopen("logbook.txt", "a");
      $d = "";

      if ($afficheDate) {
        $d = date('Y-m-d H:i:s');
      }

      if ($ligne) {
        fwrite($journal, "$d: $msg\n");
      } else {
        fwrite($journal, "$d: $msg");
      }

      fclose($journal);
    }
  }
}
