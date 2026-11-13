using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace TP1
{
    /// <summary>
    /// La classe Joueur représente un joueur de Backgammon.
    /// </summary>
    class Joueur
    {
        /// <summary>
        /// Constructeur avec paramètres de la classe 'Joueur'.
        /// </summary>
        /// <param name="couleur">Va indiquer la couleur des pions du joueur à créer.</param>
        public Joueur(CouleurPion couleur)
        {
            switch (couleur) // On réagit en fonction du choix de l'utilisateur.
            {
                case CouleurPion.Blanc: // Soit il est blanc.
                    _couleurPion = CouleurPion.Blanc; // Sa couleur devient blanche.
                    break; // On sort  de cette option.
                case CouleurPion.Rouge: // Soit il est rouge.
                    _couleurPion = CouleurPion.Rouge; // Sa couleur devient rouge.
                    break; // On sort.
            }


            Console.Write("Indiquez le nom du joueur " + _couleurPion + " : "); // Affiche la chaîne sur la console.
            _nom = Console.ReadLine(); // Récupère le nom inscrit dans la console.
            _nom = _nom.Trim(); // Supprime les espaces en trop de début et de fin.

            while (_nom == "") // On redemande le nom jusqu'a ce qu'on aille un nom pas vide.
            {
                Console.WriteLine("Nom invalide"); // Le nom est erroné.
            }
        }

        /// <summary>
        /// Accesseur pour la couleur du pion du joueur.
        /// Récupère la valeur de l'attribut privé.
        /// </summary>
        public CouleurPion Couleur { get { return _couleurPion; } } // Accesseur pour la couleur du pion.

        /// <summary>
        /// Accesseur pour le nom du joueur.
        /// Récupère la valeur de l'attribut privé.
        /// </summary>
        public string Nom { get { return _nom; } } // Acceseur pour le nom du joueur.

        /// <summary>
        /// Accesseur pour le nombre de points.
        /// Récupère la valeur de l'attribut privé.
        /// </summary>
        public int Points { get { return _points; } } // Accesseur pour le nombre de points du joueur.

        /// <summary>
        /// Ajoute des points à la somme du joueur.
        /// </summary>
        /// <param name="ajout">Le nombre de points à ajouter.</param>
        /// <returns>Le total de points après l'ajout.</returns>
        public int AjouterPoints(int ajout)
        {
            _points += ajout; // Ajoute au total des points.
            return _points; // Retourne le nombre de points après l'opération.
        }

        /// <summary>
        /// Enlève des points au total du joueur.
        /// </summary>
        /// <param name="retrait">Le nombre de points à enlever.</param>
        /// <returns>Le nombre de points après la modification.</returns>
        public int EnleverPoints(int retrait)
        {
            if (retrait <= _points) // Si le résultat sera négatif, ...
            {
                _points -= retrait; // Retire au total.
                return _points; // Retourne le total après les manipulations.
            }
            else // Sinon, ...
            {
                return _points; // On ne change rien.
            }
        }

        /// <summary>
        /// Indique si le joueur est victorieux.
        /// </summary>
        /// <returns>Vrai si le joueur est gagnant, sinon faux.</returns>
        public bool EstGagnant()
        {
            if (_points == 0) // Si le nombre de points est à 0, ...
            {
                return true; // Il est gagnant.
            }
            else // Sinon, ...
            {
                return false; // Il n'est pas gagnant.
            }
        }

        private readonly CouleurPion _couleurPion; // N'est pas modifiable après la construction.
        private readonly string _nom; // N'est pas modifiable après la création de l'objet.
        private int _points = 167; // Est modifiable que dans 'AjouterPoints' et 'EnleverPoints'.
    }
}