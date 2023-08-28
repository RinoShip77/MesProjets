<?php

class BDService
{
    private $BDInterne;

    //-----------------------------------------
    //
    //-----------------------------------------
    public function __construct()
    {
        $this->BDInterne = new MYSQLI(SERVEUR, UTILISATEUR, MOTDEPASSE, BD);
        if (mysqli_connect_errno()) {
            throw new Exception("Erreur (" . mysqli_connect_error() . ") inmpossible de se connecter");
        }
        $this->BDInterne->set_charset('UTF8');
    }

    //-----------------------------------------
    //
    //-----------------------------------------
    public function selection($sel)
    {
        $tabEnregistrements = [];
        $requete = $this->BDInterne->query($sel);
        if (!$requete) {
            throw new Exception("Erreur (" . $this->BDInterne->error . ") erreur ds le select --$sel--");
        }
        $enregCourant = $requete->fetch_array(MYSQLI_ASSOC);
        while ($enregCourant) {
            $tabEnregistrements[] = $enregCourant;
            $enregCourant = $requete->fetch_array(MYSQLI_ASSOC);
        }
        return $tabEnregistrements;
    }

    //-----------------------------------------
    //
    //-----------------------------------------
    public function insertion($ins)
    {
        $resultat = $this->BDInterne->query($ins);
        if (!$resultat) {
            throw new Exception("Erreur (" . $this->BDInterne->error . ") erreur ds le insert --$ins--");
        }
        return $this->BDInterne->insert_id;
    }

    //-----------------------------------------
    //
    //-----------------------------------------
    public function maj($maj)
    {
        $resultat = $this->BDInterne->query($maj);
        if (!$resultat) {
            throw new Exception("Erreur (" . $this->BDInterne->error . ") erreur ds le update  --$maj--");
        }
        return $this->BDInterne->affected_rows;
    }
}
