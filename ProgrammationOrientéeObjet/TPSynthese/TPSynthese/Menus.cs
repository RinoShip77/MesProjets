using System;
using System.Collections.Generic;
using System.Text;

namespace TPSynthese
{
    namespace Menu
    {
        /// <summary>
        /// La classe de base et abstraite pour tous les menus
        /// </summary>
        abstract class Menu
        {
            /// <summary>
            /// Constructeur par défaut de la classe
            /// </summary>
            /// <param name="ligne">La ligne en paramètre</param>
            public Menu(string ligne)
            {
                AfficherTitre(ligne); // Affiche le titre à la création
            }

            /// <summary>
            /// Ajouter un menu
            /// </summary>
            /// <param name="ligne">La chaîne de caractères</param>
            /// <param name="choixMin">Le choix minimale du menu</param>
            /// <param name="choixMax">Le choix maximale du menu</param>
            public Menu(string ligne, int choixMin, int choixMax)
            {
                AjouterOption(new OptionMenu(Convert.ToString(choixMin), ligne)); // Ajoute un option au menu en appeleant la bonne fonction
                AjouterOption(new OptionMenu(Convert.ToString(choixMax), ligne));
            }

            /// <summary>
            /// Permet d’afficher un titre dans le haut de la console
            /// </summary>
            /// <param name="titre">Le titre a afficher</param>
            public static void AfficherTitre(string titre)
            {
                StringBuilder sb = new StringBuilder(); // Va génèrer une ligne de '=' deux foix la longueur que la chaine donnée
                sb.Insert(0, "=", (titre.Length * 2));
                Console.WriteLine("\n{0}\n{1}\n{2}\n",
                    sb, titre, sb);
            }

            /// <summary>
            /// Permet d’afficher un menu et de demander le choix de l’utilisateur
            /// </summary>
            /// <param name="caractere">Le caractère a afficher</param>
            /// <returns>Le caractère en entier</returns>
            public int Afficher(out char caractere)
            {
                caractere = ' '; // Initialise le caractère

                foreach (var item in _options) // On parcours les items de la liste
                {
                    Console.WriteLine(item); // On les affichent
                }
                ValiderChoix(Convert.ToString(caractere), out caractere); // On valide la saisie

                return Convert.ToInt32(caractere); // On retourne le caractère sous forme d'entier
            }

            /// <summary>
            /// Permet d'ajouter une option au menu
            /// </summary>
            /// <param name="option">L'option a ajouter</param>
            public void AjouterOption(OptionMenu option)
            {
                _options.Enqueue(option); // Ajoute un option de menu da la queue
            }

            /// <summary>
            /// Vérifie le choix de l’utilisateur et le redemande tant qu’il n’est pas valide
            /// </summary>
            /// <param name="ligne">La ligne à vérifier</param>
            /// <param name="choixChar">Le caractère à vérifier</param>
            /// <returns>Vrai si le choix est valide, sinon faux</returns>
            protected virtual bool ValiderChoix(string ligne, out char choixChar)
            {
                ligne = ""; // On initialise les variable
                choixChar = ' ';

                while (ligne.Length == 0 || choixChar.ToString().Length == 0) // Tant que c'est vide
                {
                    try
                    {
                        Console.Write("Votre choix > "); // Affiche
                        choixChar = Convert.ToChar(Console.ReadLine().ToUpper().Trim()); // Récupère la saisie, va la convertir en 'char' la met en majuscule et supprime les espaces en trop
                        ligne = Console.ReadLine().ToUpper().Trim();  // Récupère la saisie, la met en majuscule et supprime les espaces en trop

                        if (Char.IsWhiteSpace(choixChar) || ligne.Length == 0) // Si vide
                        {
                            Console.Write("\n"); // On saute un ligne
                        }
                    }
                    catch (Exception)
                    {
                        throw new Exception(); // Lance une execption
                    }                    
                }
                return true; // Retourne vrai
            }

            /// <summary>
            /// Déclaration de variables locale propres à un item musicale
            /// </summary>
            private Queue<OptionMenu> _options = new Queue<OptionMenu>(); // Liste des options du menu
        }

        /// <summary>
        /// Menu principal de l'application
        /// </summary>
        class Principal : Menu
        {
            /// <summary>
            /// Constructeur
            /// </summary>
            public Principal() :
               base("Bibliothèque musicale")
            {
                AjouterOption(new OptionMenu("A", "Afficher les albums"));
                AjouterOption(new OptionMenu("R", "Afficher les artistes"));
                AjouterOption(new OptionMenu("C", "Afficher les chansons"));
                AjouterOption(new OptionMenu("Q", "Quitter"));
            }
        }


        /// <summary>
        /// Menu pour le choix des options d'affichage
        /// </summary>
        class SelectionAffichage : Menu
        {
            /// <summary>
            /// Constructeur
            /// </summary>
            /// <param name="type">Le type d'item à afficher</param>
            /// <param name="t">Le tri pour le type d'item</param>
            public SelectionAffichage(TypeItem type, Tri t) :
               base(string.Format("Affichage des {0}s", type), 1, 3)
            {
                AjouterOption(new OptionMenu("1", string.Format("Choisir l'ordre de tri [{0}]", t)));
                AjouterOption(new OptionMenu("*", "Afficher toute la liste"));
                AjouterOption(new OptionMenu("Lettre", "Afficher les items dont le nom débute par la lettre donnée"));
                AjouterOption(new OptionMenu("2", "Rechercher"));
                AjouterOption(new OptionMenu("3", "Retour au menu principal"));
            }

            /// <inheritdoc/>
            protected override bool ValiderChoix(string ligne, out char choixChar)
            {
                // Doit être une lettre
                if (char.TryParse(ligne, out choixChar) && char.IsLetter(choixChar))
                {
                    return true;
                }

                // Laisse la classe de base faire la vérification normale
                return base.ValiderChoix(ligne, out choixChar);
            }
        }


        /// <summary>
        /// Menu pour le choix du tri
        /// </summary>
        class SelectionTri : Menu
        {
            /// <summary>
            /// Constructeur
            /// </summary>
            /// <param name="type">Le type d'item à trier</param>
            public SelectionTri(TypeItem type) :
               base(string.Format("Sélection du tri des {0}s", type))
            {
                AjouterOption(new OptionMenu("A", "A à Z"));
                AjouterOption(new OptionMenu("Z", "Z à A"));
            }
        }


        /// <summary>
        /// Menu pour la navigation dans une liste
        /// </summary>
        class Liste : Menu
        {
            /// <summary>
            /// Constructeur
            /// </summary>
            /// <param name="min">La valeur miminale des options numériques</param>
            /// <param name="max">La valeur maxinale des options numériques</param>
            /// <param name="aPrecedent">Vrai si la liste a une page précédente</param>
            /// <param name="aSuivant">Vrai si la liste a une page suivante</param>
            public Liste(int min, int max, bool aPrecedent, bool aSuivant) :
               base(null, min, max)
            {
                if (aPrecedent)
                {
                    AjouterOption(new OptionMenu("P", "Page précédente"));
                }
                if (aSuivant)
                {
                    AjouterOption(new OptionMenu("S", "Page suivante"));
                }
                AjouterOption(new OptionMenu("R", "Retour"));
            }
        }
    }
}