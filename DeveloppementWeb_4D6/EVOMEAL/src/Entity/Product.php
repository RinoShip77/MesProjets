<?php

namespace App\Entity;

use App\Repository\ProductRepository;
use Doctrine\ORM\Mapping as ORM;

#[ORM\Entity(repositoryClass: ProductRepository::class)]
#[ORM\Table(name: 'products')]
class Product
{
    #[ORM\Id]
    #[ORM\GeneratedValue]
    #[ORM\Column('idProduct')]
    private ?int $idProduct = null;

    #[ORM\Column(length: 50)]
    private ?string $name = null;

    #[ORM\Column]
    private ?float $price = null;
    
    #[ORM\Column('quantityInStock')]
    private ?int $quantityInStock = null;
    
    #[ORM\Column(length: 1024, nullable: true)]
    private ?string $description = null;
    
    #[ORM\Column(name: 'imagePath', length: 255)]
    private ?string $imagePath = null;
    
    #[ORM\Column]
    private ?float $rating = null;

    #[ORM\Column('idCategory')]
    private ?int $idCategory = null;
    
    //Declaring a relationship between the two tables (a relationship on the 'MANY' side)
    #[ORM\ManyToOne(targetEntity: Category::class, inversedBy: "products", cascade: ["persist"])]
    #[ORM\JoinColumn(name: 'idCategory', referencedColumnName: 'idCategory')] //Associates the column of this table with the column of another table
    private $categoryName;

    public function getIdProduct(): ?int
    {
        return $this->idProduct;
    }

    public function getName(): ?string
    {
        return $this->name;
    }

    public function setName(string $name): self
    {
        $this->name = strtoupper($name);

        return $this;
    }
    
    public function getPrice(): ?float
    {
        return $this->price;
    }
    
    public function setPrice(string $price): self
    {
        $this->price = $price;

        return $this;
    }
    
    public function getQuantityInStock(): ?int
    {
        return $this->quantityInStock;
    }
    
    public function setQuantityInStock(string $quantityInStock): self
    {
        $this->quantityInStock = $quantityInStock;
    
        return $this;
    }
    
    public function getDescription(): ?string
    {
        return $this->description;
    }
    
    public function setDescription(string $description): self
    {
        $this->description = $description;
        
        return $this;
    }
    
    public function getImagePath(): ?string
    {
        return $this->imagePath;
    }
    
    public function setImagePath($imagePath): self
    {
        $this->imagePath = $imagePath;
    
        return $this;
    }

    public function getRating(): ?float
    {
        return $this->rating;
    }
    
    public function setRating($rating): self
    {
        $this->rating = $rating;
    
        return $this;
    }
    
    public function getCategoryName(): ?Category
    {
        return $this->categoryName;
    }
    
    public function setCategoryName(?Category $categoryName): self
    {
        $this->categoryName = $categoryName;
    
        return $this;
    }

    public function soldProduct(int $newQuantity)
    {
        if (($this->quantityInStock - $newQuantity) < 0) {
            $this->quantityInStock = 0;
        } else {
            $this->quantityInStock -= $newQuantity;
        }
    }
}
