<?php

namespace App\Controller;

use App\Entity\Cart;
use App\Entity\Category;
use App\Entity\User;
use App\Form\RegistrationFormType;
use Doctrine\Persistence\ManagerRegistry;
use Symfony\Bundle\SecurityBundle\Security;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\PasswordHasher\Hasher\UserPasswordHasherInterface;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\Security\Http\Authentication\AuthenticationUtils;

class RegistrationController extends AbstractController
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

    #[Route('/register', name: 'register')]
    public function register(Request $request, UserPasswordHasherInterface $userPasswordHasher, Security $security): Response
    {
        $this->initSession($request);
        $user = new User();
        $form = $this->createForm(RegistrationFormType::class, $user);
        $form->handleRequest($request);

        if ($form->isSubmitted() && $form->isValid()) {
            // encode the plain password
            $user->setPassword(
                $userPasswordHasher->hashPassword(
                    $user,
                    $form->get('password')->getData()
                )
            );

            $this->em->persist($user);
            $this->em->flush();
            $security->login($user);

            return $this->redirectToRoute('catalog.route');
        }

        return $this->render('registration/register.html.twig', [
            'categories' => $this->categories,
            'last_email' => $this->lastEmail,
            'cartlength' => $this->cartLength->calculatePurchases(),
            'registration_form' => $form->createView()
        ]);
    }
}
