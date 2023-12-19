<?php

namespace App\Entity;

use App\Repository\JoueurRepository;
use Doctrine\Common\Collections\ArrayCollection;
use Doctrine\Common\Collections\Collection;
use Doctrine\DBAL\Types\Types;
use Doctrine\ORM\Mapping as ORM;

#[ORM\Entity(repositoryClass: JoueurRepository::class)]
class Joueur
{
    #[ORM\Id]
    #[ORM\GeneratedValue]
    #[ORM\Column]
    private ?int $id = null;

    #[ORM\Column(length: 30)]
    private ?string $nom = null;

    #[ORM\Column(length: 15, name: 'motDePasse')]
    private ?string $motDePasse = null;

    #[ORM\Column(length: 255)]
    private ?string $courriel = null;

    #[ORM\Column(type: Types::DATETIME_MUTABLE)]
    private ?\DateTimeInterface $creation = null;

    #[ORM\Column(name: 'nbLogin')]
    private ?int $nbLogin = null;

    #[ORM\Column(type: Types::DATETIME_MUTABLE, name: 'dernierLogin')]
    private ?\DateTimeInterface $dernierLogin = null;

    #[ORM\OneToMany(mappedBy: 'joueur', targetEntity: JoueurPartie::class)]
    private Collection $parties;

    public function __construct()
    {
        $this->parties = new ArrayCollection();
    }

    public function getId(): ?int
    {
        return $this->id;
    }

    public function getNom(): ?string
    {
        return $this->nom;
    }

    public function setNom(string $nom): static
    {
        $this->nom = $nom;

        return $this;
    }

    public function getMotDePasse(): ?string
    {
        return $this->motDePasse;
    }

    public function setMotDePasse(string $motDePasse): static
    {
        $this->motDePasse = $motDePasse;

        return $this;
    }

    public function getCourriel(): ?string
    {
        return $this->courriel;
    }

    public function setCourriel(string $courriel): static
    {
        $this->courriel = $courriel;

        return $this;
    }

    public function getCreation(): ?\DateTimeInterface
    {
        return $this->creation;
    }

    public function setCreation(\DateTimeInterface $creation): static
    {
        $this->creation = $creation;

        return $this;
    }

    public function getNbLogin(): ?int
    {
        return $this->nbLogin;
    }

    public function setNbLogin(int $nbLogin): static
    {
        $this->nbLogin = $nbLogin;

        return $this;
    }

    public function getDernierLogin(): ?\DateTimeInterface
    {
        return $this->dernierLogin;
    }

    public function setDernierLogin(\DateTimeInterface $dernierLogin): static
    {
        $this->dernierLogin = $dernierLogin;

        return $this;
    }

    /**
     * @return Collection<int, JoueurPartie>
     */
    public function getParties(): Collection
    {
        return $this->parties;
    }

    public function addParty(JoueurPartie $party): static
    {
        if (!$this->parties->contains($party)) {
            $this->parties->add($party);
            $party->setJoueur($this);
        }

        return $this;
    }

    public function removeParty(JoueurPartie $party): static
    {
        if ($this->parties->removeElement($party)) {
            // set the owning side to null (unless already changed)
            if ($party->getJoueur() === $this) {
                $party->setJoueur(null);
            }
        }

        return $this;
    }
}
