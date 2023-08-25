using System;
using System.Collections.Generic;
using System.Text;

namespace TPSynthese
{
    /// <summary>
    /// Classe principale de la bibliothèque musicale
    /// Gère l'exécution générale du programme.
    /// </summary>
    class Program
    {
        /// <summary>
        /// Méthode principale du programme
        /// </summary>
        /// <param name="args">Les noms de fichiers de données</param>
        static void Main(string[] args)
        {
            try
            {
                // Instantiation d'un objet de la classe courrante.
                Program p = new Program(args);
                // Appel de la méthode principale de l'objet Program.
                // En ayant un objet, les méthodes et attributs de la classe n'ont pas à être statiques
                p.Executer();
                Pause("Au revoir\n");
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
        /// Constructeur
        /// </summary>
        /// <param name="args">Les arguments de <c>Main</c></param>
        /// <remarks>Il est privé car seulement <c>Main</c> peut créer un objet de ce type</remarks>
        private Program(string[] args)
        {
            Console.WriteLine("Chargement des fichiers en cours...");
            _bibliotheque = new Bibliotheque(args);

            Console.WriteLine("\n==================================================");
            Console.WriteLine("Chargement terminé\n");
            Console.WriteLine(_bibliotheque.Statistiques);
            Console.WriteLine("==================================================\n");
            Pause();

            // Initialisation des choix de tri pour tous les types d'items
            for (int i = 0; i < _tris.Length; ++i)
            {
                _tris[i] = new Tri();
            }
        }

        /// <summary>
        /// Boucle principale du programme
        /// </summary>
        private void Executer()
        {
            Menu.Menu menu = new Menu.Principal();

            while (true)
            {
                char choixChar;
                if (menu.Afficher(out choixChar) != 0)
                {
                    throw new KeyNotFoundException("Choix inconnu");
                }

                switch (choixChar)
                {
                    case 'A':
                        SelectionnerAffichage(TypeItem.Album);
                        break;
                    case 'R':
                        SelectionnerAffichage(TypeItem.Artiste);
                        break;
                    case 'C':
                        SelectionnerAffichage(TypeItem.Chanson);
                        break;
                    case 'Q':
                        return;
                    default:
                        throw new KeyNotFoundException("Choix inconnu");
                }
            }
        }

        /// <summary>
        /// Option du menu principal, selon le type.
        /// Boucle dans le sous-menu tant que l'utilisateur ne choisi pas de retourner au menu principal
        /// Permet de sélectionner les critères d'affichage d'une liste d'items, puis de l'afficher
        /// </summary>
        /// <param name="type">Le type d'items à afficher</param>
        private void SelectionnerAffichage(TypeItem type)
        {
            // On choisi le bon tri dans le tableau selon le type
            Tri tri = _tris[Convert.ToInt32(type)];

            while (true)
            {
                Menu.Menu menu = new Menu.SelectionAffichage(type, tri);
                char choixChar;
                //int choix = Menu.Menu.AfficherMenuSelectionAffichage(type, tri, out choixChar);
                int choix = menu.Afficher(out choixChar);

                switch (choix)
                {
                    case 0:
                        // Une lettre ou '*' est sélectionnée
                        List<ItemMusical> l = _bibliotheque.Liste(type, choixChar, tri);
                        AfficherListe(type, tri, choixChar, "", l);
                        break;
                    case 1:
                        ChoisirTri(type, tri);
                        break;
                    case 2:
                        string recherche = DemanderRecherche();
                        List<ItemMusical> l2 = _bibliotheque.Liste(type, recherche, tri);
                        AfficherListe(type, tri, '!', recherche, l2);
                        break;
                    case 3:
                        return;  // Retour au menu principal
                    default:
                        throw new KeyNotFoundException("Choix inconnu");
                }
            }
        }

        /// <summary>
        /// Option 1 du menu de sélection d'affichage
        /// Permet à l'utilisateur de choisir l'ordre d'affichage des items
        /// </summary>
        /// <param name="type">Le type d'items à afficher</param>
        /// <param name="tri">Le tri à modifier</param>
        private void ChoisirTri(TypeItem type, Tri tri)
        {
            Menu.Menu menu = new Menu.SelectionTri(type);
            char choixChar;
            if (menu.Afficher(out choixChar) != 0)
            {
                throw new KeyNotFoundException("Choix inconnu");
            }

            switch (choixChar)
            {
                case 'A':
                    tri.SetAZ();
                    break;
                case 'Z':
                    tri.SetZA();
                    break;
                default:
                    throw new KeyNotFoundException("Choix inconnu");
            }
        }

        /// <summary>
        /// Pour l'option 2 du menu de sélection d'affichage,
        /// demande à l'utilisateur le texte à rechercher
        /// </summary>
        /// <returns>Le texte donné</returns>
        private string DemanderRecherche()
        {
            while (true)
            {
                Console.Write("Indiquez le texte à chercher: ");
                string recherche = Console.ReadLine();
                if (!string.IsNullOrWhiteSpace(recherche))
                {
                    return recherche;
                }
                Console.WriteLine("Ne peut pas être vide ou ne contenir que des espaces\n");
            }
        }

        /// <summary>
        /// Affiche les items contenus dans la liste donné
        /// </summary>
        /// <param name="type">Le type d'items à afficher</param>
        /// <param name="tri">L'ordre dans lequel les items sont affichés</param>
        /// <param name="debut">Le caractère sélectionné comme critère d'affichage</param>
        /// <param name="recherche">Le texte à rechercher sélectionné comme critère d'affichage</param>
        /// <param name="liste">La liste à afficher</param>
        private void AfficherListe(TypeItem type, Tri tri, char debut, string recherche, List<ItemMusical> liste)
        {
            string titre = CreerTitreListe(type, tri, debut, recherche, liste);
            // Si la liste est vide, il n'y a rien à afficher
            if (liste.Count == 0)
            {
                Menu.Menu.AfficherTitre(titre);
                Pause("Aucun item trouvé\n\n");
                return;
            }

            Intervalle intervalle = new Intervalle(liste.Count);
            while (true)
            {
                Menu.Menu.AfficherTitre(titre);

                // Affiche le contenu de la liste dans l'intervalle courrant
                int index = intervalle.Debut;
                while (index < intervalle.Fin)
                {
                    // +1 pour compter à partir de 1 au lieu de 0
                    Console.WriteLine("{0,4}: {1}", index + 1, liste[index].Nom);
                    ++index;
                }
                Console.WriteLine();

                int choix = AfficherMenuListe(intervalle);
                if (choix == -1)
                {
                    // -1 indique que l'utilisateur veut retourner au menu précédent
                    return;
                }

                // Une valeur numérique signifie un choix dans la liste
                if (choix != 0)
                {
                    // -1 car l'affichage débute à 1 au lieu de 0
                    --choix;
                    if (choix < intervalle.Debut || choix >= intervalle.Fin)
                    {
                        throw new IndexOutOfRangeException();
                    }
                    AfficherDetail(type, liste[choix]);
                }
            }
        }

        /// <summary>
        /// Affiche le menu et gère les options lors de l'affichage d'une liste
        /// </summary>
        /// <param name="intervalle">L'intervalle utilisé pour l'affichage de la liste</param>
        /// <returns>Le choix numérique de l'utilisateur, ou -1 pour indiquer la fin de l'affichage</returns>
        private int AfficherMenuListe(Intervalle intervalle)
        {
            // +1 ici aussi car la valeur donnée par l'utilisateur est celle affichée
            // La fin n'est pas incrémentée car elle est déjà une valeur de plus que la dernière affichée
            Menu.Menu menu = new Menu.Liste(intervalle.Debut + 1, intervalle.Fin, intervalle.PrecedentExiste, intervalle.SuivantExiste);
            char choixChar;
            int choix = menu.Afficher(out choixChar);

            if (choix == 0)
            {
                switch (choixChar)
                {
                    case 'P':
                        intervalle.Precedent();
                        break;
                    case 'S':
                        intervalle.Suivant();
                        break;
                    case 'R':
                        return -1;  // Pour indiquer la fin
                    default:
                        throw new KeyNotFoundException("Choix inconnu");
                }
            }

            return choix;
        }

        /// <summary>
        /// Crée le titre pour l'affichage d'une liste
        /// </summary>
        /// <see cref="AfficherListe(TypeItem, Tri, char, string, List{ItemMusical})"/>
        /// <returns>Le titre</returns>
        private string CreerTitreListe(TypeItem type, Tri tri, char debut, string recherche, List<ItemMusical> liste)
        {
            StringBuilder sb = new StringBuilder();
            sb.AppendFormat("{0}s [{1}]", type, tri);
            if (char.IsLetter(debut))
            {
                sb.AppendFormat(" [Débutant par \'{0}\']", debut);
            }
            if (recherche.Length > 0)
            {
                sb.AppendFormat(" [Recherche \"{0}\"]", recherche);
            }
            sb.AppendFormat(" ({0})", liste.Count);
            return sb.ToString();
        }

        /// <summary>
        /// Affiche les détails de l'item donné
        /// </summary>
        /// <param name="type">Le type de l'item</param>
        /// <param name="item">L'item a afficher</param>
        private void AfficherDetail(TypeItem type, ItemMusical item)
        {
            Menu.Menu.AfficherTitre(type.ToString());
            Console.WriteLine(item);
            Pause();
        }


        private const int NbTypesItems = 3;

        private Bibliotheque _bibliotheque;
        private Tri[] _tris = new Tri[NbTypesItems];
    }
}