<?php

namespace App\Repository;

use App\Entity\JoueurPartie;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;
use Doctrine\Persistence\ManagerRegistry;

/**
 * @extends ServiceEntityRepository<JoueurPartie>
 *
 * @method JoueurPartie|null find($id, $lockMode = null, $lockVersion = null)
 * @method JoueurPartie|null findOneBy(array $criteria, array $orderBy = null)
 * @method JoueurPartie[]    findAll()
 * @method JoueurPartie[]    findBy(array $criteria, array $orderBy = null, $limit = null, $offset = null)
 */
class JoueurPartieRepository extends ServiceEntityRepository
{
    public function __construct(ManagerRegistry $registry)
    {
        parent::__construct($registry, JoueurPartie::class);
    }

//    /**
//     * @return JoueurPartie[] Returns an array of JoueurPartie objects
//     */
//    public function findByExampleField($value): array
//    {
//        return $this->createQueryBuilder('j')
//            ->andWhere('j.exampleField = :val')
//            ->setParameter('val', $value)
//            ->orderBy('j.id', 'ASC')
//            ->setMaxResults(10)
//            ->getQuery()
//            ->getResult()
//        ;
//    }

//    public function findOneBySomeField($value): ?JoueurPartie
//    {
//        return $this->createQueryBuilder('j')
//            ->andWhere('j.exampleField = :val')
//            ->setParameter('val', $value)
//            ->getQuery()
//            ->getOneOrNullResult()
//        ;
//    }
}
