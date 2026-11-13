// ------------------------------------------------
// Projet:   Gestionnaire
// Cours:    420-4C4-JR
// Fichier:  AddGame.xaml.cs
// Auteur:   Olivier Bourgault
// Date:     2022-04-15
// ------------------------------------------------

using System;
using System.Windows;

namespace Gestionnaire
{
    /// <summary>
    /// Logique d'interaction pour Window2.xaml
    /// </summary>
    public partial class AddGame : Window
    {
        /// <summary>
        /// Pour garantir la cohérence des données du nouveau jeu,
        /// l’application doit s’assurer qu’il n’y a pas déjà un jeu qui porte
        /// le même nom, que le nombre minimal est toujours plus
        /// petit ou égal au nombre maximal et que le nombre de
        /// catégories associées au nouveau jeu est compris entre 1 et 7.
        /// La fenêtre d’ajout d’un nouveau jeu doit aussi contenir
        /// un bouton de validation et un bouton d’annulation.
        /// Le bouton de validation permet d’ajouter le nouveau jeu dans
        /// la liste des jeux et permet aussi de réécrire le fichier « fJeux.json ».
        /// </summary>

        /// <summary>
        /// Initialise la vue et déclare le constructeur de la classe.
        /// </summary>
        public AddGame()
        {
            InitializeComponent();

            ltbCategories.ItemsSource = PrincipalManager._categories;
        }

        /// <summary>
        /// Fonction qui va se déclancher sur l'appui du bouton 'Valider l'ajout' de la fenêtre.
        /// Il permettra l'ajout d'un nouveau jeu à la liste de jeux.
        /// </summary>
        /// <param name="sender">l'expéditeur</param>
        /// <param name="e">l'événement</param>
        private void btnValider_Click(object sender, RoutedEventArgs e)
        {
            try
            {
                string nom = txbNom.Text;
                int annee = Convert.ToInt32(txbAnnee.Text);
                string concepteur = txbConcepteur.Text;
                int minJoueurs = Convert.ToInt32(txbMinJoueurs.Text);
                int maxJoueurs = Convert.ToInt32(txbMaxJoueurs.Text);
                int minAge = Convert.ToInt32(txbMinAge.Text);
                int maxAge = Convert.ToInt32(txbMaxAge.Text);
                int dureeMin = Convert.ToInt32(txbDureeMin.Text);
                int dureeMax = Convert.ToInt32(txbDureeMax.Text);
                Jeu jeu = new Jeu(nom, annee, concepteur, minJoueurs, maxJoueurs, minAge, maxAge, dureeMin, dureeMax);

                if (ltbCategories.SelectedItems.Count > 0 && ltbCategories.SelectedItems.Count < 8 && jeu.EstValideMinMax(minJoueurs, maxJoueurs) && jeu.EstValideMinMax(minAge, maxAge) && jeu.EstValideMinMax(dureeMin, dureeMax))
                {
                    foreach (Categorie categorie in ltbCategories.SelectedItems)
                    {
                        jeu.LstCategories.Add(new Categorie(categorie.Nom));
                        MessageBox.Show("La catégorie '" + categorie.Nom + "' a été ajouté avec succès dans la liste du jeu '" + jeu.Nom + "'.", "Succès", MessageBoxButton.OK, MessageBoxImage.Information);
                    }
                    PrincipalManager._jeux.Add(jeu);

                    Jeu.ReecrirefJeux();
                    Close();
                }
            }
            catch (Exception) { }
        }

        /// <summary>
        /// Fonction qui va se déclancher sur l'appui du bouton 'Annuler' de la fenêtre.
        /// Elle permettra de fermer, donc annuler l'ajout.
        /// </summary>
        /// <param name="sender">L'expéditeur</param>
        /// <param name="e">L'événement</param>
        private void btnAnnuler_Click(object sender, RoutedEventArgs e)
        {
            Close();
        }
    }
}
