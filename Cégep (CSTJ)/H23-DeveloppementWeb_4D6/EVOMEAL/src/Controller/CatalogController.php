<?php

namespace App\Controller;

use App\Entity\Cart;
use App\Entity\Product;
use App\Entity\Category;
use Doctrine\Persistence\ManagerRegistry;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\Security\Http\Authentication\AuthenticationUtils;

class CatalogController extends AbstractController
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

    //Route #1: For the homepage
    #[Route('/', name: 'catalog.route')]
    public function indexRoute(Request $request): Response
    {
        $this->initSession($request);
        
        //Retrieves products according to the search
        $products = $this->em->getRepository(Product::class)->findWithCriteria($request->query->get('category'), $request->request->get('search_field'));

        //Displays the page with the information
        return $this->render('catalog/catalog.html.twig', [
            'categories' => $this->categories,
            'last_email' => $this->lastEmail,
            'cartlength' => $this->cartLength->calculatePurchases(),
            'products' => $products
        ]);
    }

    //Route #2 : For product details page
    #[Route('/products/{idProduct}', name: 'product_modal')]
    public function infoProduct($idProduct): Response
    {
        $product = $this->em->getRepository(Product::class)->find($idProduct);

        return $this->render('catalog/product.modal.twig', [
            'product' => $product
        ]);
    }
}
