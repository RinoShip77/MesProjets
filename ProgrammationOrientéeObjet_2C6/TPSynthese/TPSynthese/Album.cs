using System;
using System.Collections.Generic;
using System.Text;

namespace TPSynthese
{
    /// <summary>
    /// Spécialisation d’ItemMusical pour représenter un album lu du fichier. Un objet de ce type est créé pour chaque album lu des fichiers de données
    /// </summary>
    class Album : ItemMusical // Hérite de 'ItemMusical'
    {
        /// <summary>
        /// Constructeur de base qui crée un objet album pour chaque correspondance lu dans les fichiers
        /// </summary>
        /// <param name="ligne">La ligne lut du fichier</param>
        public Album(string ligne) :
            base(ligne) // Donne la chaîne de caractère au constructeur de la classe de base
        {
            string[] champ = ligne.Split(';'); // Sépare la chaîne en un tableau de plusieurs chaînes de caractères

            _nom = Nom; // Utilise le nom de la classe de base
            _annee = Convert.ToInt32(champ[2].Trim()); 
            _genre = champ[3]; 

            for (int i = 4; i < champ.Length; i++) // Selon le nombre de chaîne dans le tableau
            {
                CreerArtiste(_nomArtiste[i]); // Crée un nouvel artiste
            }
        }

        /// <summary>
        /// Fonction pour créer un nouvel artiste
        /// </summary>
        /// <param name="nom">L'artiste à créer</param>
        /// <returns>L'artiste qui vient d'être créer, sinon null</returns>
        public void CreerArtiste(string nom)
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

        /// <inheritdoc/>
        public override string ToString()
        {
            // On prend la méthode de la classe de base
            return base.ToString();
        }

        /// <summary>
        /// Déclaration de variables locale propres à un album
        /// </summary>
        private readonly string _nom; // Variable pour le nom de l'album
        private readonly int _annee; // Attribut pour mettre l'année
        private readonly string _genre; // Une donnée pour garder le genre de l'album
        private readonly List<string> _nomArtiste = new List<string>(); // Les nom d'artiste(s) qui contribu(s) à l'album
        private List<ItemMusical> _artistes = new List<ItemMusical>(); // Une liste d'item musicaux (artistes) pour les associées à l'album
    }
}