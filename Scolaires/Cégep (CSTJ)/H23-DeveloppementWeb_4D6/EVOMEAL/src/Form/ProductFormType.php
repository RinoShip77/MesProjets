<?php

namespace App\Form;

use App\Entity\Category;
use App\Entity\Product;
use Symfony\Bridge\Doctrine\Form\Type\EntityType;
use Symfony\Component\Form\AbstractType;
use Symfony\Component\Form\Extension\Core\Type\ChoiceType;
use Symfony\Component\Form\Extension\Core\Type\FileType;
use Symfony\Component\Form\Extension\Core\Type\IntegerType;
use Symfony\Component\Form\Extension\Core\Type\MoneyType;
use Symfony\Component\Form\Extension\Core\Type\SubmitType;
use Symfony\Component\Form\Extension\Core\Type\TextareaType;
use Symfony\Component\Form\Extension\Core\Type\TextType;
use Symfony\Component\Form\FormBuilderInterface;
use Symfony\Component\OptionsResolver\OptionsResolver;
use Symfony\Component\Validator\Constraints\File;

class ProductFormType extends AbstractType
{
    public function buildForm(FormBuilderInterface $builder, array $options): void
    {
        $builder
            ->add('name', TextType::class, [
                'label' => 'Nom',
                'required' => true,
                'attr' => [
                    'maxlength' => 50,
                    'placeholder' => 'Veuillez insérer le nom.'
                ]
            ])
            ->add('price', MoneyType::class, [
                'label' => 'Prix',
                'required' => true,
                'currency' => 'CAD',
                'attr' => [
                    'placeholder' => 'Veuillez indiquer le prix.'
                ]
            ])
            ->add('quantityInStock', IntegerType::class, [
                'label' => 'Quantité en inventaire',
                'required' => true,
                'attr' => [
                    'placeholder' => 'Veuillez indiquer la quantité en inventaire.'
                ]
            ])
            ->add('description', TextareaType::class, [
                'label' => 'Description',
                'required' => false,
                'attr' => [
                    'maxlength' => 1024,
                    'placeholder' => 'Veuillez insérer la description.'
                ]
            ])
            ->add('imagePath', FileType::class, [
                'label' => 'Image du produit',
                'required' => false,
                'data_class' => null,
                'empty_data' => ' ',
                'constraints' => [
                    new File([
                        'maxSize' => '1024k',
                        'mimeTypes' => [
                            'image/png',
                            'image/jpeg'
                        ],
                        'mimeTypesMessage' => 'Téléverser une image valide.'
                    ])
                ],
                'attr' => [
                    'maxlength' => 255,
                    'placeholder' => 'Veuillez insérer l\'image.'
                ]
            ])
            ->add('categoryName', EntityType::class, [
                'label' => 'Catégorie',
                'class' => Category::class,
                'required' => true,
                'choice_label' => 'categoryName'
            ])
            ->add('rating', ChoiceType::class, [
                'label' => 'Évaluation',
                'choices' => [
                    '0 étoile' => '0',
                    '0.5 étoile' => '0.5',
                    '1 étoile' => '1',
                    '1.5 étoiles' => '1.5',
                    '2 étoiles' => '2',
                    '2.5 étoiles' => '2.5',
                    '3 étoiles' => '3',
                    '3.5 étoiles' => '3.5',
                    '4 étoiles' => '4',
                    '4.5 étoiles' => '4.5',
                    '5 étoiles' => '5'
                ]
            ])
            ->add('save', SubmitType::class, [
                'label' => 'Sauvegarder',
                'row_attr' => ['class' => 'form-button']
            ]);
    }

    public function configureOptions(OptionsResolver $resolver): void
    {
        $resolver->setDefaults([
            'data_class' => Product::class,
        ]);
    }
}
