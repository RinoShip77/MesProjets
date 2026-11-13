<?php

namespace App\Form;

use Symfony\Component\Form\AbstractType;
use Symfony\Component\Form\Extension\Core\Type\PasswordType;
use Symfony\Component\Form\Extension\Core\Type\RepeatedType;
use Symfony\Component\Form\Extension\Core\Type\SubmitType;
use Symfony\Component\Form\FormBuilderInterface;

class PasswordFormType extends AbstractType
{
    public function buildForm(FormBuilderInterface $builder, array $options): void
    {
        $builder
            ->add('activePassword', PasswordType::class, [
                'label' => 'Votre mot de passe',
                'mapped' => false,
                'required' => true,
                'attr' => [
                    'placeholder' => 'Veuillez insérer votre mot de passe actuel.'
                ]
            ])
            ->add('newPassword', RepeatedType::class, [
                'type' => PasswordType::class,
                'invalid_message' => 'Les mots de passe doivent être identitques.',
                'mapped' => false,
                'required' => true,
                'first_options' => [
                    'label' => 'Nouveau mot de passe',
                    'attr' => [
                        'placeholder' => 'Veuillez insérer votre mot de passe.'
                    ]
                ],
                'second_options' => [
                    'label' => 'Confimation du nouveau mot de passe',
                    'attr' => [
                        'placeholder' => 'Veuillez de nouveau insérer votre mot de passe.'
                    ]
                ]
            ])
            ->add('save', SubmitType::class, [
                'label' => 'Modifier mon mot de passe',
                'row_attr' => [
                    'class' => 'form-button'
                ],
                'attr' => [
                    'class' => 'btn-dark'
                ]
            ]);
    }
}
