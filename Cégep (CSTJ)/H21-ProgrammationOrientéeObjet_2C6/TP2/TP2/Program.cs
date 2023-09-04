using System;
using System.Text;

namespace TP2
{
    /// <summary>
    /// Classe principale du système de gestion de dossiers médicaux.
    /// Gère les menus et l'exécution générale du programme.
    /// </summary>
    class Program
    {
        /// <summary>
        /// Méthode principale du programme
        /// </summary>
        static void Main()
        {
            try
            {
                // Instantiation d'un objet de la classe courrante.
                Program p = new Program();
                // Appel de la méthode principale de l'objet Program.
                // En ayant un objet, les méthodes et attributs de la classe n'ont pas à être statiques
                p.Executer();
                Pause("Sauvegarde des données et fin du programme");
            }
            catch (Exception e)
            {
                Pause("Fin du programme dûe à une exception: " + e.Message);
            }
        }


        /// <summary>
        /// Arrête l'exécution du programme pour permttre à l'utilisateur de lire la console.
        /// Attend une action de l'utilisateur avant de continuer.
        /// Doit être statique car utilisée par la méthode <c>Main</c>
        /// </summary>
        /// <param name="s">Chaine de caractères optionnelle. Si elle est fournie, elle est affichée dans la console.</param>
        public static void Pause(string s = null)
        {
            if (s != null)
            {
                Console.WriteLine(s);
            }
            Console.WriteLine("Appuyez sur une touche pour continuer...");
            Console.ReadKey(true);
        }


        /// <summary>
        /// Affiche une chaine de caractères, suivi d'une ligne de tirets
        /// </summary>
        /// <param name="s">La chaine à afficher</param>
        public static void AfficherSousTitre(string s)
        {
            StringBuilder sb = new StringBuilder();
            // Génère une ligne de tiret de la même longueur que la chaine donnée
            sb.Insert(0, "-", s.Length);
            Console.WriteLine("\n{0}\n{1}", s, sb);
        }


        /// <summary>
        /// Constructeur
        /// </summary>
        /// <remarks>Il est privé car seulement <c>Main</c> peut créer un objet de ce type</remarks>
        private Program()
        {
            _medecins = new GestionnaireMedecins();
            _patients = new GestionnairePatients(_medecins);
        }


        /// <summary>
        /// Affiche le menu principal utilisé par le méthode <c>Executer</c>
        /// </summary>
        /// <returns>Le choix de l'utilisateur en lettres majuscules</returns>
        private string AfficherMenuPrincipal()
        {
            AfficherTitre("Gestion des dossiers médicaux");
            Console.WriteLine(" 1) Ajouter");
            Console.WriteLine(" 2) Modifier");
            Console.WriteLine(" 3) Afficher");
            Console.WriteLine(" Q) Quitter");
            Console.Write("\n> ");

            return Console.ReadLine().ToUpper();
        }


        /// <summary>
        /// Boucle principale du programme
        /// </summary>
        private void Executer()
        {
            while (true)
            {
                string choix = AfficherMenuPrincipal();
                switch (choix)
                {
                    case "1":
                        Ajouter();
                        break;
                    case "2":
                        Modifier();
                        break;
                    case "3":
                        Afficher();
                        break;
                    case "Q":
                        _medecins.Sauvegarder();
                        _patients.Sauvegarder();
                        return;
                    default:
                        Pause("Choix invalide");
                        break;
                }
            }
        }


        /// <summary>
        /// Affiche le menu utilisé par le méthode <c>Ajouter</c>
        /// </summary>
        /// <returns>Le choix de l'utilisateur en lettres majuscules</returns>
        private string AfficherMenuAjout()
        {
            AfficherTitre("Gestion des dossiers médicaux - Ajout");
            Console.WriteLine(" 1) Ajouter un médecin");
            Console.WriteLine(" 2) Ajouter un patient");
            Console.WriteLine(" R) Retour au menu principal");
            Console.Write("\n> ");

            return Console.ReadLine().ToUpper();
        }


