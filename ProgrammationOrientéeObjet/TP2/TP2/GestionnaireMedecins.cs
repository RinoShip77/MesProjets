using System;
using System.Collections.Generic;
using System.Text;
using System.IO;

namespace TP2
{
    /// <summary>
    /// Définition de la classe GestionnairePatients qui va s'occuper des opérations liés aux patients
    /// </summary>
    class GestionnaireMedecins
    {
        /// <summary>
        /// Déclaration du constructeur par défaut d'un gestionnaire de médecins
        /// </summary>
        public GestionnaireMedecins()
        {
            try // Bloc try pour tester le code et prévenir les erreurs
            {
                using (StreamReader fichierMedecin = new StreamReader("medecins.txt"))// On on le fichier en lecture en assurant sa fermeture à la fin
                {
                    string ligne = fichierMedecin.ReadLine(); // On lit la première ligne du fichier

                    while (ligne != null)
                    {
                        _lesMedecins.Add(new Medecin(ligne)); // On ajoute un nouveau médecin à la liste de médecins à l'aide du constructeur paramètré de Patient
                        ligne = fichierMedecin.ReadLine(); // On passe à la suivante
                    }
                }


                if (_lesMedecins.Count > 0) // Si après l'ajout, la liste de médecins est vide, ...
                {
                    _medAvecMoinsPatients = _lesMedecins[0];

                    foreach (var item in _lesMedecins) // Pour chaque élément de la liste
                    {
                        if (item.NbPatients < _medAvecMoinsPatients.NbPatients)
                        {
                            _medAvecMoinsPatients = item;
                        }
                    }
                }
            }
            catch (Exception)
            {
                // On ignore et on continue
            }
        }

        /// <summary>
        /// On ajoute un médecin à la liste
        /// </summary>
        public void Ajouter()
        {
            try
            {
                Program.AfficherSousTitre("Ajout d'un médecin :");

                Medecin m = new Medecin();
                foreach (var item in _lesMedecins) // Pour chaque élément de la liste, ...
                {
                    if (item.CodeID == m.CodeID) // S'il n'y a pas de médecin actif, ...
                    {
                        Console.WriteLine("Ajout impossible, ce code d'identification existe déjà dans le système"); // On affiche l'explication
                    }
                }


                _lesMedecins.Add(m); // On ajoute le médecin
                Console.WriteLine("Médecin ajouté");
            }
            catch (Exception)
            {
                // On ignore et on continue
            }

            Program.Pause();
        }

        /// <summary>
        /// Fonction qui va modifier les attributs d'un médecin pour le classer comme retraité
        /// </summary>
        public void IndiquerRetraite()
        {
            try // Un bloc try pour empêcher le programme de planter
            {
                foreach (var item in _lesMedecins) // Pour chaque objet de la liste de médecins
                {
                    if (item.Activite == 1)
                    {
                        throw new Exception("Au moins un médecin non retraité doit être défini"); // On lance un exception
                    }

                    if (item.CodeID != _medecin.CodeID)
                    {
                        throw new Exception("Médecin introuvable"); // On lance un exception
                    }
                }
                Console.WriteLine("Code d'identification : "); // On demande le code à l'utilisateur et on le valide
                int code = Convert.ToInt32(Console.ReadLine());

                if (code < 100 || code > 999)
                {
                    throw new Exception("Valeur incorrect, doit être un entier entre 100 et 999\n");
                }

                Console.WriteLine("Entrez la date de la retraite : "); // On demande la date de la retraite et on la valide
                string strDate = Console.ReadLine();
                DateTime date = Convert.ToDateTime(strDate);

                if (DateTime.TryParse(strDate, out date)) // Si c'est correct, on ajoute la date au médecin
                {
                    _medecin.DateRetraite = date;
                    _medecin.Activite = 1;
                }
                else
                {
                    throw new Exception("Le format de la date est invalide : (AAAA/MM/JJ)"); // On lance une autre exception
                }
            }
            catch (Exception e)
            {
                Console.WriteLine(e.Message);
            }

            Program.Pause();
        }

