using System;
using System.Collections.Generic;
using System.Text;
using System.IO;

namespace TP2
{
    /// <summary>
    /// Définition de la classe GestionnairePatients qui va s'occuper des opérations liés aux patients
    /// </summary>
    class GestionnairePatients
    {
        /// <summary>
        /// Déclaration du constructeur paramètré d'un gestionnaire de patients
        /// </summary>
        /// <param name="gestionnaireMedecins">Objet de type GestionnaireMedecins donné lors de l'appel</param>
        public GestionnairePatients(GestionnaireMedecins gestionnaireMedecins)
        {
            try // Bloc try pour tester le code et prévenir les erreurs
            {
                _gestionnaireMedecins = gestionnaireMedecins; // Initialise l'attribut locale avec la variables passée en paramètre
                
                using (StreamReader fichierPatients = new StreamReader("patients.txt")) // On on le fichier en lecture en assurant sa fermeture à la fin
                {
                    string ligne = fichierPatients.ReadLine(); // On lit la première ligne du fichier

                    while (ligne != null)
                    {
                        _lesPatients.Add(new Patient(ligne)); // On ajoute un nouveau patient à la liste de paients à l'aide du constructeur paramètré de Patient
                        ligne = fichierPatients.ReadLine(); // On passe à la suivante
                    }
                }              
            }
            catch (Exception)
            {
                // On fait rien
            }
        }

        /// <summary>
        /// On ajoute un patient à la liste
        /// </summary>
        public void Ajouter()
        {
            try 
            {
                Program.AfficherSousTitre("Ajout d'un patient :");

                foreach (var item in _lesPatients) // Pour chaque élément de la liste, ...
                {
                    if (item.Medecin.Activite == 1) // S'il n'y a pas de patients actif, ...
                    {
                        Console.WriteLine("Ajout impossible, aucun médecin actif dans le système"); // On affiche l'explication
                    }
                }

                Program.AfficherSousTitre("Ajout d'un patient :");

                Patient p = new Patient();
                foreach (var item in _lesPatients) // Pour chaque objet de la liste
                {
                    if (item.NumeroAssuranceMaladie == p.NumeroAssuranceMaladie) // On cherche si aucun des éléments de la liste n'a déjà ce numéro
                    {
                        Console.WriteLine("Ajout impossible, ce numéro d'assurance maladie existe déjà dans le système");
                    }
                }

                _lesPatients.Add(p); // On ajoute le patient
                Console.WriteLine("Patient ajouté");
            }
            catch (Exception)
            {
                // On ignore et on continue
            }

            Program.Pause();
        }