        /// <summary>
        /// Option "1" du menu principal
        /// Boucle dans le sous-menu tant que l'utilisateur ne choisi pas de retourner au menu principal
        /// </summary>
        private void Ajouter()
        {
            while (true)
            {
                string choix = AfficherMenuAjout();
                switch (choix)
                {
                    case "1":
                        _medecins.Ajouter();
                        break;
                    case "2":
                        _patients.Ajouter();
                        break;
                    case "R":
                        return;
                    default:
                        Pause("Choix invalide");
                        break;
                }
            }
        }


        /// <summary>
        /// Affiche le menu utilisé par le méthode <c>Modifier</c>
        /// </summary>
        /// <returns>Le choix de l'utilisateur en lettres majuscules</returns>
        private string AfficherMenuModification()
        {
            AfficherTitre("Gestion des dossiers médicaux - Modification");
            Console.WriteLine(" 1) Indiquer un départ à la retraite d'un médecin");
            Console.WriteLine(" 2) Indiquer un décès d'un patient");
            Console.WriteLine(" R) Retour au menu principal");
            Console.Write("\n> ");

            return Console.ReadLine().ToUpper();
        }


        /// <summary>
        /// Option "2" du menu principal
        /// Boucle dans le sous-menu tant que l'utilisateur ne choisi pas de retourner au menu principal
        /// </summary>
        private void Modifier()
        {
            while (true)
            {
                string choix = AfficherMenuModification();
                switch (choix)
                {
                    case "1":
                        _medecins.IndiquerRetraite();
                        break;
                    case "2":
                        _patients.IndiquerDeces();
                        break;
                    case "R":
                        return;
                    default:
                        Pause("Choix invalide");
                        break;
                }
            }
        }


        /// <summary>
        /// Affiche le menu utilisé par le méthode <c>Afficher</c>
        /// </summary>
        /// <returns>Le choix de l'utilisateur en lettres majuscules</returns>
        private string AfficherMenuAffichage()
        {
            AfficherTitre("Gestion des dossiers médicaux - Affichage");
            Console.WriteLine(" 1) Afficher les statistiques");
            Console.WriteLine(" 2) Afficher la liste de médecins");
            Console.WriteLine(" 3) Afficher un médecin");
            Console.WriteLine(" 4) Afficher la liste de patients");
            Console.WriteLine(" 5) Afficher un patient");
            Console.WriteLine(" R) Retour au menu principal");
            Console.Write("\n> ");

            return Console.ReadLine().ToUpper();
        }


        /// <summary>
        /// Option "3" du menu principal
        /// Boucle dans le sous-menu tant que l'utilisateur ne choisi pas de retourner au menu principal
        /// </summary>
        private void Afficher()
        {
            while (true)
            {
                string choix = AfficherMenuAffichage();
                switch (choix)
                {
                    case "1":
                        Console.WriteLine("Le système contient:");
                        _medecins.AfficherStatistiques();
                        _patients.AfficherStatistiques();
                        Pause();
                        break;
                    case "2":
                        _medecins.AfficherListe();
                        break;
                    case "3":
                        _medecins.AfficherUnique();
                        break;
                    case "4":
                        _patients.AfficherListe();
                        break;
                    case "5":
                        _patients.AfficherUnique();
                        break;
                    case "R":
                        return;
                    default:
                        Pause("Choix invalide");
                        break;
                }
            }
        }


        /// <summary>
        /// Utilitaire pour afficher une titre dans le haut de la console
        /// </summary>
        /// <param name="titre">Le titre à afficher</param>
        private void AfficherTitre(string titre)
        {
            Console.Clear();
            StringBuilder ligne = new StringBuilder();
            const int Longueur = 80;
            ligne.Insert(0, "=", Longueur);

            const string Debut = "= ";
            const string Fin = "=";
            StringBuilder texte = new StringBuilder(Debut);
            texte.Append(titre.PadRight(Longueur - Debut.Length - Fin.Length));
            texte.Append(Fin);

            Console.Clear();
            Console.WriteLine("{0}\n{1}\n{0}\n", ligne, texte);
        }


        private GestionnaireMedecins _medecins;
        private GestionnairePatients _patients;
    }
}