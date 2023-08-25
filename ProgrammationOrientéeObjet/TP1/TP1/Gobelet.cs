using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace TP1
{
    /// <summary>
    /// La classe Gobelet sert à contenir tous les dés à jouer utilisés dans une partie de Backgammon.
    /// </summary>
    class Gobelet : DeAJouer // Hérite de la classe 'DeAJouer'.
    {
        /// <summary>
        /// Consructeur de la classe 'Gobelet'.
        /// </summary>
        public Gobelet()
        {
            _nbDe = 0; // Il y zéro dé au départ.
                      
            if (de1.Valeur == de2.Valeur) // Si les deux premier dés sont une paire, ...
            {
                _nbDeUtilise += 4; // Le gobelet contient 4 dés. 
            }
            else // Sinon, ...
            {
                _nbDeUtilise += 2; // Le gobelet contient juste 2 dés.
            }
        }

        /// <summary>
        /// Accesseur pour savoir si le dé est vide ou non.
        /// </summary>
        public bool EstVide
        {
            get // Accesseur.
            {
                if (_nbDe == 0) // Si les nombre de dé n'est pas zéro, ...
                {
                    return true; // Est vide.
                }
                else // Sinon, ...
                {
                    return false; // N'est pas vide.
                }
            }
            set { } // Mutateur.
        }

        /// <summary>
        /// La méthode a pour effet de brasser le gobelet et d'ainsi lancer les deux premiers dés.
        /// </summary>
        public void Brasser()
        {
            de1.Valeur += Aleatoire(); // Affecte une valeure aléatoire au dé #1.
            de2.Valeur += Aleatoire(); // Affecte une valeure aléatoire au dé #2.

            if (de1.Valeur != de2.Valeur) // Si la vaeur du dé #1 ne correspond pas à la valeur du dé #2, ...
            {
                de3.EstJouable = false; // Le dé #3 devient injouable.
                de4.EstJouable = false; // Le dé #4 devient injouable.
            }
            else // Sinon, ...
            {
                de3.EstJouable = true; // Le dé devient jouable.
                de4.EstJouable = true; // Le dé devient jouable.
            }
        }

        /// <summary>
        /// La méthode BrasserSansPaire brasse les dés en s’assurant qu’une paire n’est pas générée.
        /// </summary>
        public void BrasserSansPaire()
        {
            while (de1.Valeur != de2.Valeur) // Tant que la valeur des deux dés n'est équivalente.
            {
                de1.Valeur += Aleatoire(); // Affecte une valeure aléatoire au dé #1.
                de2.Valeur += Aleatoire(); // Affecte une valeure aléatoire au dé #2.
            }
        }

        /// <summary>
        /// Permet d'accéder à chaque dé du gobelet.
        /// </summary>
        /// <param name="nombreDe">L'index du dé voulue.</param>
        public DeAJouer De(int nombreDe)
        {
            switch(nombreDe) // Selon l'index du dé entré en paramètres, ...
            {
                case 0: // Pour 0, ...
                    return de1; // On retourne le premier dé.
                case 1: // Pour 1, ...
                    return de2; // On retourne le deuxième dé.
                case 2: // Pour 2, ...
                    return de3; // On retourne le troisième dé.
                case 3: // Pour 3, ...
                    return de4; // On retourne le quatrième dé.
                default: // Par défaut, ...
                    return null; // On retourne la valeur 'null'.
            }
        }

        /// <summary>
        /// Indique si un dé qui porte la valeur donnée est présent dans le gobelet et est qualifié comme étant jouable.
        /// </summary>
        /// <param name="nombre">La valeur du dé.</param>
        /// <returns>Vrai si le dé portant la valeur donnée est présent et jouable, sinon faux.</returns>
        public bool EstValide(int nombre)
        {
            DeAJouer de = new DeAJouer(); // On crée un dé temporaire.
            de.Valeur = nombre; // On affecte le nombre en paramètres dans le dé temporaire.

            if (de.Valeur == 0 && de.EstJouable) // Si le dé temporaire n'a pas encore été joué et encore jouable, ... 
            {
                return true; // Le dé est valide.
            }
            else // Sinon, ...
            {
                return false; // Le dé n'est pas valide.
            }
        } 

        /// <summary>
        /// Donne au dé portant la valeur donnée le statut non jouable.
        /// </summary>
        /// <param name="numero">La valeur du dé.</param>
        public void Jouer(int numero)
        { 
            if (de1.Valeur == numero || de2.Valeur == numero || de3.Valeur == numero || de4.Valeur == numero) // Si la valeur des dés présents dans le gobelet correcpond à la valeur passée en paramètre, ...
            {
                de1.EstJouable = false; // Le dé est injouable.
            }
            else
            {
                de1.EstJouable = true; // Le dé est jouable.
            }
        }

        private int _nbDe; // C'est le nombre de dé dans le gobelet.
        private int _nbDeUtilise; // Représente le nombre de dés utilisés.
        private DeAJouer de1 = new DeAJouer(); // Le 1er dé du gobelet.
        private DeAJouer de2 = new DeAJouer(); // Le 2ième dé du gobelet.
        private DeAJouer de3 = new DeAJouer(); // Le 3ième dé du gobelet.
        private DeAJouer de4 = new DeAJouer(); // Le 4ième dé du gobelet.
    }
}
