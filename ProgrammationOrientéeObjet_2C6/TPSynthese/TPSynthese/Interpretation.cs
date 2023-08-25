using System;
using System.Collections.Generic;
using System.Text;

namespace TPSynthese
{
    /// <summary>
    /// La représentation d’une chanson sur un album
    /// </summary>
    class Interpretation : 
        IComparable<Interpretation>
        // En implémentant l'interface IComparable (comparable), il sera possible de trier
    {
        /// <summary>
        /// Constructeur de base qui crée un objet interprétation pour chaque correspondance lu dans les fichiers
        /// </summary>
        /// <param name="ligne">La ligne lut du fichier</param>
        public Interpretation(string ligne)
        {
            string[] champ = ligne.Split(';'); // Sépare la chaîne en un tableau de plusieurs chaînes de caractères

            _nom = champ[1].Trim();
            _duree = Convert.ToInt32(champ[0].Trim());

            for (int i = 3; i < champ.Length; i++) // Selon le nombre de chaîne dans le tableau
            {
                CreerArtistes(_nomArtiste[i]); // Crée un nouvel artiste
            }

            CreerChanson(_nom); // On crée une chanson avec le nom donnée
        }

        /// <summary>
        /// Fonction pour créer un nouvel artiste
        /// </summary>
        /// <param name="nom">L'artiste à créer</param>
        /// <returns>L'artiste qui vient d'être créer, sinon null</returns>
        public void CreerArtistes(string nom)
        {
            foreach (var item in _artistes) // Pour chaque élément de la liste
            {
                if (item.Nom == nom) // Si le nom est déjà présent dasns la liste
                {
                    return; // On fait rien
                }
            }

            _artistes.Add(new Artiste(nom)); // On ajoute un nouvele artiste à la liste avec le nom passé en paramètre
        }

        /// <summary>
        /// Fonction pour créer une nouvelle chanson
        /// </summary>
        /// <param name="nom">La chanson à créer</param>
        /// <returns>La chanson qui vient d'être créer, sinon null</returns>
        public void CreerChanson(string nom)
        {
            foreach (var item in _chansons) // Pour chaque élément de la liste
            {
                if (item.Nom == nom) // Si le nom est déjà présent dasns la liste
                {
                    return; // On fait rien
                }
            }

            _chansons.Add(new Chanson(nom)); // On ajoute un nouvele artiste à la liste avec le nom passé en paramètre
        }

        /// <inheritdoc/>
        public int CompareTo(Interpretation that)
        {
            // On vérifie que l'autre interprétation n'est pas null
            if (that == null)
            {
                // L'objet est plus grands qu'un objet null
                return 1;
            }

            // On veut trier premièrement selon le nom
            int comparaisonInterpretation = _nom.CompareTo(that._nom);

            // Si la comparaison est différente de 0, les noms ne sont pas équivalents
            if (comparaisonInterpretation != 0)
            {
                // On retourne le résultat de la comparaison des noms
                return comparaisonInterpretation;
            }

            // On va trier les interprétation selon leurs durée
            return _duree.CompareTo(that._duree);
        }

        /// <summary>
        /// Accesseurs
        /// </summary>
        public List<ItemMusical> ListeArtistes { get { return _artistes; } }
        public List<ItemMusical> ListeChansons { get { return _chansons; } }

        /// <summary>
        /// Déclaration de variables locale propres à un item musicale
        /// </summary>
        private readonly string _nom; // Variable pour le nom de l'interprétation
        private readonly int _duree; // Attribut pour mettre la durée
        private readonly List<string> _nomArtiste = new List<string>(); // Les noms d'artiste(s) qui contribu(s) à l'interprétation
        private readonly ItemMusical _albums = new ItemMusical(); // Un objet qui est l'album où il y a l'interprétataion
        private List<ItemMusical> _chansons = new List<ItemMusical>(); // Un liste pour représenter les chansons
        private List<ItemMusical> _artistes = new List<ItemMusical>(); // Une liste d'item musicaux (artistes) pour les associées à l'album
    }
}