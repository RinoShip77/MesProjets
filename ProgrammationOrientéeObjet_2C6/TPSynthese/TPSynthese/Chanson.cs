using System;
using System.Collections.Generic;
using System.Text;

namespace TPSynthese
{
    /// <summary>
    /// Spécialisation d’ItemMusical pour représenter une chanson
    /// </summary>
    class Chanson : ItemMusical // Hérite de 'ItemMusical'
    {
        /// <summary>
        /// Constructeur de base de la classe qui crée une chanson si elle n'existe pas
        /// </summary>
        /// <param name="nom">Le nom de la chanson</param>
        public Chanson(string nom) :
            base()
        {
            _nom = Nom; // Conserve le nom de l'item musical
        }

        /// <inheritdoc/>
        public override string ToString()
        {
            // On prend la méthode de la classe de base
            return base.ToString();
        }

        /// <summary>
        /// Déclaration de variables locale propres à un item musicale
        /// </summary>
        private readonly string _nom; // Attribut pour le nom
    }
}