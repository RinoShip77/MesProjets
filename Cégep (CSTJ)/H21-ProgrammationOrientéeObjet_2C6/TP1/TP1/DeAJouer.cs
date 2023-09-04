using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace TP1
{
    /// <summary>
    /// La classe DeAJouer représente un dé à jouer à 6 faces, avec les valeurs de 1 à 6.
    /// </summary>
    class DeAJouer
    {
        /// <summary>
        /// Constructeur de la classe 'DeAJouer'.
        /// </summary>
        public DeAJouer()
        {
            _valeur = 0;
            EstJouable = false; // N'est pas jouable au début.
        }

        /// <summary>
        /// Accesseur pour la valeur du dé.
        /// Récupère la valeur de l'attribut privé.
        /// </summary>
        public int Valeur { get { return _valeur; } set { } } // Accesseur pour la valeur du dé.

        /// <summary>
        /// Accesseur pour savoir si le dé est jouable ou non.
        /// </summary>
        public bool EstJouable
        {
            get // Accesseur booléen.
            {
                if (_valeur == 0) // Si il n'a pas encore été lancé, ...
                {
                    return false; // N'est pas jouable.
                }
                else // Sinon, ...
                {
                    if (_valeur >= 1) // S'il a été relancé, ...
                    {
                        Lancer();
                        return true; // Est jouable.
                    }
                    return true; // Est jouable.
                }
            }
            set { } // Mutateur de la propriété.
        }

        /// <summary>
        /// Retourne un chiffre aléatoire pour la valeur actuelle du dé.
        /// </summary>
        /// <returns>La valeur du dé.</returns>
        public int Lancer()
        {
            return _valeur += Aleatoire(); // Affecte la génération aléatoire à la valeur.
        }

        /// <summary>
        /// Indique si le dé a été joué ou non.
        /// </summary>
        /// <returns>Vrai si il a été joué, sinon faux.</returns>
        public bool Jouer()
        {
            if (_valeur > 1) // S'il a été lancé au moins une fois, ...
            {
                return false; // N'as pas été joué.
            }
            else // Sinon, ...
            {
                return true; // As été joué et doit être relancé.
            }
        }

        /// <summary>
        /// Duplique ou fait une copie d'un dé existant et en crée un nouveau avec les même paramètres.
        /// </summary>
        /// <param name="_autreDe">C'est où on vas mettre les informations de l'ancien dé.</param>
        /// <returns>La copie des vielles informations dans un nouveau dé.</returns>
        public DeAJouer Dupliquer(DeAJouer _autreDe)
        {
            DeAJouer de = new DeAJouer(); // Création d'un dé.
            _autreDe._valeur = de.Valeur; // Même valeur.
            _autreDe.EstJouable = de.EstJouable; // Même statut.
            return de; // Retourne le nouveaux dé.
        }

        /// <summary>
        /// Génère un chiffre aléatoire entre 1 et 6.
        /// </summary>
        /// <returns>La valeur aléatoire.</returns>
        public int Aleatoire()
        {
            int valeur = 0; // Variable locale pour mettre le résultat de la génération aléatoire.
            Random valeurAleatoire = new Random(); // S'initialise en se basant sur le temps d'exécution.
            valeur = valeurAleatoire.Next(1, 7); // Va générer un nombre entre 1 et 6.
            return valeur; // Retourne la valeur aléatoire.
        }

        private int _valeur; // Représente la valeur du dé.
    }
}