        /// <summary>
        /// Fonction qui va modifier les attributs d'un patient pour le classer comme décédé
        /// </summary>
        public void IndiquerDeces()
        {
            try // Un bloc try pour empêcher le programme de planter
            {
                foreach (var item in _lesPatients) // Pour chaque objet de la liste de patients
                {
                    if (item.NumeroAssuranceMaladie != _patient.NumeroAssuranceMaladie) // Si le même n.a.m est présent dans la liste
                    {
                        throw new Exception("Patient introuvable"); // On lance un exception
                    }
                }

                Console.WriteLine("Numéro d'assurance maladie : "); // On demande le numéro à l'utilisateur et on le valide
                int code = Convert.ToInt32(Console.ReadLine());

                if (code < 1000 || code > 9999)
                {
                    throw new Exception("Valeur incorrect, doit être un entier entre 1000 et 9999\n");
                }

                Console.WriteLine("Entrez la date du décès : "); // On demande la date du décès et on la valide
                string strDate = Console.ReadLine();
                DateTime date = Convert.ToDateTime(strDate);

                if (DateTime.TryParse(strDate, out date)) // Si c'est correct, on ajoute la date au patient
                {
                    _patient.DateDeces = date;
                    _patient.Statut = 0;
                }
                else
                {
                    throw new Exception("Le format de la date doit être AAAA/MM/JJ"); // On lance une autre exception
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
                foreach (var item in _lesPatients) // Pour chaque objet dans la liste de patients
                {
                    if (item.Statut == 0) // S'il est décédé, ...
                    {
                        if (_lesPatients.Count < 1) // Si la liste contient moins d'un élément
                        {
                            _gestionnaireMedecins.AfficherStatistiques(); // On affiche les données de la liste des médecins
                            Console.WriteLine("   0 patient");
                        }
                        else
                        {
                            _gestionnaireMedecins.AfficherStatistiques();
                            Console.WriteLine("   {0} patients",
                        _lesPatients.Count); // On affiche le nombre d'élément dans la liste de patients
                        }
                    }
                    else
                    {
                        int nbOccurence = 1;
                        if (item.Statut == 1)
                        {
                            _gestionnaireMedecins.AfficherStatistiques();
                            Console.WriteLine("   {0} patients, dont {1} décédé", // On réaffiche le nombre d'objet contenu ainsi que le compteur
                        _lesPatients.Count, nbOccurence);
                            nbOccurence++; // Un compteur locale qui s'incrémente à chaque itération de la boucle
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
        /// Affiche toutes la liste de patients en affichant chaque objet individuellement
        /// </summary>
        public void AfficherListe()
        {
            try // On teste le code pour prévenir les erreurs
            {
                Program.AfficherSousTitre("Liste de patients :");

                foreach (var item in _lesPatients) // On exécute le code sur chaque objet de la liste de patients
                {
                    if (item.Statut == 1) // S'il est vivant, on affiche son médecin
                    {
                        Console.WriteLine("{0} {1} {2}, Médecin : {3} {4} {5}",
                            item.NumeroAssuranceMaladie, item.Prenom, item.Nom, item.Medecin.CodeID, item.Medecin.Prenom, item.Medecin.Nom);
                    }
                    else // Sinon, il est décédé donc, il n'a pas de médecin
                    {
                        Console.WriteLine("{0} {1} {2}, Décédé",
                            item.NumeroAssuranceMaladie, item.Prenom, item.Nom);
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
        /// On affiche les informations d'un seul patient
        /// </summary>
        public void AfficherUnique()
        {
            try // On prévient les erreurs
            {
                Program.AfficherSousTitre("Patient :");

                foreach (var item in _lesPatients) // Pour chaque objet de la liste de patients
                {
                    if (item.NumeroAssuranceMaladie != _patient.NumeroAssuranceMaladie)
                    {
                        throw new Exception("Patient introuvable");
                    }
                }

                Console.Write("Numéro d'assurance maladie : "); // On saisie le numéro d'assurance maladie du patient voulu et on le valide
                int code = Convert.ToInt32(Console.ReadLine());

                if (code < 1000 || code > 9999)
                {
                    throw new Exception("Valeur incorrect, doit être un entier entre 1000 et 9999\n"); // On lance une exception
                }

                if (_patient.Statut == 1)
                {
                    Console.WriteLine("Numéro assurance maladie : {0}\nNom : {1} {2}\nMédecin : {3} {4} {5}", // S'il est vivant, on affiche son médecin
                        _patient.NumeroAssuranceMaladie, _patient.Prenom, _patient.Nom, _patient.Medecin.CodeID, _patient.Medecin.Prenom, _patient.Medecin.Nom);
                }
                else
                {

                    Console.WriteLine("Numéro d'assurance maladie : {0}\nNom : {1} {2}\nDécédé", // Sinon, il est décédé. Donc, il n'a pas de médecin
                       _patient.NumeroAssuranceMaladie, _patient.Prenom, _patient.Nom);
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

                using (StreamWriter sauvegardeMedecin = new StreamWriter("patients.txt")) // On écrit dans un nouveau fichier
                {
                    if (_patient.Statut == 1)
                    {
                        foreach (var item in _lesPatients)
                        {
                            StringBuilder sb = new StringBuilder();
                            sb.AppendFormat("{0};{1};;{3}", // On utilise le bon format (sans date de décès) pour l'écriture dans le fichier
                                item.NumeroAssuranceMaladie.ToString(), item.Prenom, item.Nom, item.CodeIDMedecin);
                            sb.ToString();
                        }
                    }
                    else
                    {
                        foreach (var item in _lesPatients)
                        {
                            StringBuilder sb = new StringBuilder();
                            sb.AppendFormat("{0};{1};{2};{3}", // On utilise le bon format (avec une date de décès) pour l'écriture dans le fichier
                                item.NumeroAssuranceMaladie.ToString(), item.Prenom, item.Nom, item.DateDeces);
                            sb.ToString();
                        }
                    }
                }
            }
            catch (Exception)
            {
                // On ignore les erreurs possibles
            }

            Program.Pause();
        }

        // Déclaration des attributs de la classe GestionnairePatients
        private Patient _patient = new Patient();
        private GestionnaireMedecins _gestionnaireMedecins;
        private List<Patient> _lesPatients = new List<Patient>();
    }
}