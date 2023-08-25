<?php

namespace App\Controller;

use App\Entity\Cart;
use App\Entity\Category;
use Doctrine\Persistence\ManagerRegistry;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\Security\Http\Authentication\AuthenticationUtils;

class PageController extends AbstractController
{
    private $em = null;
    private $categories;
    private $lastEmail;
    private $cartLength;

    public function __construct(ManagerRegistry $doctrine, AuthenticationUtils $authentificationUtils)
    {
        $this->em = $doctrine->getManager();
        $this->categories = $this->em->getRepository(Category::class)->findAll();
        $this->lastEmail = $authentificationUtils->getLastUsername();
    }

    private function initSession(Request $request)
    {
        $this->cartLength = $request->getSession()->get('purchaselist', new Cart());
    }

    //Route #3: For the contact page
    #[Route('/contact', name: 'contact.route')]
    public function contactRoute(Request $request): Response
    {
        $this->initSession($request);

        return $this->render('page/contact.html.twig', [
            'categories' => $this->categories,
            'last_email' => $this->lastEmail,
            'cartlength' => $this->cartLength->calculatePurchases()
        ]);
    }
}
