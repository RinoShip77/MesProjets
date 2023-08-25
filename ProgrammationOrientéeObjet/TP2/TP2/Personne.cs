using System;
using System.Collections.Generic;
using System.Text;
using System.IO;

namespace TP2
{
    /// <summary>
    /// Définition de la classe personne
    /// </summary>
    class Personne
    {
        /// <summary>
        /// Définition du constructeur de base de la classe Personne
        /// </summary>
        public Personne()
        {
            try
            {
                _prenom = "";
                while (_prenom.Length == 0) // On redemande le prenom tant qu'il est vide
                {
                    Console.Write("Prénom : "); // On demande le prénom à l'utilisateur
                    _prenom = Console.ReadLine().Trim(); // pour ensuite le garder dans l'attribut

                    if (_prenom.Length == 0) // Si il est vide, on affiche l'erreur et on recommence
                    {
                        Console.WriteLine("Ne doit pas être vide");
                    }
                }

                _nom = "";
                while (_nom.Length == 0) // On redemande le nom tant qu'il est vide
                {
                    Console.Write("Nom : "); // On demande le prénom à l'utilisateur
                    _nom = Console.ReadLine().Trim(); // pour ensuite le garder dans l'attribut

                    if (_nom.Length == 0) // Si il est vide, on affiche l'erreur et on recommence
                    {
                        Console.WriteLine("Ne doit pas être vide");
                    }
                }
            }
            catch (Exception)
            {

            }
        }

        protected string _prenom; // Attribut d'une Personne
        protected string _nom; // Attribut d'une Personne
    }
}