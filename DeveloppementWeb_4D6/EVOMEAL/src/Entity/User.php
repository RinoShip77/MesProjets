<?php

namespace App\Entity;

use App\Repository\UserRepository;
use Doctrine\Common\Collections\ArrayCollection;
use Doctrine\Common\Collections\Collection;
use Doctrine\ORM\Mapping as ORM;
use Symfony\Bridge\Doctrine\Validator\Constraints\UniqueEntity;
use Symfony\Component\Security\Core\User\PasswordAuthenticatedUserInterface;
use Symfony\Component\Security\Core\User\UserInterface;
use Symfony\Component\Validator\Constraints as Assert;

#[ORM\Entity(repositoryClass: UserRepository::class)]
#[UniqueEntity(fields: ['email'], message: 'There is already an account with this email')]
#[ORM\Table(name: 'users')]
class User implements UserInterface, PasswordAuthenticatedUserInterface
{
    #[ORM\Id]
    #[ORM\GeneratedValue]
    #[ORM\Column(name: 'idUser')]
    private ?int $idUser = null;

    #[ORM\Column(length: 180, unique: true)]
    #[Assert\Length(min: 5, minMessage: "Votre adresse courriel doit contenir un minimum de {{ limit }} carctères.")]
    #[Assert\Email(message: "Votre adresse courriel : {{ value }} est invalide")]
    private ?string $email = null;

    #[ORM\Column(name: 'lastName', length: 50)]
    #[Assert\Length(min: 2, minMessage: "Votre nom de famille doit contenir un minimum de {{ limit }} carctères.")]
    #[Assert\Length(max: 30, maxMessage: "Votre nom de famille doit contenir un maximum de {{ limit }} carctères.")]
    private ?string $lastName = null;

    #[ORM\Column(name: 'firstName', length: 50)]
    #[Assert\Length(min: 2, minMessage: "Votre prénom doit contenir un minimum de {{ limit }} carctères.")]
    #[Assert\Length(max: 30, maxMessage: "Votre prénom doit contenir un maximum de {{ limit }} carctères.")]
    private ?string $firstName = null;

    /**
     * @var string The hashed password
     */
    #[ORM\Column]
    private ?string $password = null;

    #[ORM\Column(length: 120)]
    #[Assert\Length(min: 5, minMessage: "Votre adresse civique doit contenir un minimum de {{ limit }} carctères.")]
    #[Assert\Length(max: 100, maxMessage: "Votre adresse civique doit contenir un maximum de {{ limit }} carctères.")]
    private ?string $address = null;

    #[ORM\Column(length: 50)]
    #[Assert\Length(min: 3, minMessage: "Votre ville doit contenir un minimum de {{ limit }} carctères.")]
    #[Assert\Length(max: 30, maxMessage: "Votre ville doit contenir un maximum de {{ limit }} carctères.")]
    private ?string $city = null;

    #[ORM\Column(name: 'postalCode', length: 7)]
    #[Assert\Regex(pattern: "/^(?!.*[DFIOQU])[A-VXY]\d[A-Z]\d[A-Z]\d$/", message: "Votre code postal n'est pas valide.")]
    //Regex:
    //  - Negative Lookahead: (?!.*[DFIOQU])
    //      - Matches any character: .
    //      - Matches the previous token between zero and unlimited times: *
    //  - Matches a digit: \d
    private ?string $postalCode = null;

    #[ORM\Column(length: 2)]
    private $province = null;

    #[ORM\Column(name: 'phoneNumber', length: 12, nullable: true)]
    #[Assert\Regex(pattern: "/^\d{10}$/", message: "Votre numéro de téléphone n'est pas valide.")]
    //Regex:
    //  - Matches the previous token exactly 10 times
    private ?string $phoneNumber = null;

    #[ORM\Column]
    private array $roles = [];

    #[ORM\OneToMany(mappedBy: 'user', targetEntity: Order::class, orphanRemoval: true)]
    private Collection $orders;

    public function __construct()
    {
        $this->roles = ["ROLE_USER"];
        $this->orders = new ArrayCollection();
    }

    public function getIdUser(): ?int
    {
        return $this->idUser;
    }

    public function getEmail(): ?string
    {
        return $this->email;
    }

    public function setEmail(string $email): self
    {
        $this->email = $email;

        return $this;
    }

    public function getLastName(): ?string
    {
        return $this->lastName;
    }

    public function setLastName(string $lastName): self
    {
        $this->lastName = $lastName;

        return $this;
    }

    public function getFirstName(): ?string
    {
        return $this->firstName;
    }

    public function setFirstName(string $firstName): self
    {
        $this->firstName = $firstName;

        return $this;
    }

    public function getAddress(): ?string
    {
        return $this->address;
    }

    public function setAddress(string $address): self
    {
        $this->address = $address;

        return $this;
    }

    public function getCity(): ?string
    {
        return $this->city;
    }

    public function setCity(string $city): self
    {
        $this->city = $city;

        return $this;
    }

    public function getPostalCode(): ?string
    {
        return $this->postalCode;
    }

    public function setPostalCode(string $postalCode): self
    {
        $this->postalCode = $postalCode;

        return $this;
    }

    public function getProvince(): ?string
    {
        return $this->province;
    }

    public function setProvince(string $province): self
    {
        $this->province = $province;

        return $this;
    }

    public function getPhoneNumber(): ?string
    {
        return $this->phoneNumber;
    }

    public function setPhoneNumber(string $phoneNumber): self
    {
        $this->phoneNumber = $phoneNumber;

        return $this;
    }

    /**
     * A visual identifier that represents this user.
     *
     * @see UserInterface
     */
    public function getUserIdentifier(): string
    {
        return (string) $this->email;
    }

    /**
     * @see UserInterface
     */
    public function getRoles(): array
    {
        $roles = $this->roles;
        // guarantee every user at least has ROLE_USER
        $roles[] = 'ROLE_USER';

        return array_unique($roles);
    }

    /**
     * @see PasswordAuthenticatedUserInterface
     */
    public function getPassword(): string
    {
        return $this->password;
    }

    public function setPassword(string $password): self
    {
        $this->password = $password;

        return $this;
    }

    /**
     * @see UserInterface
     */
    public function eraseCredentials()
    {
        // If you store any temporary, sensitive data on the user, clear it here
        // $this->plainPassword = null;
    }

    /**
     * @return Collection<int, Order>
     */
    public function getOrders(): Collection
    {
        return $this->orders;
    }

    public function addOrder(Order $order): self
    {
        if (!$this->orders->contains($order)) {
            $this->orders->add($order);
            $order->setUser($this);
        }

        return $this;
    }

    public function removeOrder(Order $order): self
    {
        if ($this->orders->removeElement($order)) {
            // set the owning side to null (unless already changed)
            if ($order->getUser() === $this) {
                $order->setUser(null);
            }
        }

        return $this;
    }
}
