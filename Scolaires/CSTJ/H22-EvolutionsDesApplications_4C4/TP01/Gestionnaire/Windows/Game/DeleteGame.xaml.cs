// ------------------------------------------------
// Projet:   Gestionnaire
// Cours:    420-4C4-JR
// Fichier:  DeleteGame.xaml.cs
// Auteur:   Olivier Bourgault
// Date:     2022-04-15
// ------------------------------------------------

using System.Windows;
using System.Windows.Controls;

namespace Gestionnaire
{
    /// <summary>
    /// Logique d'interaction pour DeleteGame.xaml
    /// </summary>
    public partial class DeleteGame : Window
    {
        /// <summary>
        /// Initialise la vue et déclare le constructeur de la classe.
        /// </summary>
        public DeleteGame()
        {
            InitializeComponent();

            ltbJeux.ItemsSource = PrincipalManager._jeux;
        }

        /// <summary>
        /// Fonction qui va se déclancher sur l'appui du bouton pour supprimer de la fenêtre.
        /// Il permettra la suppression d'un jeu dans la liste.
        /// </summary>
        /// <param name="sender">L'expéditeur</param>
        /// <param name="e">L'événement</param>
        private void btnSupprimerJeu_Click(object sender, RoutedEventArgs e)
        {
            Jeu jeu = PrincipalManager._jeux[ltbJeux.SelectedIndex];
            PrincipalManager._jeux.Remove(jeu);

            Jeu.ReecrirefJeux();
            Close();
        }

        /// <summary>
        /// Fonction qui va se déclancher sur l'appui du bouton 'Annuler' de la fenêtre.
        /// Elle permettra de fermer, donc annuler les modifications.
        /// </summary>
        /// <param name="sender">L'expéditeur</param>
        /// <param name="e">L'événement</param>
        private void btnAnnuler_Click(object sender, RoutedEventArgs e)
        {
            Close();
        }
    }
}
