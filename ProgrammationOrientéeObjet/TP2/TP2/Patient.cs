using System;
using System.Collections.Generic;
using System.Text;
using System.IO;

namespace TP2
{
    /// <summary>
    /// Définition de la classe Patient qui est une spécifitée de la classe Personne 
    /// </summary>
    class Patient : Personne
    {
        /// <summary>
        /// Déclaration du constructeur par défaut d'un patient qui hérite d'une personne
        /// </summary>
        public Patient() :
            base()
        {
            _statut = 1; // Le patient est initialement vivant
            _dateDeces = new DateTime(); // Donc il n'y pas de date de décès

            while (true) // Tant que la condition est vrai
            {
                try // Un bloc try pour simplement essayer le code
                {
                    Console.Write("Numéro d'assurance maladie : "); // On demande le numéro d'assurance maladie à l'utilisateur 
                    _numMaladie = Convert.ToInt32(Console.ReadLine()); // pour ensuite le garder en mémoire dans une variable

                    if (_numMaladie <= 1000 || _numMaladie >= 9999) // Si la valeur entrée est plus petite ou égale à 1000 OU plus grande ou égale à 9999, ...
                    {
                        throw new Exception("Valeur incorrect, doit être un entier entre 100 et 999"); // On lance une exception avec un message d'erreur
                    }
                    break; // On force la sortie de la boucle
                }
                catch (Exception e)
                {
                    Console.WriteLine(e.Message); // On attrape et on affiche le message de ou des exceptions qui sont survenues durant le bloc try
                }
            }
        }

        /// <summary>
        /// Déclaration et définition d'un constructeur paramètré pour créer un patient avec les informations d'une chaîne de caractères
        /// </summary>
        /// <param name="ligne">La chaîne de caractères qui contient les informations d'un patient</param>
        public Patient(string ligne)
        {
            try // Un bloc try pour simplement essayer le code
            {
                string[] champ = ligne.Split(';'); // On prend chaque champ (séparé par un point virgule) de la chaîne et on le met dans un tableau de string

                int numMaladie = Convert.ToInt32(champ[0]); // On convertit en entier le premier champ dans la ligne et on le place dans une variable
                prenom = champ[1]; // On prend le deuxième champ dans la ligne et on le place dans une variable
                nom = champ[2]; // On prend le troisième champ dans la ligne et on le place dans une variable

                if (champ[3].Length != 0) // Si le quatrième champ de la chaîne n'est pas vide, ...
                {
                    _dateDeces = Convert.ToDateTime(champ[3]); // On convertit en une date ce champ et on le garde dans une variable
                    _statut = 0; // Si une date de décès est définie, on met le patient comme décédé
                }
                else
                { 
                    _codeIDMedecin = Convert.ToInt32(champ[4]); // S'il n'y a pas de date de décès, un champ de plus est ajouté et son contenu est mis dans une variable 
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
        public int NumeroAssuranceMaladie { get; }

        // Définition des mutateur pour modifier à l'extérieur de la classe 
        public int CodeIDMedecin { get; }
        public DateTime DateDeces { get; set; }
        public int Statut { get; set; }
        public Medecin Medecin { get; set; }

        // Déclaration des attributs qui constituent un patient
        private readonly int _numMaladie;
        private readonly string prenom;
        private readonly string nom;
        private int _codeIDMedecin;
        private DateTime _dateDeces;
        private int _statut;
        private Medecin _medecin;
        private GestionnairePatients _gestionPatient;
    }
}