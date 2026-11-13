<?php

namespace App\Controller;

use App\Entity\User;
use App\Entity\Category;
use App\Form\ProfileFormType;
use App\Core\Notification;
use App\Core\NotificationColor;
use App\Entity\Cart;
use App\Form\PasswordFormType;
use Doctrine\Persistence\ManagerRegistry;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\PasswordHasher\Hasher\UserPasswordHasherInterface;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\Security\Http\Authentication\AuthenticationUtils;

class ProfileController extends AbstractController
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

    #[Route('/user/profile', name: 'profile')]
    public function profile(Request $request, UserPasswordHasherInterface $passwordHasher): Response
    {
        $this->initSession($request);
        $this->denyAccessUnlessGranted('IS_AUTHENTICATED_FULLY');

        //Forms
        $profileForm = $this->createForm(ProfileFormType::class, $this->getUser());
        $profileForm->handleRequest($request);
        $passwordForm = $this->createForm(PasswordFormType::class);
        $passwordForm->handleRequest($request);

        if ($profileForm->isSubmitted()) {
            if ($profileForm->isValid()) {
                $this->em->getRepository(User::class)->save($this->getUser(), true);
                $this->addFlash('profile_modification', new Notification('success', 'La sauvegarde de votre compte est un succès.', NotificationColor::SUCCESS));
                return $this->redirectToRoute('profile');
            } else {
                $this->addFlash('profile_modification', new Notification('error', 'Impossible de sauvegarder votre compte.', NotificationColor::DANGER));
            }
        }

        if ($passwordForm->isSubmitted()) {
            if ($passwordForm->isValid() && $passwordHasher->isPasswordValid($this->getUser(), $passwordForm->get('activePassword')->getData()) && $passwordForm->get('activePassword')->getData() != $passwordForm->get('newPassword')->getData()) {
                $this->em->getRepository(User::class)->upgradePassword($this->getUser(), $passwordHasher->hashPassword($this->getUser(), $passwordForm->get('newPassword')->getData()));
                $this->addFlash('profile_modification', new Notification('success', 'Votre mot de passe a été modifié avec succès.', NotificationColor::SUCCESS));
                return $this->redirectToRoute('profile');
            } else {
                $this->addFlash('profile_modification', new Notification('error', 'Impossible de modifier votre mot de passe.', NotificationColor::DANGER));
            }
        }

        return $this->render('profile/profile.html.twig', [
            'categories' => $this->categories,
            'last_email' => $this->lastEmail,
            'cartlength' => $this->cartLength->calculatePurchases(),
            'profile_form' => $profileForm->createView(),
            'password_form' => $passwordForm->createView()
        ]);
    }

    #[Route('/user/orders', name: 'profile.orders')]
    public function orders(Request $request): Response
    {
        $this->initSession($request);
        $this->denyAccessUnlessGranted('IS_AUTHENTICATED_FULLY');

        return $this->render('profile/profileOrders.html.twig', [
            'categories' => $this->categories,
            'last_email' => $this->lastEmail,
            'cartlength' => $this->cartLength->calculatePurchases()
        ]);
    }

    #[Route('/login', name: 'login')]
    public function login(AuthenticationUtils $authentificationUtils): Response
    {
        if ($this->getUser()) {
            return $this->redirectToRoute('profile');
        }

        $error = $authentificationUtils->getLastAuthenticationError();
        if ($error != null && $error->getMessageKey() == 'Invalid credentials.') {
            $this->addFlash('login_message', new Notification('error', "Mauvaise combinaison d'identifiant et de mot de passe.", NotificationColor::DANGER));
        }

        return $this->render('profile/login.html.twig', [
            'categories' => $this->categories,
            'last_email' => $this->lastEmail,
            'cartlength' => 0
        ]);
    }

    #[Route('/logout', name: 'logout')]
    public function logout()
    {
    }
}
