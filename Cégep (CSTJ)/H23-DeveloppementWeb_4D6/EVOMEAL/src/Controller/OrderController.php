<?php

namespace App\Controller;

use App\Core\Notification;
use App\Core\NotificationColor;
use App\Entity\Cart;
use App\Entity\Category;
use App\Entity\Order;
use Doctrine\Persistence\ManagerRegistry;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\Routing\Generator\UrlGeneratorInterface;
use Symfony\Component\Security\Http\Authentication\AuthenticationUtils;

class OrderController extends AbstractController
{
    private $em = null;
    private $categories;
    private $lastEmail;
    private $cartLength;
    private $orderList;

    public function __construct(ManagerRegistry $doctrine, AuthenticationUtils $authentificationUtils)
    {
        $this->em = $doctrine->getManager();
        $this->categories = $this->em->getRepository(Category::class)->findAll();
        $this->lastEmail = $authentificationUtils->getLastUsername();
    }

    private function initSession(Request $request)
    {
        $this->cartLength = $request->getSession()->get('purchaselist', new Cart());
        $this->orderList = $request->getSession()->get('purchaselist', new Cart);
    }

    #[Route('/orders', name: 'order.preview')]
    public function orderPreview(Request $request): Response
    {
        $this->initSession($request);
        $this->denyAccessUnlessGranted('IS_AUTHENTICATED_FULLY');

        if ($this->orderList->isEmpty()) {
            $this->addFlash('payment_message', new Notification('error', 'Il est impossible de compléter une commande si votre panier est vide.<br>Veuillez réessayer.', 'danger'));

            return $this->redirectToRoute('login');
        }

        return $this->render('order/orderPreview.html.twig', [
            'categories' => $this->categories,
            'last_email' => $this->lastEmail,
            'cartlength' => $this->cartLength->calculatePurchases(),
            'orderlist' => $this->orderList
        ]);
    }

    #[Route('/orders/checkout', name: 'checkout')]
    public function checkout(Request $request): Response
    {
        $this->initSession($request);
        $this->denyAccessUnlessGranted('IS_AUTHENTICATED_FULLY');

        \Stripe\Stripe::setApiKey($_ENV["STRIPE_KEY"]);
        $checkoutSession = \Stripe\Checkout\Session::create(
            [
                'line_items' => [
                    [
                        'quantity' => 1,
                        'price_data' => ['unit_amount' => $this->orderList->calculateCheckoutTotal(), 'currency' => 'CAD', 'product_data' => ['name' => 'EVOMEAL']]
                    ]
                ],
                'customer_email' => $this->getUser()->getEmail(),
                'payment_method_types' => ['card'],
                'mode' => 'payment',
                'success_url' => $this->generateUrl('checkout.success', [], UrlGeneratorInterface::ABSOLUTE_URL) . "?stripe_id={CHECKOUT_SESSION_ID}",
                'cancel_url' => $this->generateUrl('checkout.error', [], UrlGeneratorInterface::ABSOLUTE_URL)
            ]
        );

        return $this->redirect($checkoutSession->url, 303);
    }

    #[Route('/orders/checkout/success', name: 'checkout.success')]
    public function checkoutSuccess(Request $request): Response
    {
        $this->initSession($request);
        $this->denyAccessUnlessGranted('IS_AUTHENTICATED_FULLY');

        $stripe = new \Stripe\StripeClient($_ENV["STRIPE_KEY"]);
        $paymentIntent = $stripe->checkout->sessions->retrieve($request->query->get('stripe_id'))->payment_intent;
        $order = new Order($this->getUser(), $paymentIntent);
        try {
            $statusMessage = "";

            foreach ($this->orderList->getPurchases() as $purchase) {
                $newPurchase = $this->em->merge($purchase);
                $order->addPurchase($newPurchase);
                $newPurchase->updateProduct();

                if (!$purchase->canBeSold()) {
                    $statusMessage .= 'Nous n\'avons plus de <b>' . $purchase->getProduct()->getName() . '</b> dans notre inventaire.<br>';
                }
            }

            $this->em->persist($order);
            $this->em->flush();
            $this->addFlash('order_status', new Notification('info', $statusMessage . '<br>La commande <b>' . $order->getIdOrder() . '</b> vous sera acheminé dans les plus brève délais.', NotificationColor::INFO));
            $request->getSession()->remove('purchaselist');
        } catch (\Exception $e) {
        }

        return $this->redirectToRoute('order.confirmation', ['idOrder' => $order->getIdOrder()]);
    }

    #[Route('/orders/checkout/error', name: 'checkout.error')]
    public function checkoutCancel(): Response
    {
        $this->denyAccessUnlessGranted('IS_AUTHENTICATED_FULLY');
        $this->addFlash('payment_message', new Notification('error', 'Il est impossible de compléter le paiement.<br>Veuillez réessayer.', 'danger'));

        return $this->redirectToRoute('cart.index');
    }

    #[Route('/orders/{idOrder}', name: 'order.confirmation', methods: ['GET', 'POST'])]
    public function orderConfirmation($idOrder, Request $request): Response
    {
        $this->denyAccessUnlessGranted('IS_AUTHENTICATED_FULLY');
        $order = $this->em->getRepository(Order::class)->find($idOrder);

        if ($order->getUser() != $this->getUser() && !$this->isGranted('ROLE_ADMIN')) {
            $this->addFlash('profile_orders_message', new Notification('warning', 'Cette commande ne vous concerne pas.<br>Veuillez choisir une commande dans la liste ci-dessous.', 'warning'));

            return $this->redirectToRoute('profile.orders');
        }

        $post = $request->request->all();

        if ($post) {
            switch ($post['select']) {
                case 'P':
                    $order->setStatus('P');
                    break;
                case 'S':
                    $order->setStatus('S');
                    break;
                case 'T':
                    $order->setStatus('T');
                    break;
                case 'D':
                    $order->setStatus('D');
                    $order->setDeliveryDate();
                    break;
            }

            $this->em->persist($order);
            $this->em->flush();
            $this->addFlash('order_status', new Notification('success', 'Le statut de la commande <b>' . $order->getIdOrder() . '</b> a été modifié pour <b>' . strtolower($order->statusInFrench($order->getStatus())) . '</b>.', NotificationColor::SUCCESS));
        }

        return $this->render('order/orderConfirmation.html.twig', [
            'categories' => $this->categories,
            'last_email' => $this->lastEmail,
            'cartlength' => 0,
            'order' => $order
        ]);
    }
}