        /// <summary>
        /// Affiche toutes les données du système
        /// </summary>
        public void AfficherStatistiques()
        {
            try // On essaye le code pour éviter un arrêt complet du programme
            {
                foreach (var item in _lesMedecins) // Pour chaque objet dans la liste de médecins
                {
                    if (item.Activite == 0) // S'il est retraité, ...
                    {
                        if (_lesMedecins.Count < 1) // Si la liste contient moins d'un élément
                        {
                            Console.WriteLine("   0 médecin");
                            _lesPatients.AfficherStatistiques(); // On affiche les données de la liste des patients
                        }
                        else
                        {
                            Console.WriteLine("   {0} médecins",
                            _lesMedecins.Count); // On affiche le nombre d'élément dans la liste de patients
                            _lesPatients.AfficherStatistiques();
                        }
                    }
                    else
                    {
                        int nbOccurence = 1; // Un compteur locale qui s'incrémente à chaque itération de la boucle
                        if (item.Activite == 1)
                        {
                            Console.WriteLine("   {0} médecins, dont {1} à la retraite", // On réaffiche le nombre d'objet contenu ainsi que le compteur
                        _lesMedecins.Count, nbOccurence);
                            _lesPatients.AfficherStatistiques();
                            nbOccurence++;
                        }
                    }
                }
            }
            catch (Exception)
            {
                // On veut continuer, donc on fait rien
            }

            Program.Pause();
        }

        /// <summary>
        /// Affiche toutes la liste de médecins en affichant chaque objet individuellement
        /// </summary>
        public void AfficherListe()
        {
            try // On teste le code pour prévenir les erreurs
            {
                Program.AfficherSousTitre("Liste de médecins :");

                foreach (var item in _lesMedecins) // On exécute le code sur chaque objet de la liste de médecins
                {
                    if (item.Activite == 0)  // S'il n'est pas retraité, on affiche ses patients
                    {
                        Console.WriteLine("{0} {1} {2}, Nombre de patients : {3}",
                        item.CodeID, item.Prenom, item.Nom, item.NbPatients);
                    }
                    else // Sinon, il est retraité donc, il n'a pas de patient

                    {
                        Console.WriteLine("{0} {1} {2}, Retraité",
                            item.CodeID, item.Prenom, item.Nom);
                    }
                }
            }
            catch (Exception)
            {
                // On veut ignorer donc on fait rien
            }

            Program.Pause();
        }

        /// <summary>
        /// On affiche les informations d'un seul médecin
        /// </summary>
        public void AfficherUnique()
        {
            try // On prévient les erreurs
            {
                Program.AfficherSousTitre("Médecin :");

                foreach (var item in _lesMedecins) // Pour chaque objet de la liste de médecins
                {
                    if (item.CodeID != _medecin.CodeID)
                    {
                        throw new Exception("Médecin introuvable");
                    }
                }

                Console.Write("Code d'identification : "); // On saisie le code d'identification du médecin voulu et on le valide
                int code = Convert.ToInt32(Console.ReadLine());

                if (code < 100 || code > 999)
                {
                    throw new Exception("Valeur incorrect, doit être un entier entre 100 et 999"); // On lance une exception
                }

                if (_medecin.NbPatients == 0)
                {
                    Console.WriteLine("Code d'identification : {0}\nNom : {1} {2}\nPatients : {3}", // S'il n'est pas retraité, on affiche son nombre de patients
                       _medecin.CodeID, _medecin.Prenom, _medecin.Nom, _medecin.ListePatients);
                }
                else
                {
                    Console.WriteLine("Code d'identification : {0}\nNom : {1} {2}\nAucun patients", // Sinon, il est retraité. Donc, il n'a pas de patient
                        _medecin.CodeID, _medecin.Prenom, _medecin.Nom);
                }

            }
            catch (Exception e)
            {
                Console.WriteLine(e.Message);
            }

            Program.Pause();
        }


        /// <summary>
        /// On sauvegarde le nouveau fichier avec le même nom qu'au début
        /// </summary>
        public void Sauvegarder()
        {
            try // On test le code sans erreur
            {
                Program.AfficherSousTitre("Sauvegarde du fichier :");

                using (StreamWriter sauvegardeMedecin = new StreamWriter("medecins.txt"))
                {
                    foreach (var item in _lesMedecins)
                    {
                        StringBuilder sb = new StringBuilder();
                        sb.AppendFormat("{0};{1};{2};{3}", // On utilise le bon format pour l'écriture dans le fichier
                            item.CodeID.ToString(), item.Prenom, item.Nom, item.DateRetraite.ToString());
                        sb.ToString();
                    }
                }
            }
            catch (Exception)
            {
                // On ignore les erreurs possibles
            }

            Program.Pause();
        }

        // Déclaration des attributs de la classe GestionnaireMedecins
        private Medecin _medecin = new Medecin();
        private readonly Medecin _medAvecMoinsPatients;
        private List<Medecin> _lesMedecins = new List<Medecin>();
    }
}