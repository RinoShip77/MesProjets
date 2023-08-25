// ------------------------------------------------
// Projet:   Gestionnaire
// Cours:    420-4C4-JR
// Fichier:  Categorie.cs
// Auteur:   Olivier Bourgault
// Date:     2022-04-15
// ------------------------------------------------

using System.Collections.Generic;

//MODIFICATION POUR LA QUESTION 1
using System.Collections.ObjectModel;  //Pour pouvoir utiliser les collection observables

//MODIFICATION POUR LA QUESTION 1
using Newtonsoft.Json;  //Pour pouvoir interagir avec le fichier JSON

//MODIFICATION POUR LA QUESTION 1
using System.IO;  //Pour pouvoir lire et écrire avec le fichier JSON

namespace Gestionnaire
{
    public class Categorie
    {
        #region Static

        private static List<Categorie> ListeDeCategories = new List<Categorie>();

        //MODIFICATION
        /// <summary>
        /// Fait la lecture du fichier de données et met à jour la liste de catégories.
        /// </summary>
        public static void LirefCategories()
        {
            StreamReader fichierCategories; //Déclaration d'un objet pour un fichier JSON
            string json; //Déclare une chaîne de caractères pour contenir la ligne du fichier

            fichierCategories = new StreamReader(File.OpenRead("fCategories.json")); //Ouvre le fichier de données
            json = fichierCategories.ReadLine(); //Lit la ligne du fichier

            fichierCategories.Close(); //Ferme le fichier

            PrincipalManager._categories = JsonConvert.DeserializeObject<ObservableCollection<Categorie>>(json); //Met à jour la collection observable
        }

        //MODIFICATION
        /// <summary>
        /// Enregistre la liste de categories dans le fichier de données.
        /// </summary>
        public static void ReecrirefCategories()
        {
            string json = JsonConvert.SerializeObject(PrincipalManager._categories); //Met le contenu de la collection observable dans une chaîne de caractères
            System.IO.File.WriteAllText("fCategories.json", json); //Ecrit la chaîne de caractères dans la fichier de données
        }

        /// <summary>
        /// Permet d'obtenir la liste de catégories. 
        /// </summary>
        /// <returns>Une liste de catégories.</returns>
        public static List<Categorie> ObtenirListe()
        {
            return ListeDeCategories;
        }

        /// <summary>
        /// Permet d'indiquer si une catégorie fait partie de la liste des catégories en mémoire.
        /// </summary>
        /// <param name="categorieVisee">La catégorie à vérifier.</param>
        /// <returns>True si la catégorie se trouve dans la liste, false sinon.</returns>
        public static bool EstValide(string categorieVisee)
        {
            bool estValide = false;
            int i = 0;

            while (!estValide && i < ListeDeCategories.Count)
            {
                if (ListeDeCategories[i].Nom == categorieVisee)
                {
                    estValide = true;
                }

                i++;
            }

            return estValide;
        }

        #endregion

        public string Nom { get; set; }

        //MODIFICATION
        public int NbrUtilisation { get; set; }  //Ajout de la méthode pour avoir le nombre d'utilisation

        /// <summary>
        /// Constructeur de la classe CategorieJeu.
        /// </summary>
        /// <param name="nom">Le nom de la catégorie.</param>
        public Categorie(string nom)
        {
            Nom = nom;

            //MODIFICATION
            foreach (Jeu jeu in PrincipalManager._jeux)  //On parcours la liste de jeux
            {
                foreach (Categorie categorie in jeu.LstCategories)  //On parcours la liste de catégories de ce jeu
                {
                    if(nom == categorie.Nom)  //Si le nom passé en paramètre est égale au nom de la catégorie, ...
                    {
                        NbrUtilisation++;  //On incrémente le nombre d'utilisation de la catégorie
                    }
                }
            }
        }
    }
}
