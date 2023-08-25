<?php

namespace App\Form;

use Symfony\Component\Form\AbstractType;
use Symfony\Component\Form\Extension\Core\Type\CollectionType;
use Symfony\Component\Form\Extension\Core\Type\SubmitType;
use Symfony\Component\Form\FormBuilderInterface;
use Symfony\Component\OptionsResolver\OptionsResolver;

class CategoryCollectionFormType extends AbstractType
{
    public function buildForm(FormBuilderInterface $builder, array $options): void
    {
        $builder
            ->add('categories', CollectionType::class, [
                'entry_type' => CategoryFormType::class,
                'allow_add' => true
            ])
            ->add('save', SubmitType::class, [
                'label' => '<i class="fas fa-floppy-disk me-2"></i>Sauvegarder les catégories',
                'label_html' => true,
                'row_attr' => ['class' => 'form-button'],
                'attr' => ['class' => 'btn-dark']
            ]);
    }

    public function configureOptions(OptionsResolver $resolver): void
    {
        $resolver->setDefaults([
            // Configure your form options here
            'csrf_protection' => true,
            'csrf_field_name' => '_token',
            'csrf_token_id' => 'item_collection_form'
        ]);
    }
}
