<?php

namespace App\Entity;

use App\Core\Constants;
use App\Repository\OrderRepository;
use DateTime;
use Doctrine\Common\Collections\ArrayCollection;
use Doctrine\Common\Collections\Collection;
use Doctrine\DBAL\Types\Types;
use Doctrine\ORM\Mapping as ORM;

#[ORM\Entity(repositoryClass: OrderRepository::class)]
#[ORM\Table(name: 'orders')]
class Order
{
    #[ORM\Id]
    #[ORM\GeneratedValue]
    #[ORM\Column(name: 'idOrder')]
    private ?int $idOrder = null;

    #[ORM\ManyToOne(inversedBy: 'orders')]
    #[ORM\JoinColumn(name: 'idUser', referencedColumnName: 'idUser', nullable: false)]
    private ?User $user = null;

    #[ORM\Column(type: Types::DATETIME_MUTABLE, name: 'orderDate', length: 19, nullable: false)]
    private ?\DateTimeInterface $orderDate = null;

    #[ORM\Column(type: Types::DATETIME_MUTABLE, name: 'deliveryDate', length: 19, nullable: true)]
    private ?\DateTimeInterface $deliveryDate = null;

    #[ORM\Column(name: 'GSTrate', nullable: false)]
    private ?float $GSTrate = null;

    #[ORM\Column(name: 'QSTrate', nullable: false)]
    private ?float $QSTrate = null;

    #[ORM\Column(name: 'shippingCost', nullable: false)]
    private ?float $shippingCost = null;

    #[ORM\Column(length: 16, nullable: false)]
    private ?string $status = null;

    #[ORM\Column(name: 'stripeIntent', length: 255, nullable: false)]
    private ?string $stripeIntent = null;

    #[ORM\OneToMany(mappedBy: 'order', targetEntity: Purchase::class, cascade: ['persist'])]
    private Collection $purchases;

    public function __construct($user, $stripeIntent)
    {
        $this->user = $user;
        $this->orderDate = new DateTime();
        $this->GSTrate = Constants::GST;
        $this->QSTrate = Constants::QST;
        $this->shippingCost = Constants::SHIPPING_COST;
        $this->status = 'P';
        $this->stripeIntent = $stripeIntent;
        $this->purchases = new ArrayCollection();
    }

    public function getIdOrder(): ?int
    {
        return $this->idOrder;
    }

    public function getUser(): ?User
    {
        return $this->user;
    }

    public function getOrderDate(): ?\DateTimeInterface
    {
        return $this->orderDate;
    }

    public function getDeliveryDate(): ?\DateTimeInterface
    {
        return $this->deliveryDate;
    }

    public function setDeliveryDate()
    {
        $this->deliveryDate = new DateTime();
    }

    public function getGSTrate(): ?float
    {
        return $this->GSTrate;
    }

    public function getQSTrate(): ?float
    {
        return $this->QSTrate;
    }

    public function getShippingCost(): ?float
    {
        return $this->shippingCost;
    }

    public function getStatus()
    {
        return $this->status;
    }

    public function setStatus(string $status): self
    {
        $this->status = $status;

        return $this;
    }

    public function getStripeIntent(): ?string
    {
        return $this->stripeIntent;
    }

    /**
     * @return Collection<int, Purchase>
     */
    public function getPurchases(): Collection
    {
        return $this->purchases;
    }

    public function addPurchase(Purchase $purchase): self
    {
        if (!$this->purchases->contains($purchase)) {
            $this->purchases->add($purchase);
            $purchase->setOrder($this);
        }

        return $this;
    }

    public function removePurchase(Purchase $purchase): self
    {
        if ($this->purchases->removeElement($purchase)) {
            // set the owning side to null (unless already changed)
            if ($purchase->getOrder() === $this) {
                $purchase->setOrder(null);
            }
        }

        return $this;
    }

    public function calculateProducts()
    {
        $quantity = 0;
        foreach ($this->purchases as $purchase) {
            $quantity += $purchase->getQuantity();
        }
        return $quantity;
    }

    public function calculateGST()
    {
        return $this->calculateInvoice($this->GSTrate);
    }

    public function calculateQST()
    {
        return $this->calculateInvoice($this->QSTrate);
    }

    public function calculateSubtotal()
    {
        return $this->calculateInvoice();
    }

    public function calculateTotal()
    {
        $total = $this->calculateSubtotal();
        $total += $this->calculateGST();
        $total += $this->calculateQST();
        $total += $this->shippingCost;

        return $total;
    }

    public function calculateInvoice($taxes = null)
    {
        $total = 0;
        if ($this->purchases->count() > 0) {
            foreach ($this->purchases as $purchase) {
                $total += $purchase->getPrice();
            }
        }

        return $taxes != null ? $total * $taxes : $total;
    }

    public function statusInFrench(string $status)
    {
        switch ($status) {
            case 'P':
                $status = 'En préparation';
                break;
            case 'S':
                $status = 'Envoyée';
                break;
            case 'T':
                $status = 'En transit';
                break;
            case 'D':
                $status = 'Livrée';
                break;
        }

        return $status;
    }
}
