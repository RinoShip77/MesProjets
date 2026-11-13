<?php

namespace App\Entity;

use App\Core\Constants;

class Cart
{
    private $purchases = [];

    public function getPurchases()
    {
        return $this->purchases;
    }

    public function addPurchase($product)
    {
        if (isset($this->purchases[$product->getIdProduct()])) {
            $this->purchases[$product->getIdProduct()]->updateQuantity($this->purchases[$product->getIdProduct()]->getQuantity() + 1);
        } else {
            $purchase = new Purchase($product);
            $this->purchases[$product->getIdProduct()] = $purchase;
        }
    }

    public function deleteCart($idPurchase)
    {
        if (array_key_exists($idPurchase, $this->purchases)) {
            unset($this->purchases[$idPurchase]);
        }
    }

    public function updateCart($newPurchases)
    {
        //Yannick - Correction #11
        if (count($this->purchases) > 0) {
            $quantity = $newPurchases["inpQuantity"];
            foreach ($this->purchases as $key => $purchase) {
                if (intval($quantity[$key]) > 0) { //Make sure input is a digit and it is positive
                    $purchase->updateQuantity(intval($quantity[$key]));
                } else if ($quantity[$key] == 0) {
                    $this->deleteCart($key);
                }
            }
        }
    }

    public function calculatePurchases()
    {
        $quantity = 0;
        foreach ($this->purchases as $purchase) {
            $quantity += $purchase->getQuantity();
        }
        return $quantity;
    }

    public function getGST()
    {
        return $this->calculateInvoice(Constants::GST);
    }

    public function getQST()
    {
        return $this->calculateInvoice(Constants::QST);
    }

    public function getShippingCost()
    {
        return (count($this->purchases) > 0) ? Constants::SHIPPING_COST : 0;
    }

    public function getSubtotal()
    {
        return $this->calculateInvoice();
    }

    public function getTotal()
    {
        $total = $this->getSubtotal();
        $total += $this->getGST();
        $total += $this->getQST();
        $total += $this->getShippingCost();

        return $total;
    }

    private function calculateInvoice($taxes = null)
    {
        $total = 0;
        if (count($this->purchases) > 0) {
            foreach ($this->purchases as $purchase) {
                $total += $purchase->getPrice();
            }
        }

        return $taxes != null ? $total * $taxes : $total;
    }

    public function calculateCheckoutTotal()
    {
        return intval($this->getTotal() * 100);
    }

    // Yannick - Correction #12
    //I add a function that return if the cart is empty
    public function isEmpty()
    {
        if(count($this->purchases) > 0) { //Count the nuber of element in the private array
            return false;
        } else {
            return true;
        }
    }
}
