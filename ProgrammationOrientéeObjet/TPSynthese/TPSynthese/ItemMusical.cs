using System;
using System.Collections.Generic;
using System.Text;

/// <summary>
/// Une énumération qui définit les trois types d’items manipulés par le programme :
/// - Album
/// - Artiste
/// - Chanson
/// </summary>
enum TypeItem
{
    Album,
    Artiste,
    Chanson
}

namespace TPSynthese
{
    /// <summary>
    /// Classe de base pour tous les types d’items manipulés par le programme :
    /// - Album
    /// - Artiste
    /// - Chanson
    /// </summary>
    class ItemMusical :
        IEquatable<ItemMusical>,
        // En implémentant l'interface IEquatable (égalable), il sera possible de vérifier l'équivalence de 2 objets
        IComparable<ItemMusical>
        // En implémentant l'interface IComparable (comparable), il sera possible de trier
    {
        /// <summary>
        /// Constructeur de base de la classe
        /// </summary>
        public ItemMusical()
        {
        }

        /// <summary>
        /// Constructeur paramètré de la classe
        /// </summary>
        /// <param name="ligne">La ligne du fichier de données</param>
        public ItemMusical(string ligne)
        {
            string[] champ = ligne.Split(';'); // Transfère la chpîne en tableau en la séparant avec un ';'

            _nom = champ[1]; // On prend le premier élément du tableau pour le nom
        }

        /// <inheritdoc/>
        public override string ToString()
        {
            return string.Format("  {0}", // On met en forme l'affichage
                _nom);
        }

        /// <inheritdoc/>
        public bool Equals(ItemMusical that)
        {
            // Pour être équivalent, 2 item musicaux doivent avoir le même nom
            return that != null && _nom == that._nom;
        }

        /// <inheritdoc/>
        public int CompareTo(ItemMusical that)
        {
            // On vérifie que l'autre item n'est pas null
            if (that == null)
            {
                // L'objet est plus grands qu'un objet null
                return 1;
            }

            // On veut trier premièrement selon le nom
            int comparaisonItemMusical = _nom.CompareTo(that._nom);

            // Si la comparaison est différente de 0, les noms ne sont pas équivalents
            if (comparaisonItemMusical != 0)
            {
                // On retourne le résultat de la comparaison des noms
                return comparaisonItemMusical;
            }

            // On retourne que l'objet courant est plus petit que celui en paramètre
            return -1;
        }

        /// <summary>
        /// Fonction pour accéder à l'information de l'extérieur
        /// </summary>
        public string Nom { get { return _nom; } } // Accesseurs pour le nom
        public List<Interpretation> ListeInterpretation { get { return _listeInterpretations; } } // Accesseur pour la liste

        /// <summary>
        /// Déclaration de variables locale propres à un item musicale
        /// </summary>
        private readonly string _nom; // Variable pour le nom de l'item
        private readonly List<Interpretation> _listeInterpretations = new List<Interpretation>(); // Une liste d'interprétetions
    }
}