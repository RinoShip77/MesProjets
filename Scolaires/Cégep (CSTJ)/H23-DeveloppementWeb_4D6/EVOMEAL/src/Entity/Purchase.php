<?php

namespace App\Entity;

use App\Repository\PurshaseRepository;
use Doctrine\ORM\Mapping as ORM;

#[ORM\Entity(repositoryClass: PurshaseRepository::class)]
#[ORM\Table(name: 'purchases')]
class Purchase
{
    #[ORM\Id]
    #[ORM\GeneratedValue]
    #[ORM\Column(name: 'idPurchase')]
    private ?int $idPurchase = null;

    #[ORM\ManyToOne(cascade: ["persist"])]
    #[ORM\JoinColumn(name: 'idProduct', referencedColumnName: 'idProduct', nullable: false)]
    private ?Product $product = null;

    #[ORM\ManyToOne(inversedBy: 'purchases', cascade: ["persist"])]
    #[ORM\JoinColumn(name: 'idOrder', referencedColumnName: 'idOrder', nullable: false)]
    private ?Order $order = null;

    #[ORM\Column(name: 'quantity', nullable: false)]
    private ?int $quantity = null;

    #[ORM\Column(name: 'price', nullable: false)]
    private ?float $price = null;

    public function __construct($product)
    {
        $this->quantity = 1;
        $this->price = $product->getPrice();
        $this->product = $product;
    }

    public function getIdPurchase(): ?int
    {
        return $this->idPurchase;
    }

    public function getProduct(): ?Product
    {
        return $this->product;
    }

    public function updateProduct()
    {
        $this->product->soldProduct($this->quantity);
    }

    public function getOrder(): ?Order
    {
        return $this->order;
    }

    public function setOrder(?Order $order): self
    {
        $this->order = $order;

        return $this;
    }

    public function getQuantity(): ?int
    {
        return $this->quantity;
    }
    
    public function updateQuantity($newQuantity)
    {
        $this->quantity = $newQuantity;
    }
    
    public function getPrice(): ?float
    {
        return $this->price * $this->quantity;
    }

    public function canBeSold()
    {
        if ($this->quantity > $this->product->getQuantityInStock()) {
            return false;
        } else {
            return true;
        }
    }
}
