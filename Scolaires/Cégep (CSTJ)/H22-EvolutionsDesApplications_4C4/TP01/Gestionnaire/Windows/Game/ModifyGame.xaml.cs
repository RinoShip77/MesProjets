// ------------------------------------------------
// Projet:   Gestionnaire
// Cours:    420-4C4-JR
// Fichier:  ModifyGame.xaml.cs
// Auteur:   Olivier Bourgault
// Date:     2022-04-15
// ------------------------------------------------

using System;
using System.Windows;

namespace Gestionnaire
{
    /// <summary>
    /// Logique d'interaction pour Window1.xaml
    /// </summary>
    public partial class ModifyGame : Window
    {
        private Jeu jeu;

        /// <summary>
        /// Ses contrôles, sous forme similaire à un formulaire, contiennent
        /// toutes les informations du jeu sélectionné dans le DataGrid de la fenêtre principale.
        /// À l’exception du nom du jeu, il doit être possible de modifier
        /// tous les autres champs d’un jeu (y compris l’ajout ou la suppression
        /// de catégories auxquels appartient ce jeu). En modifiant les
        /// valeurs des intervalles, il faut s’assurer de leur cohérence.
        /// Le nombre de catégories associées à un jeu doit être compris entre 1 et 7.
        /// Quand la modification des données d’un jeu est finie, la liste de
        /// jeux est mise à jour et le fichier des jeux est réécrit.
        /// En plus, il doit être possible d’annuler les modifications
        /// en fermant la fenêtre sans sauvegarde.
        /// </summary>

        /// <summary>
        /// Initialise la vue et déclare le constructeur de la classe.
        /// </summary>
        public ModifyGame(Jeu jeu)
        {
            InitializeComponent();

            this.jeu = jeu;
            txbNom.Text = jeu.Nom;
            txbAnnee.Text = jeu.Annee.ToString();
            txbConcepteur.Text = jeu.Concepteur;
            txbMinJoueurs.Text = jeu.MinJoueurs.ToString();
            txbMaxJoueurs.Text = jeu.MaxJoueurs.ToString();
            txbMinAge.Text = jeu.MinAge.ToString();
            txbMaxAge.Text = jeu.MaxAge.ToString();
            txbDureeMin.Text = jeu.DureeMin.ToString();
            txbDureeMax.Text = jeu.DureeMax.ToString();
            ltbCategoriesInit.ItemsSource = jeu.LstCategories;
            ltbCategoriesChoix.ItemsSource = PrincipalManager._categories;
        }

        /// <summary>
        /// Fonction qui va se déclancher sur l'appui du bouton 'Ajouter une catégorie' de la fenêtre.
        /// Il permettra l'ajout d'une nouvelle catégorie à celles déjà associées au jeu.
        /// </summary>
        /// <param name="sender">l'expéditeur</param>
        /// <param name="e">l'événement</param>
        private void btnAjouterCategorie_Click(object sender, RoutedEventArgs e)
        {
            if (ltbCategoriesInit.Items.Count > 0 && ltbCategoriesInit.Items.Count < 8)
            {
                foreach (Categorie categorie in ltbCategoriesChoix.SelectedItems)
                {
                    jeu.LstCategories.Add(new Categorie(categorie.Nom));
                    MessageBox.Show("La catégorie '" + categorie.Nom + "' a été ajouté avec succès dans la liste du jeu '" + jeu.Nom + "'.", "Succès", MessageBoxButton.OK, MessageBoxImage.Information);
                }
            }
        }

        /// <summary>
        /// Fonction qui va se déclancher sur l'appui du bouton 'Retirer une catégorie' de la fenêtre.
        /// Il permettra de retirer un catégorie à celles déjà associées au jeu.
        /// </summary>
        /// <param name="sender">l'expéditeur</param>
        /// <param name="e">l'événement</param>
        private void btnRetirerCategorie_Click(object sender, RoutedEventArgs e)
        {
            if (ltbCategoriesInit.Items.Count > 0 && ltbCategoriesInit.Items.Count < 8)
            {
                foreach (Categorie categorie in ltbCategoriesInit.SelectedItems)
                {
                    jeu.LstCategories.Remove(categorie);
                    MessageBox.Show("La catégorie '" + categorie.Nom + "' a été retiré avec succès dans la liste du jeu '" + jeu.Nom + "'.", "Succès", MessageBoxButton.OK, MessageBoxImage.Information);
                }
            }
        }

        /// <summary>
        /// Fonction qui va se déclancher sur l'appui du bouton 'Valider la modification' de la fenêtre.
        /// Il permettra l'ajout d'une nouvelle catégorie à celles déjà associées au jeu.
        /// </summary>
        /// <param name="sender">l'expéditeur</param>
        /// <param name="e">l'événement</param>
        private void btnValider_Click(object sender, RoutedEventArgs e)
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

            if (ltbCategoriesInit.Items.Count > 0 && ltbCategoriesInit.Items.Count < 8 && jeu.EstValideMinMax(minJoueurs, maxJoueurs) && jeu.EstValideMinMax(minAge, maxAge) && jeu.EstValideMinMax(dureeMin, dureeMax))
            {
                PrincipalManager._jeux.Remove(jeu);
                PrincipalManager._jeux.Add(new Jeu(nom, annee, concepteur, minJoueurs, maxJoueurs, minAge, maxAge, dureeMin, dureeMax, jeu.LstCategories));

                Jeu.ReecrirefJeux();
                Close();
            }
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
