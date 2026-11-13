using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace TP1
{
    /// <summary>
    /// La classe Pion représente un pion dans un jeu de Backgammon.
    /// </summary>
    class Pion
    {
        /// <summary>
        /// Constructeur avec paramètres de la classe 'Pion'.
        /// </summary>
        /// <param name="couleur">Va indiquer la couleur du pion à créer.</param>
        public Pion(CouleurPion couleur)
        {
            switch (couleur) // On réagit en fonction de la couleur qui va être donnée.
            {
                case CouleurPion.Blanc: // Soit le pion est blanc.
                    _couleurPion = CouleurPion.Blanc; // Donc sa couleur est blanche.
                    break; // On sort de la situation.
                case CouleurPion.Rouge: // Soit il est rouge.
                    _couleurPion = CouleurPion.Rouge; // Donc sa couleur est rouge.
                    break; // On sort du bloc.
            }
        }

        /// <summary>
        ///  La méthode 'EstDeMemeCouleurQue' indique si 2 pions possèdent la même couleur ou non.
        /// </summary>
        /// <returns>Vrai si c'est la même couleur, sinon faux.</returns>
        public bool EstDeMemeCouleurQue(Pion autrePion)
        {
            return _couleurPion == autrePion._couleurPion; // Renvoi la comparaison entre les deux couleurs.
        }

        private readonly CouleurPion _couleurPion; // N'est pas modifiable après la construction.
    }
}