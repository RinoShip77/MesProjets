//Olivier Bourgault: 1875009

using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Navigation;
using System.Windows.Shapes;
using Newtonsoft.Json;  //Librairie pour les fichier JSON
using System.IO;    //Pour la lecture du fichier JSON
using System.Collections.ObjectModel;   //Pour utiliser les collections observables
using _1875009_BLL;

namespace _1875009_UIL
{
    /// <summary>
    /// Logique d'interaction pour UCAccueil.xaml
    /// </summary>
    public partial class UCAccueil : UserControl
    {
        public UCAccueil()
        {
            InitializeComponent();

            //On va chercher les données du fichier JSON
            Connexions.ChargerFicher();
        }

        private void btnConnection_Click(object sender, RoutedEventArgs e)
        {
            //Vérifie si le texte saisie est vide
            if (txbNomDUtilisateur.Text.Trim() != "" && pwbMotDePasse.Password.Trim() != "")
            {
                //Va valider si les données sont présentes dans la liste des personnes autorisées
                if (EstValide(txbNomDUtilisateur.Text, pwbMotDePasse.Password))
                {
                    //Active le menu de la fenêtre principale
                    MainWindow mainWindow = App.Current.Windows[0] as MainWindow;
                    mainWindow.mnuMenuPrincipal.IsEnabled = true;

                    //Affiche un message de succès
                    MessageBox.Show("La connexion est établie sous l'identifiant '" + txbNomDUtilisateur.Text + "'.", "Cennecté", MessageBoxButton.OK, MessageBoxImage.Information);

                    //Instancie une connexion
                    Connexion connexion = Connexion.GetInstance();

                    //Efface le contenu des boîtes de texte
                    txbNomDUtilisateur.Clear();
                    pwbMotDePasse.Clear();
                }
                else
                {
                    //Désactive le menu de la fenêtre principale
                    MainWindow mainWindow = App.Current.Windows[0] as MainWindow;
                    mainWindow.mnuMenuPrincipal.IsEnabled = false;

                    //Affiche un message d'erreurs
                    MessageBox.Show("La connexion n'a pas pu être est établie avec le nom d'utilisateur '" + txbNomDUtilisateur.Text + "' et le mot de passe '" + pwbMotDePasse.Password + "'.", "Erreur", MessageBoxButton.OK, MessageBoxImage.Error);

                    //Efface le contenu des boîtes de texte
                    txbNomDUtilisateur.Clear();
                    pwbMotDePasse.Clear();
                }
            }
            else
            {
                //Affiche un message pour avertir l'utilisateur
                MessageBox.Show("Vous devez saisir un nom d'utilisateur et un mot de passe.", "Avertissement", MessageBoxButton.OK, MessageBoxImage.Warning);
            }
        }

        private bool EstValide(string id, string passwd)
        {
            //Parcours la collection de données pour les connexions
            foreach (Connexion _connexion in Connexions.connexions)
            {
                //Si on trouve le même identifiant et le même mot de passe, ...
                if (_connexion.Id == id && _connexion.Passwd == passwd)
                {
                    return true;
                }
            }

            return false;
        }
    }
}
