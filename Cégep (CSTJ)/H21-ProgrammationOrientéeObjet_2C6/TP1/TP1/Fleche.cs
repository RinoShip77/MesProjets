using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace TP1
{
    /// <summary>
    /// La classe Flèche représente une flèche sur un plateau de Backgammon.
    /// </summary>
    class Fleche
    {
        /// <summary>
        /// Constructeur de Fleche.
        /// </summary>
        public Fleche()
        {
            _nbPion = 0; // Il n'y a pas de pion sur la flêche au départ.
            EstVide = true; // Donc, la flêche est vide.
        }

        /// <summary>
        /// Accesseur pour obtenir le nombre de pions.
        /// </summary>
        public int NbPions { get { return _nbPion; } } // Accesseurs pour le nombre de pions.

        /// <summary>
        /// Indique si la flêche est vide.
        /// </summary>
        public bool EstVide 
        {
            get // Accesseur pour le statut.
            {
                if (_nbPion == 0) // Si la flêche ne contient aucun pion, ...
                {
                    return true; // La flêche est vide.
                }
                else // Sinon, ...
                {
                    return false; // La flêche n'est pas vide.
                }
            }
            set { } // Mutateur pour le statut.
        }

        /// <summary>
        /// Permet d'ajouter un pion.
        /// </summary>
        /// <param name="pion">Le pion a ajouter.</param>
        public void Ajouter(Pion pion)
        {
            if (_nbPion <= 14) // Si il y a 14 pions ou moins, ... 
            {
                _nbPions[_nbPion] = pion; // On affecte la valeur du pion à la prochaine place dans le tableau.
                _nbPion++; // On ajoute un pion au total.
            }
        }

        /// <summary>
        /// Permet de retirer un pion.
        /// </summary>
        /// <param name="pion">Le pion a retirer.</param>
        public Pion Retirer()
        {
            if (_nbPion >= 0) // Si le nombre de pions est plus grand ou égale à zéro, ...
            {
                Array.Clear(_nbPions, _nbPion, 1); // On efface les données à cette endroit.
                _nbPion--; // On retire un pion du total.
                
                Pion pion = _nbPions[_nbPion]; // On sélectionne le dernier pion du tableau.
                return pion; // On renvoi celui-ci.
            }
            else // Sinon, ...
            {
                return null; // On retourne la valeur 'null'.
            }
        }

        /// <summary>
        /// Retourne une référence sur le dernier pion ajouté.
        /// </summary>
        public ref Pion DernierPion()
        {
            ref Pion dernierPion = ref _nbPions[_nbPion]; // On déclare une référence sur le dernier élément du tableau.
            return ref dernierPion; // On le retourne.
        }

        /// <summary>
        /// Indique si un pion peut être retirer de la flêche.
        /// </summary>
        /// <param name="pion">Le pion à vérifier.</param>
        /// <returns>Vrai si il y a au moin un pion sur la flêche et que ceux-ci soient de la couleur du pion donnée, sinon faux.</returns>
        public bool PeutRetirer(Pion pion)
        {
            if (_nbPion >= 0 && _nbPions.Contains(pion)) // Si la flêche ne contient qu'un seul pionvide et que les pion soit de la même couleur que celui passé en paramètres, ...
            {
                return true; // Le pion peut être retiré.
            }
            else // Sinon, ...
            {
                return false; // Le pion ne peut pas être retiré.
            }
        }

        /// <summary>
        /// Indique si un pion peut être ajouter.
        /// </summary>
        /// <param name="pion">Le pion à utiliser</param>
        /// <returns>Vrai si la flêche est vide ou ne contient qu'un seul pion ou que la flêche contient plus d'un pion ce la même couleur que celle donnée, sinon faux.</returns>
        public bool PeutAjouter(Pion pion)
        {
            if (_nbPion <= 1 || _nbPions.Contains(pion)) // Si il n'y a aucun pion sur la flêche ou qu'elle ne contienne qu'un seul pion OU que celle-ci a plus d'un pion de la même couleur que le pion donné, ...
            {
                return true; // Un pion peut être ajouté.
            }
            else // Sinon, ...
            {
                return false; // On ne peut pas ajouter de pion.
            }
        }

        /// <summary>
        /// Indique si l'ajout d'un pion à la flêche constitue une frappe.
        /// </summary>
        /// <param name="pion">Le pion pour l'évaluation.</param>
        /// <returns>Vrai si la flêche contient un seul pion de la couleur inverse que celle donnée, sinon faux.</returns>
        public bool EstUneFrappe(Pion pion)
        {
            if (_nbPions.Contains(pion)) // Si la flèche ne contient qu'un seul pion de la couleur opposée de celle du pion donné, ...
            {
                return true; // C'est une frappe.
            }
            else
            {
                return false; // Ce n'est pas une frappe.
            }
        }

        private Pion[] _nbPions = new Pion[15]; // Représente le nombre de pion de la flêche sous forme de tableau.
        private int _nbPion = 0; // Un entier qui représente le nombre de pions.
    }
}
