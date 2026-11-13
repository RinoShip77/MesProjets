<?php

namespace App\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\Routing\Annotation\Route;

use Doctrine\Persistence\ManagerRegistry;

use App\Entity\Joueur;
use App\Entity\JoueurPartie;
use App\Entity\Partie;

use App\Util;

ini_set('date.timezone', 'America/New_York');

header('Access-Control-Allow-Origin: *');

class PartiesController extends AbstractController
{
    //------------------------------------------------------
    //
    //------------------------------------------------------
    #[Route('/creationPartie')]
    public function creationPartie(Request $req, ManagerRegistry $doctrine): JsonResponse
    {
        //Initialisation pour le POST
        $jwt = $req->request->get('jwt');
        Util::logmsg("in création partie, JWT= $jwt");

        if (Util::JWTokenEstValide($jwt)) {
            Util::logmsg("le jwt est valide");
            //Initialisation pour le POST
            $tabJ[] = $req->request->get('idJ0');
            $tabJ[] = $req->request->get('idJ1');
            $tabJ[] = $req->request->get('idJ2');
            $tabJ[] = $req->request->get('idJ3');
            $tabJ[] = $req->request->get('idJ4');
            $tabJ[] = $req->request->get('idJ5');
            $tabJ[] = $req->request->get('idJ6');
            $tabJ[] = $req->request->get('idJ7');
            $tabJ[] = $req->request->get('idJ8');
            $tabJ[] = $req->request->get('idJ9');
            $debut = new \DateTime();

            if ($req->getMethod() == 'POST') {
                Util::logmsg("c'est un post");
                $em = $doctrine->getManager();

                $p = new Partie();
                $p->setDebut($debut);
                $p->setFin(null);
                $p->setIdGagnant(null);

                $repoJoueurs = $em->getRepository(Joueur::class);
                $nbJoueurs = 0;

                for ($i = 0; $i < 10; $i++) {
                    Util::logmsg("on est à l'itération $i");
                    if (!empty($tabJ[$i])) {
                        $joueurAInserer = $repoJoueurs->find($tabJ[$i]);

                        $jp = new JoueurPartie();
                        $jp->setJoueur($joueurAInserer);
                        $jp->setPosition($i);
                        $jp->setCapital(100);
                        $jp->setEngagement(0);

                        $em->persist($jp);
                        $p->addJoueur($jp);
                        $nbJoueurs++;
                    }
                }
                $em->persist($p);
                $em->flush();

                $partieInfo = $this->PreparerReponse($p);

                return $this->json($partieInfo);
            } else {
                Util::logmsg("Erreur de jwt");

                return $this->json('Erreur 66');
            }
        } else {
            return $this->json('Erreur de piratage');
        }
    }

    //------------------------------------------------------
    //
    //------------------------------------------------------
    function PreparerReponse($partie)
    {
        $tabInfo = array();
        $tabInfo['id'] = $partie->getId();
        $tabInfo['debut'] = $partie->getDebut();
        $tabInfo['joueurs'] = array();
        $tabJoueurs = $partie->getJoueurs();

        //Util::tr('Partie ' . $tabInfo['id'] . "\nPre boucle\nNb joueurs: " . count($tabJoueurs));
        for ($i = 0; $i < count($tabJoueurs); $i++) {
            $unJoueur['id'] = $tabJoueurs[$i]->getJoueur()->getId();
            $unJoueur['nom'] = $tabJoueurs[$i]->getJoueur()->getNom();
            $unJoueur['position'] = $tabJoueurs[$i]->getPosition();
            $unJoueur['capital'] = $tabJoueurs[$i]->getCapital();
            $unJoueur['engagement'] = $tabJoueurs[$i]->getEngagement();

            //Util::tr("iteration: $i");
            $tabInfo['joueurs'][$i] = $unJoueur;
        }
        return $tabInfo;
    }

    //-----------------------------------
    //
    //-----------------------------------
    #[Route('/getPartiesDUnJoueur')]
    public function getPartiesDUnJoueur(Request $req, ManagerRegistry $doctrine): JsonResponse
    {
        /* initialisation par le $_POST */
        $joueurID = $req->request->get('idJ');
        //Util::tr("Id du joueur connecté: $joueurID");

        $repoJoueurs = $doctrine->getManager()->getRepository(Joueur::class);
        $joueur = $repoJoueurs->find($joueurID);
        $tabParties = $joueur->getParties();
        $reponse = array();

        for ($i = 0; $i < count($tabParties); $i++) {
            $id = $tabParties[$i]->getPartie()->getId();
            $reponse[] = $id * 1;
        }

        return $this->json($reponse);
    }

    //-----------------------------------
    //
    //-----------------------------------
    #[Route('/getInfoPartieEnCours')]
    public function getInfoPartieEnCours(Request $req, ManagerRegistry $doctrine): JsonResponse
    {
        $idPartie = $req->request->get('idPartie');
        //Util::tr("Id de la partie $idPartie");
        $joueurID = $req->request->get('idJConnecte');
        $repoParties = $doctrine->getManager()->getRepository(Partie::class);
        $partie = $repoParties->find($idPartie);
        //Util::tr("après le find: " . $partie->getId());

        $reponse = $this->PreparerReponse($partie, $joueurID);
        //Util::tr($reponse);

        return $this->json($reponse);
    }
}
