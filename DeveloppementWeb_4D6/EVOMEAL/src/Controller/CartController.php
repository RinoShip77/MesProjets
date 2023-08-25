<?php

namespace App\Controller;

use App\Core\Notification;
use App\Core\NotificationColor;
use App\Entity\Cart;
use App\Entity\Category;
use App\Entity\Product;
use Doctrine\Persistence\ManagerRegistry;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\Security\Http\Authentication\AuthenticationUtils;

class CartController extends AbstractController
{
    private $em = null;
    private $categories;
    private $lastEmail;
    private $cartLength;
    private $purchaseList;

    public function __construct(ManagerRegistry $doctrine, AuthenticationUtils $authentificationUtils)
    {
        $this->em = $doctrine->getManager();
        $this->categories = $this->em->getRepository(Category::class)->findAll();
        $this->lastEmail = $authentificationUtils->getLastUsername();
    }

    private function initSession(Request $request)
    {
        $this->purchaseList = $request->getSession()->get('purchaselist', new Cart());
        $request->getSession()->set('purchaselist', $this->purchaseList);
    }

    #[Route('/cart', name: 'cart.index')]
    public function index(Request $request): Response
    {
        $this->initSession($request);

        return $this->render(
            'cart/cart.html.twig',
            [
                'categories' => $this->categories,
                'last_email' => $this->lastEmail,
                'cartlength' => $this->purchaseList->calculatePurchases(),
                'purchaselist' => $this->purchaseList
            ]
        );
    }

    #[Route('/cart/add/{idProduct}', name: 'cart.add', methods: ['POST'])]
    public function addPurchase($idProduct, Request $request): Response
    {
        $this->initSession($request);
        $product = $this->em->getRepository(Product::class)->find($idProduct);

        if ($product) {
            $this->purchaseList->addPurchase($product);
            $this->addFlash('cart_message', new Notification('success', 'Le produit a été ajouté avec succès dans votre panier.', NotificationColor::SUCCESS));
        }

        return $this->redirectToRoute('cart.index');
    }

    #[Route('/cart/delete/{idProduct}', name: 'cart.delete')]
    public function deletePurchase($idProduct, Request $request): Response
    {
        $this->initSession($request);
        $this->purchaseList->deleteCart($idProduct);
        $this->addFlash('cart_message', new Notification('success', 'Le produit a bien été retiré de votre panier.', NotificationColor::WARNING));

        return $this->redirectToRoute('cart.index');
    }

    #[Route('/cart/update', name: 'cart.update', methods: ['POST'])]
    public function updateCart(Request $request): Response
    {
        $this->initSession($request);
        $post = $request->request->all();
        $action = $request->request->get('action');

        if ($action == "update") {
            $this->purchaseList->updateCart($post);
            $this->addFlash('cart_message', new Notification('success', 'Le panier a été modifié avec succès.', NotificationColor::INFO));
        } else if ($action == "empty") {
            $request->getSession()->remove('purchaselist');
        }

        return $this->redirectToRoute('cart.index');
    }
}
