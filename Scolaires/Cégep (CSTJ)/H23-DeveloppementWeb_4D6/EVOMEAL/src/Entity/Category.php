<?php

namespace App\Entity;

use App\Repository\CategoryRepository;
use Doctrine\Common\Collections\Collection;
use Doctrine\ORM\Mapping as ORM;

#[ORM\Entity(repositoryClass: CategoryRepository::class)]
#[ORM\Table(name: 'categories')] //Database table definition
class Category
{
    #[ORM\Id] //The column will be the primary key
    #[ORM\GeneratedValue] //The column will be automatically incremented
    #[ORM\Column('idCategory')] //Specifies the name of the column
    private ?int $idCategory = null; //Adding the column

    //Specifies the possible length of the field
    #[ORM\Column(name:'categoryName', length: 50)]
    private ?string $categoryName = null;

    //Declaring a relationship between the two tables (a relationship on the 'UN' side)
    #[ORM\OneToMany(targetEntity: Product::class, mappedBy: "categoryName", fetch: "LAZY")]
    private Collection $products;

    //Declaring a 'get' accessor block
    public function getIdCategory(): ?int
    {
        return $this->idCategory;
    }

    public function getCategoryName(): ?string
    {
        return $this->categoryName;
    }

    public function setCategoryName(string $categoryName): self
    {
        $this->categoryName = $categoryName;

        return $this;
    }

    public function getProducts(): Collection
    {
        return $this->products;
    }
}
