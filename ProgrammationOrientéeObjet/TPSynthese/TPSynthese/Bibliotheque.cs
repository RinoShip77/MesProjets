using System;
using System.Collections.Generic;
using System.Text;
using System.IO;

namespace TPSynthese
{
    /// <summary>
    /// Conteneur de toute l’information chargée des fichiers de données. Un seul objet de cette classe existe comme attribut de la classe Program
    /// </summary>
    class Bibliotheque
    {
        /// <summary>
        /// Le constructeur lit tous les fichiers donnés au lancement du programme et crée une interprétation lors de cette lecture
        /// Chaque ligne est évaluée selon :
        /// - Si la ligne valide débute par « A », un album est créé et ajouté à la liste des albums
        /// - Si la ligne valide « I », une interprétation est créée. La bibliothèque ne contient pas de liste de toutes les interprétations
        /// </summary>
        /// <param name="args">Le tableau de chaînes de caractères à évaluer</param>
        public Bibliotheque(string[] args)
        {
            for (int cpt = 0; cpt < args.Length; ++cpt) // Selon le nombre d'éléments dans le tableau
            {
                try // On essaye le code
                {
                    using (StreamReader fichier = new StreamReader(args[cpt])) // On ouvre un fichier selon la boucle
                    {
                        string ligne = fichier.ReadLine(); // On lit la ligne du fichier

                        while (ligne.Length > 0) // Tant que la longueur de la ligne est plus grande que 0
                        {
                            ValiderLigne(ligne); // On valide la ligne

                            if (ligne.StartsWith("#")) // Si elle commence par '#'
                            {                                
                                ligne = fichier.ReadLine(); // On l'ignore
                            }
                            else
                            {
                                if (ligne.IndexOf("A") == 0) // Si la position de "A" est au début
                                {
                                    _albums.Add(new Album(ligne)); // On ajoute un nouvel album à la liste
                                    _statistiques.IncrementerAlbumsCharges(); // On appel la fonction pour augmenter le nombre d'albums
                                }

                                if (ligne.IndexOf("I") == 0) // Si le position de "I" est au début
                                {
                                    Interpretation interpretation = new Interpretation(ligne); // On crée une interpretation
                                    _statistiques.IncrementerInterpretationsChargees(); // On appel la fonction pour augmenter le nombre d'interpretations
                                }
                            }

                            ligne = fichier.ReadLine(); // On lit la prochaine ligne
                        }

                        _statistiques.AjouterFichierLu(args[cpt]); // On appel la fonction pour augmenter le nombre de fichiers lus
                    }
                }
                catch (FileNotFoundException) // Si on trouve pas le fichier
                {
                    _statistiques.AjouterFichierIntrouvable(args[cpt]); // On appel la fonction pour augmenter le nombre de fichiers introuvables
                }
                catch (Exception)
                {
                    // On ignore le bloc 'catch'
                }
            }
        }

        /// <summary>
        /// Fonction qui valide une chaîne de caractères
        /// </summary>
        /// <param name="ligne">La chaîne de caractères</param>
        /// <returns>Vrai si la ligne est conforme aux conditions, sinon faux</returns>
        public void ValiderLigne(string ligne)
        {
            if (ligne[0] != 'A' && ligne[0] != 'I') // Si la chaîne ne débute pas par 'A' et 'I'
            {
                _statistiques.IncrementerLignesEnErreur(); // On appel la fonction pour augmenter le nombre de lignes en erreurs
            }
        }

        /// <summary>
        /// Retourne une liste d'items musicaux
        /// </summary>
        /// <param name="type">Le type de l'objet</param>
        /// <param name="recherche">La chaine qu'on cherche</param>
        /// <param name="tri">De quelle façon on trie</param>
        /// <return>La liste d'items musicaux</return>
        public List<ItemMusical> Liste(TypeItem type, string recherche, Tri tri)
        {
            switch (type) // On agit en fonction du 'type' donnée
            {
                case TypeItem.Album: // Pour un album
                    foreach (var item in _albums) // Pour chaque item de la iste d'album
                    {
                        if (item.Nom == recherche) // Si un élément à le même nom que ce qu'on recherche
                        {
                            _albums.Sort(); // On trie la liste
                        }
                    }
                    return _albums; // On retourne la liste trié

                case TypeItem.Artiste: // Pour un artiste
                    foreach (var item in _artistes) // Pour chaque item de la iste d'artiestes
                    {
                        if (item.Nom == recherche) // Si un élément à le même nom que ce qu'on recherche
                        {
                            _artistes.Sort(); // On trie la liste
                        }
                    }
                    return _artistes; // On retourne la liste trié

                case TypeItem.Chanson: // Pour une chanson
                    foreach (var item in _chansons) // Pour chaque item de la iste de chanson
                    {
                        if (item.Nom == recherche) // Si un élément à le même nom que ce qu'on recherche
                        {
                            _chansons.Sort(); // On trie la liste
                        }
                    }
                    return _chansons; // On retourne la liste trié

                default:
                    return null; // Par défaut, on retourne une liste nulle
            }
        }

        /// <summary>
        /// Retourne une liste d'items musicaux
        /// </summary>
        /// <param name="type">Le type de l'objet</param>
        /// <param name="choixChar">Le caractère qu'on cherche</param>
        /// <param name="tri">De quelle façon on trie</param>
        /// <return>La liste d'items musicaux</return>
        public List<ItemMusical> Liste(TypeItem type, char choixChar, Tri tri)
        {
            switch (type)
            {
                case TypeItem.Album: // Pour un album
                    foreach (var item in _albums) // Pour chaque item de la iste d'album
                    {
                        if (Convert.ToChar(item.Nom) == choixChar) // Si un élément à le même nom que ce qu'on recherche
                        {
                            _albums.Sort(); // On trie la liste
                        }
                    }
                    return _albums; // On retourne la liste trié

                case TypeItem.Artiste: // Pour un artiste
                    foreach (var item in _artistes) // Pour chaque item de la iste d'artistes
                    {
                        if (Convert.ToChar(item.Nom) == choixChar) // Si un élément à le même nom que ce qu'on recherche
                        {
                            _artistes.Sort(); // On trie la liste
                        }
                    }
                    return _artistes; // On retourne la liste trié

                case TypeItem.Chanson: // Pour une chanson
                    foreach (var item in _chansons) // Pour chaque item de la iste de chanson
                    {
                        if (Convert.ToChar(item.Nom) == choixChar) // Si un élément à le même nom que ce qu'on recherche
                        {
                            _chansons.Sort(); // On trie la liste
                        }
                    }
                    return _chansons; // On retourne la liste trié

                default:
                    return null; // Pars défaut, on retourne une liste nulle
            }
        }

        /// <summary>
        /// Fonction pour accéder à l'information de l'extérieur
        /// </summary>
        public StatistiquesFichiers Statistiques { get { return _statistiques; } } // Accesseurs pour les statistiques
        
        /// <summary>
        /// Déclaration de variables locale propres à un item musicale
        /// </summary>
        private StatistiquesFichiers _statistiques = new StatistiquesFichiers(); // Une variable qui permet de sauvegarder les statistiques du programme
        private List<ItemMusical> _albums = new List<ItemMusical>(); // Une liste d'albums
        private List<ItemMusical> _artistes = new List<ItemMusical>(); // Une liste des artistes
        private List<ItemMusical> _chansons = new List<ItemMusical>(); // Une liste des chansons
    }
}