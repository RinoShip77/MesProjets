using System;
using System.Collections.Generic;
using System.Text;
using System.IO;

namespace TP2
{
    /// <summary>
    /// Définition de la classe Médecin qui est une spécifitée de la classe Personne 
    /// </summary>
    class Medecin : Personne
    {
        /// <summary>
        /// Déclaration du constructeur par défaut d'un médecin qui hérite d'une personne
        /// </summary>
        public Medecin() :
            base()
        {
            _nbPatients = 0; // Un médecin débute sans aucun patient relié à lui
            _activite = 0; // Le médecin n'est pas initialement à la retraite
            _dateRetraite = new DateTime(); // Donc pas de date de retraite

            while (true) // Boucle infinie
            {
                try // Bloc try pour tester le code et prévenir les erreurs
                {
                    Console.Write("Code d'identification : "); // On demande le numéro d'assurance maladie à l'utilisateur 
                    _codeID = Convert.ToInt32(Console.ReadLine()); // pour ensuite le garder en mémoire dans une variable

                    if (_codeID <= 100 || _codeID >= 999) // Si la valeur entrée est plus petite ou égale à 100 OU plus grande ou égale à 999, ...
                    {
                        throw new ArgumentException("Valeur incorrect, doit être un entier entre 100 et 999"); // On lance une exception avec un message d'erreur
                    }
                    break; // On force la sortie de la boucle
                }
                catch (Exception e)
                {
                    Console.WriteLine(e.Message); // // On attrape et on affiche le message de ou des exceptions qui sont survenues durant le bloc try
                }
            }
        }

        /// <summary>
        /// Déclaration et définition d'un constructeur paramètré pour créer un médecin avec les informations d'une chaîne de caractères
        /// </summary>
        /// <param name="ligne">La chaîne de caractères qui contient les informations d'un patient</param>
        public Medecin(string ligne)
        {
            try // Un bloc try pour simplement essayer le code
            {
                string[] champ = ligne.Split(';'); // On prend chaque champ (séparé par un point virgule) de la chaîne et on le met dans un tableau de string

                int codeID = Convert.ToInt32(champ[0]); // On convertit en entier le premier champ dans la ligne et on le place dans une variable
                prenom = champ[1]; // On prend le deuxième champ dans la ligne et on le place dans une variable
                nom = champ[2]; // On prend le troisième champ dans la ligne et on le place dans une variable

                if (champ[3].Length != 0) // Si le quatrième champ de la chaîne n'est pas vide, ...
                {
                    _dateRetraite = Convert.ToDateTime(champ[3]); // On convertit en une date ce champ et on le garde dans une variable
                    _activite = 1; // Si une date de décès est définie, on met le patient comme décédé
                }
            }
            catch (Exception)
            {
                // On ne fais rien dans le bloc catch, car on veut que le programme fonctionne normalement
            }
        }

        // Définition des accesseurs en lecture seul 
        public string Prenom { get; }
        public string Nom { get; }
        public int CodeID { get; }
        public List<Patient> ListePatients { get; }

        // Définition des mutateurs pour modifier à l'extérieur de la classe
        public DateTime DateRetraite { get; set; }
        public int NbPatients { get; set; }
        public int Activite { get; set; }

        // Déclarations des attributs qui constituent un patient
        private readonly int _codeID;
        private readonly string prenom;
        private readonly string nom;
        private DateTime _dateRetraite;
        private int _nbPatients;
        private int _activite;
        private List<Patient> _listePatients = new List<Patient>();
    }
}