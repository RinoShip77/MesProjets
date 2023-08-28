<?php

namespace App\Form;

use Symfony\Component\Form\FormBuilderInterface;
use Symfony\Component\Form\Extension\Core\Type\SubmitType;

class ProfileFormType extends RegistrationFormType
{
    public function getParent()
    {
        return RegistrationFormType::class;
    }

    public function buildForm(FormBuilderInterface $builder, array $options): void
    {
        $builder
            ->remove('email')
            ->remove('password')
            ->remove('create')
            ->add('save', SubmitType::class, [
                'label' => 'Sauvegarder mon compte',
                'row_attr' => [
                    'class' => 'form-button'
                ],
                'attr' => [
                    'class' => 'btn-dark'
                ]
            ]);
    }
}
