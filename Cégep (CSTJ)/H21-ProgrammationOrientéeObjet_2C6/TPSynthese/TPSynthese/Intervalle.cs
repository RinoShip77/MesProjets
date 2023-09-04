using System;
using System.Collections.Generic;
using System.Text;

namespace TPSynthese
{
    /// <summary>
    /// Classe qui définit un intervalle dans une liste de recherche et qui permet de naviguer de
    /// page en page pour afficher le contenu de la liste
    /// </summary>
    class Intervalle
    {
        /// <summary>
        /// Constructeur
        /// </summary>
        /// <param name="taille">La taille de la liste</param>
        public Intervalle(int taille)
        {
            _taille = taille;
            // Plus petite valeur entre le nombre max par page, ou la taille de la liste
            _fin = Math.Min(NbItemsParPage, _taille);
        }

        /// <summary>
        /// Le premier index de la page courrante
        /// </summary>
        public int Debut { get { return _debut; } }
        /// <summary>
        /// Un de plus que le dernier index de la page courrante
        /// </summary>
        public int Fin { get { return _fin; } }

        /// <summary>
        /// Indique s'il y a une page précédente ou une page suivante
        /// </summary>
        public bool PrecedentExiste { get { return _debut > 0; } }
        public bool SuivantExiste { get { return _fin < _taille; } }

        /// <summary>
        /// Permet de naviguer à la page précédente
        /// </summary>
        public void Precedent()
        {
            if (!PrecedentExiste)
            {
                throw new InvalidOperationException("Pas de page précédente");
            }
            _fin = _debut;
            _debut -= NbItemsParPage;
        }

        /// <summary>
        /// Permet de naviguer à la page suivante
        /// </summary>
        public void Suivant()
        {
            if (!SuivantExiste)
            {
                throw new InvalidOperationException("Pas de page suivante");
            }
            _debut = _fin;
            // On s'assure de ne pas dépasser la fin de la liste
            _fin = Math.Min(_fin + NbItemsParPage, _taille);
        }


        // Taille de la page
        private const int NbItemsParPage = 20;

        private readonly int _taille;
        private int _debut = 0;
        private int _fin;
    }
}
