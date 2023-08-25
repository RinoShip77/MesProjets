// ------------------------------------------------
// Projet:   Gestionnaire
// Cours:    420-4C4-JR
// Fichier:  Jeu.cs
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
    /// <summary>
    /// Classe qui représente un jeu de société.
    /// Les données initiales proviennent de https://boardgamegeek.com
    /// </summary>
    public class Jeu
    {
        public string Nom { get; set; }

        public int Annee { get; set; }

        public string Concepteur { get; set; }

        public int MinJoueurs { get; set; }

        public int MaxJoueurs { get; set; }

        public int MinAge { get; set; }

        public int MaxAge { get; set; } // On met un maximum de 99 ans quand il n'y a pas réellement de limite.

        public int DureeMin { get; set; }

        public int DureeMax { get; set; }

        public List<Categorie> LstCategories { get; set; }

        //MODIFICATION
        /// <summary>
        /// Fait la lecture du fichier de données et met à jour liste de jeux.
        /// </summary>
        public static void LirefJeux()
        {
            StreamReader fichierJeux; //Déclaration d'un objet pour un fichier JSON
            string json; //Déclare une chaîne de caractères pour contenir la ligne du fichier

            fichierJeux = new StreamReader(File.OpenRead("fJeux.json")); //Ouvre le fichier de données
            json = fichierJeux.ReadLine(); //Lit la ligne du fichier

            fichierJeux.Close(); //Ferme le fichier

            PrincipalManager._jeux = JsonConvert.DeserializeObject<ObservableCollection<Jeu>>(json); //Met à jour la collection observable
        }

        //MODIFICATION
        /// <summary>
        /// Creation d'un constructeur sans paramètres.
        /// </summary>
        public Jeu() { } //Implémentation du constructeur par défaut de la classe.

        //MODIFICATION
        /// <summary>
        /// Enregistre la liste de jeux reçue dans le fichier de données.
        /// </summary>
        public static void ReecrirefJeux()
        {
            string json = JsonConvert.SerializeObject(PrincipalManager._jeux); //Met le contenu de la collection observable dans une chaîne de caractères
            System.IO.File.WriteAllText("fJeux.json", json); //Ecrit la chaîne de caractères dans la fichier de données
        }

        /// <summary>
        /// Contructeur de la classe JeuSociete
        /// </summary>
        /// <param name="nom">Le nom du jeu.</param>
        /// <param name="annee">L'année de parution du jeu</param>
        /// <param name="concepteur">Nom du concepteur du jeu</param>
        /// <param name="minJoueurs">Le nombre minimal de joueurs.</param>
        /// <param name="maxJoueurs">Le nombre maximal de joueurs.</param>
        /// <param name="minAge">Le minimum d'âge requis pour jouer.</param>
        /// <param name="maxAge">Le maximum d'âge recommandé pour jouer.</param>
        /// <param name="dureeMin">La durée minimale d'une partie du jeu.</param>
        /// <param name="dureeMin">La durée maximale d'une partie du jeu.</param>
        /// <remarks>
        /// La Gestionnaire des catégories d'un jeu se fait par les méthodes de la classe.
        /// </remarks>
        public Jeu(string nom, int annee, string concepteur, int minJoueurs, int maxJoueurs, int minAge, int maxAge, int dureeMin, int dureeMax, List<Categorie> lstCat)
        {
            Nom = nom;
            Annee = annee;
            Concepteur = concepteur;
            MinJoueurs = minJoueurs;
            MaxJoueurs = maxJoueurs;
            MinAge = minAge;
            MaxAge = maxAge;
            DureeMin = dureeMin;
            DureeMax = dureeMax;

            LstCategories = lstCat;
        }

        public Jeu(string nom, int annee, string concepteur, int minJoueurs, int maxJoueurs, int minAge, int maxAge, int dureeMin, int dureeMax)
        {
            Nom = nom;
            Annee = annee;
            Concepteur = concepteur;
            MinJoueurs = minJoueurs;
            MaxJoueurs = maxJoueurs;
            MinAge = minAge;
            MaxAge = maxAge;
            DureeMin = dureeMin;
            DureeMax = DureeMax;

            LstCategories = new List<Categorie>();
        }

        /// <summary>
        /// Permet d'ajouter une catégorie au jeu (si cette catégorie est valide).
        /// </summary>
        /// <param name="nouvelleCategorie">La nouvelle catégorie.</param>
        public void AjouterCategorie(Categorie nouvelleCategorie)
        {
            if (Categorie.EstValide(nouvelleCategorie.Nom))
            {
                LstCategories.Add(nouvelleCategorie);
            }
        }

        /// <summary>
        /// Permet de retirer une catégorie d'un jeu. 
        /// </summary>
        /// <param name="ancienneCategorie"></param>
        public void RetirerCategorie(Categorie ancienneCategorie)
        {
            LstCategories.Remove(ancienneCategorie);
        }

        /// <summary>
        /// Permet de vérifier si le jeu est d'une catégorie précise.
        /// </summary>
        /// <param name="categorie">La catégorie à vérifier.</param>
        /// <returns>True si le jeu est de la catégorie à vérifier, false sinon.</returns>
        public bool EstDeCategorie(Categorie categorie)
        {
            return LstCategories.Contains(categorie);
        }

        //MODIFICATION
        /// <summary>
        /// Fonction qui va permettre de savoir si le minimum et le maximum d'un jeu sont valident
        /// </summary>
        /// <param name="min">La valeur miinimum</param>
        /// <param name="max">La valeur maximum</param>
        /// <returns>Vrai, si le minimum est plus petit ou égale au maximum</returns>
        public bool EstValideMinMax(int min, int max)
        {
            if (min <= max)
            {
                return true;
            }
            else
            {
                return false;
            }
        }
    }
}
