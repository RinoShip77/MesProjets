<?php

namespace App\Form;

use App\Entity\User;
use Symfony\Component\Form\AbstractType;
use Symfony\Component\Form\CallbackTransformer;
use Symfony\Component\Form\Extension\Core\Type\ChoiceType;
use Symfony\Component\Form\Extension\Core\Type\PasswordType;
use Symfony\Component\Form\Extension\Core\Type\RepeatedType;
use Symfony\Component\Form\FormBuilderInterface;
use Symfony\Component\OptionsResolver\OptionsResolver;
use Symfony\Component\Form\Extension\Core\Type\EmailType;
use Symfony\Component\Form\Extension\Core\Type\TextType;
use Symfony\Component\Form\Extension\Core\Type\SubmitType;

class RegistrationFormType extends AbstractType
{
    public function buildForm(FormBuilderInterface $builder, array $options): void
    {
        $builder
            ->add('email', EmailType::class, [
                'label' => 'Adresse courriel',
                'required' => true,
                'attr' => [
                    'type' => 'email',
                    'placeholder' => 'Veuillez insérer votre adresse courriel.'
                ]
            ])
            ->add('firstName', TextType::class, [
                'label' => 'Prénom',
                'required' => true,
                'attr' => [
                    'minlength' => 2,
                    'maxlength' => 30,
                    'placeholder' => 'Veuillez insérer votre prénom.'
                ]
            ])
            ->add('lastName', TextType::class, [
                'label' => 'Nom',
                'required' => true,
                'attr' => [
                    'minlength' => 2,
                    'maxlength' => 30,
                    'placeholder' => 'Veuillez insérer votre nom de famille.'
                ]
            ])
            ->add('password', RepeatedType::class, [
                'type' => PasswordType::class,
                'invalid_message' => 'Les mots de passe doivent être identitques.',
                'options' => [
                    'attr' => [
                        'class' => 'password-field'
                    ]
                ],
                'required' => true,
                'first_options' => [
                    'label' => 'Mot de passe',
                    'attr' => [
                        'placeholder' => 'Veuillez insérer votre mot de passe.'
                    ]
                ],
                'second_options' => [
                    'label' => 'Confimation du mot de passe',
                    'attr' => [
                        'placeholder' => 'Veuillez de nouveau insérer votre mot de passe.'
                    ]
                ]
            ])
            ->add('address', TextType::class, [
                'label' => 'Adresse civique',
                'required' => true,
                'help' => 'Exemple: 1234, rue Test',
                'attr' => [
                    'minlength' => 5,
                    'maxlength' => 100,
                    'placeholder' => 'Veuillez insérer votre numéro civique et votre nom de rue.'
                ]
            ])
            ->add('city', TextType::class, [
                'label' => 'Ville',
                'required' => true,
                'attr' => [
                    'minlength' => 3,
                    'maxlength' => 30,
                    'placeholder' => 'Veuillez insérer votre ville.'
                ]
            ])
            ->add('postalCode', TextType::class, [
                'label' => 'Code postal',
                'required' => true,
                'help' => 'Exemple: A1B 2C3',
                'attr' => [
                    'maxlength' => 7,
                    'class' => 'txtPostalCode'
                ]
            ])
            ->add('province', ChoiceType::class, [
                'label' => 'Province',
                'required' => true,
                'choices' => [
                    'Alberta' => 'AB',
                    'Colombie-Britannique' => 'BC',
                    'Manitoba' => 'MB',
                    'Nouveau-Brunswick' => 'NB',
                    'Terre-Neuve-et-Labrador' => 'NL',
                    'Nouvelle-Écosse' => 'NS',
                    'Territoire du Nord-Ouest' => 'NT',
                    'Nunavut' => 'NU',
                    'Ontario' => 'ON',
                    'Île-du-Prince-Édouard' => 'PE',
                    'Québec' => 'QC',
                    'Saskatchewan' => 'SK',
                    'Yukon' => 'YT'
                ]
            ])
            ->add('phoneNumber', TextType::class, [
                'label' => 'Téléphone',
                'help' => 'Exemple: 123-456-7890',
                'attr' => [
                    'maxlength' => 12,
                    'class' => 'txtPhoneNumber'
                ]
            ])
            ->add('create', SubmitType::class, [
                'label' => 'Créer mon compte',
                'row_attr' => [
                    'class' => 'form-button'
                ],
                'attr' => [
                    'class' => 'btn-dark'
                ]
            ]);

        //Format the postal code
        $builder->get('postalCode')->addModelTransformer(new CallbackTransformer(
            function ($phoneFromDatabase) {
                //To View
                return substr_replace($phoneFromDatabase, "-", 3, 0);
            },
            function ($phoneFromView) {
                //To Database
                return str_replace(" ", "", $phoneFromView);
            }
        ));

        //Format the phone number
        $builder->get('phoneNumber')->addModelTransformer(new CallbackTransformer(
            function ($phoneFromDatabase) {
                //To View
                $newPhone = substr_replace($phoneFromDatabase, "-", 3, 0);
                return substr_replace($newPhone, "-", 7, 0);
            },
            function ($phoneFromView) {
                //To Database
                return str_replace("-", "", $phoneFromView);
            }
        ));
    }

    public function configureOptions(OptionsResolver $resolver): void
    {
        $resolver->setDefaults([
            'data_class' => User::class,
        ]);
    }
}
