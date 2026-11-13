<?php

namespace App\Controller;

use App\Core\Notification;
use App\Core\NotificationColor;
use App\Entity\Cart;
use App\Entity\Category;
use App\Entity\Order;
use App\Entity\Product;
use App\Entity\CategoryCollection;
use App\Form\CategoryCollectionFormType;
use App\Form\ProductFormType;
use Doctrine\ORM\Exception\ORMException;
use Doctrine\Persistence\ManagerRegistry;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\Security\Http\Attribute\IsGranted;
use Symfony\Component\Security\Http\Authentication\AuthenticationUtils;
use Symfony\Component\String\Slugger\SluggerInterface;
use \Symfony\Component\HttpFoundation\File\Exception\FileException;

#[IsGranted('ROLE_ADMIN')]
class AdminController extends AbstractController
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

    #[Route('/admin', name: 'admin')]
    public function admin(Request $request): Response
    {
        $this->initSession($request);
        $this->denyAccessUnlessGranted('ROLE_ADMIN');

        if (!$this->isGranted('ROLE_ADMIN')) {
            $this->redirectToRoute('catalog.route');
        }

        return $this->render('admin/admin.html.twig', [
            'categories' => $this->categories,
            'last_email' => $this->lastEmail,
            'cartlength' => $this->cartLength->calculatePurchases()
        ]);
    }

    #[Route('/admin/categories', name: 'admin.categories')]
    public function adminCategories(Request $request): Response
    {
        $this->initSession($request);
        $this->denyAccessUnlessGranted('ROLE_ADMIN');

        if (!$this->isGranted('ROLE_ADMIN')) {
            $this->redirectToRoute('catalog.route');
        }
        
        $categoriesColletion = new CategoryCollection($this->categories);
        $categoryForm = $this->createForm(CategoryCollectionFormType::class, $categoriesColletion);
        $categoryForm->handleRequest($request);
        
        if ($categoryForm->isSubmitted() && $categoryForm->isValid()) {
            $newCategoriesCollection = $categoryForm->getData()->getCategories();
            
            foreach ($newCategoriesCollection as $newCategory) {
                $this->em->persist($newCategory);
            }
            $this->em->flush();
            $this->addFlash('categories_update', new Notification('info', 'La liste de catégories a bien été modifiée.', NotificationColor::INFO));
        }

        return $this->render('admin/category/categories.html.twig', [
            'categories' => $this->categories,
            'last_email' => $this->lastEmail,
            'cartlength' => $this->cartLength->calculatePurchases(),
            'category_form' => $categoryForm
        ]);
    }
    
    #[Route('/admin/products', name: 'admin.products')]
    public function adminProducts(Request $request): Response
    {
        $this->initSession($request);
        $this->denyAccessUnlessGranted('ROLE_ADMIN');

        if (!$this->isGranted('ROLE_ADMIN')) {
            $this->redirectToRoute('catalog.route');
        }

        return $this->render('admin/product/products.html.twig', [
            'categories' => $this->categories,
            'last_email' => $this->lastEmail,
            'cartlength' => $this->cartLength->calculatePurchases(),
            'products' => $this->em->getRepository(Product::class)->findAll()
        ]);
    }

    #[Route('/admin/product', name: 'admin.add.product')]
    public function adminAddProduct(Request $request, SluggerInterface $slugger): Response
    {
        $this->initSession($request);
        $this->denyAccessUnlessGranted('ROLE_ADMIN');

        if (!$this->isGranted('ROLE_ADMIN')) {
            $this->redirectToRoute('catalog.route');
        }

        $product = new Product();
        $productForm = $this->createForm(ProductFormType::class, $product);
        $productForm->handleRequest($request);

        if ($productForm->isSubmitted() && $productForm->isValid()) {
            $productImage = $productForm->get('imagePath')->getData();

            if ($productImage) {
                $originalFilename = pathinfo($productImage->getClientOriginalName(), PATHINFO_FILENAME);
                $safeFilename = $slugger->slug($originalFilename);
                $newFilename = $safeFilename . "_" . uniqid() . "." . $productImage->guessExtension();

                try {
                    $productImage->move($this->getParameter('product_image_directory'), $newFilename);
                    $product->setImagePath("images/products/" . $newFilename);
                } catch (FileException $e) {
                    $this->addFlash('product_update', new Notification('error', 'Impossible d\'ajouter le produit.', NotificationColor::DANGER));
                } catch (ORMException $e) {
                    $this->addFlash('product_update', new Notification('error', 'Impossible d\'ajouter le produit.', NotificationColor::DANGER));
                } catch (\Exception $e) {
                    $this->addFlash('product_update', new Notification('error', 'Impossible d\'ajouter le produit.', NotificationColor::DANGER));
                }
            }

            $this->em->persist($product);
            $this->em->flush();
            $this->addFlash('product_update', new Notification('success', 'Le produit a bien été ajouté.', NotificationColor::SUCCESS));
        }

        return $this->render('admin/product/product.html.twig', [
            'categories' => $this->categories,
            'last_email' => $this->lastEmail,
            'cartlength' => $this->cartLength->calculatePurchases(),
            'add_product_form' => $productForm,
            'product' => $product
        ]);
    }

    #[Route('/admin/product/{idProduct}', name: 'admin.modify.product')]
    public function adminModifyProduct($idProduct, Request $request, SluggerInterface $slugger): Response
    {
        $this->initSession($request);
        $this->denyAccessUnlessGranted('ROLE_ADMIN');
        $product = $this->em->getRepository(Product::class)->find($idProduct);
        
        if (!$this->isGranted('ROLE_ADMIN')) {
            $this->redirectToRoute('catalog.route');
        }
        
        $productForm = $this->createForm(ProductFormType::class, $product);
        $productForm->handleRequest($request);
        
        if ($productForm->isSubmitted() && $productForm->isValid()) {
            $productImage = $productForm->get('imagePath')->getData();
            
            if ($productImage) {
                $originalFilename = pathinfo($productImage->getClientOriginalName(), PATHINFO_FILENAME);
                $safeFilename = $slugger->slug($originalFilename);
                $newFilename = $safeFilename . "_" . uniqid() . "." . $productImage->guessExtension();
                
                try {
                    $productImage->move($this->getParameter('product_image_directory'), $newFilename);
                    $product->setImagePath("images/products/" . $newFilename);
                } catch (FileException $e) {
                    $this->addFlash('product_update', new Notification('error', 'Impossible de modifié le produit ' . $product->getIdProduct() . '.', NotificationColor::DANGER));
                } catch (ORMException $e) {
                    $this->addFlash('product_update', new Notification('error', 'Impossible de modifié le produit ' . $product->getIdProduct() . '.', NotificationColor::DANGER));
                } catch (\Exception $e) {
                    $this->addFlash('product_update', new Notification('error', 'Impossible de modifié le produit ' . $product->getIdProduct() . '.', NotificationColor::DANGER));
                }
            }
            $this->em->persist($product);
            $this->em->flush();
            $this->addFlash('product_update', new Notification('info', 'Le produit ' . $product->getIdProduct() . ' a bien été modifié.', NotificationColor::INFO));
        }
        
        return $this->render('admin/product/product.html.twig', [
            'categories' => $this->categories,
            'last_email' => $this->lastEmail,
            'cartlength' => $this->cartLength->calculatePurchases(),
            'modify_product_form' => $productForm,
            'id_product' => $idProduct,
            'product' => $product
        ]);
    }


    #[Route('/admin/orders', name: 'admin.orders')]
    public function adminOrders(Request $request): Response
    {
        $this->initSession($request);
        $this->denyAccessUnlessGranted('ROLE_ADMIN');

        if (!$this->isGranted('ROLE_ADMIN')) {
            $this->redirectToRoute('catalog.route');
        }

        return $this->render('admin/order/orders.html.twig', [
            'categories' => $this->categories,
            'last_email' => $this->lastEmail,
            'cartlength' => $this->cartLength->calculatePurchases(),
            'orders' => $this->em->getRepository(Order::class)->findAll()
        ]);
    }
}
