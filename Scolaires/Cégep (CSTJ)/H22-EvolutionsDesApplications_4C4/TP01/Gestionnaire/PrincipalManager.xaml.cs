// ------------------------------------------------
// Projet:   Gestionnaire
// Cours:    420-4C4-JR
// Fichier:  PrincipalManager.xaml.cs
// Auteur:   Olivier Bourgault
// Date:     2022-04-15
// ------------------------------------------------

using System;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Media.Imaging;
using System.Collections.ObjectModel;

namespace Gestionnaire
{
    /// <summary>
    /// Interaction logique pour la fenêtre principale
    /// </summary>
    public partial class PrincipalManager : Window
    {
        public static ObservableCollection<Jeu> _jeux = new ObservableCollection<Jeu>();
        public static ObservableCollection<Categorie> _categories = new ObservableCollection<Categorie>();

        /// <summary>
        /// Initialise la vue et déclare le constructeur de la classe.
        /// </summary>
        public PrincipalManager()
        {
            InitializeComponent();

            //MODIFICATION POUR QUESTION 1
            Jeu.LirefJeux();  //Appelle la fonction pour extraire les données du fichier JSON de jeux
            dgJeux.ItemsSource = _jeux;  //Initialise la grille de donnée avec les jeux de la liste observable.

            //MODIFICATION POUR QUESTION 1
            Categorie.LirefCategories();  //Appelle la fonction pour extraire les données du fichier JSON de catéories
            ltbCategories.ItemsSource = _categories;  //Initialise la source de donnée pour la liste de catégories.
        }

        /// <summary>
        /// Fonction qui va changer l'image d'arrière plan de l'onglet selon le nom
        /// du jeu lorsqu'on double clique sur une ligne de la grille de données.
        /// </summary>
        /// <param name="sender">L'expéditeur</param>
        /// <param name="e">L'événement</param>
        ///
        private void ligneDgJeu_SelectedCellsChanged(object sender, SelectedCellsChangedEventArgs e)
        {
            try
            {
                if(dgJeux.SelectedItem != null)
                {
                    imgOngletJeu.ImageSource = new BitmapImage(new Uri("Images/" + ((Jeu)dgJeux.SelectedItem).Nom + ".png", UriKind.Relative));
                }
            }
            catch (System.IO.FileNotFoundException) { }
        }

        /// <summary>
        /// Fonction qui va modifier un jeu existant.
        /// Avant de cliquer sur ce bouton, l’utilisateur doit sélectionner
        /// une ligne du DataGrid. À défaut, un message box est affiché pour
        /// signaler cette erreur à l’utilisateur. En cliquant sur ce bouton,
        /// une fenêtre modale est affichée.
        /// </summary>
        /// <param name="sender">L'expéditeur</param>
        /// <param name="e">L'événement</param>
        private void btnModifierJeu_Click(object sender, RoutedEventArgs e)
        {
            if (dgJeux.SelectedItem == null)
            {
                MessageBox.Show("Vous devez sélectionner une ligne contenant les informations d'un jeu avant de le modifier.", "Avertissement", MessageBoxButton.OK, MessageBoxImage.Warning);
            }
            else
            {
                ModifyGame modifier = new ModifyGame((Jeu)dgJeux.SelectedItem);
                modifier.Show();
            }
        }

        /// <summary>
        /// Fonction qui va ajouter un nouveau jeu à la liste.
        /// Le clic sur ce bouton permet d’afficher une fenêtre
        /// modale contenant les contrôles nécessaires pour
        /// l’ajout des informations d’un nouveau jeu.
        /// </summary>
        /// <param name="sender">L'expéditeur</param>
        /// <param name="e">L'événement</param>
        private void btnAjouterJeu_Click(object sender, RoutedEventArgs e)
        {
            AddGame ajouter = new AddGame();
            ajouter.Show();
        }

        /// <summary>
        /// Fonction qui va supprimer un jeu.
        /// La ligne du jeu à supprimer doit être sélectionné
        /// avant de cliquer sur le bouton de suppression. À défaut,
        /// une boite avec un message d’erreur est affichée.
        /// </summary>
        /// <param name="sender">L'expéditeur</param>
        /// <param name="e">L'événement</param>
        private void btnSupprimerJeu_Click(object sender, RoutedEventArgs e)
        {
            if (dgJeux.SelectedItem == null)
            {
                MessageBox.Show("Vous devez sélectionner une ligne contenant les informations d'un jeu avant de le supprimer.", "Avertissement", MessageBoxButton.OK, MessageBoxImage.Warning);
            }
            else
            {
                DeleteGame supprimer = new DeleteGame();
                supprimer.Show();
            }
        }

        /// <summary>
        /// Fonction qui va renseigner la liste de catégories associées à chacun
        /// des jeux des ces détails lorsque l'on clique sur la ligne voulue.
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void txbLstCategories_Loaded(object sender, RoutedEventArgs e)
        {
            try
            {
                TextBlock? txbLstCategories = sender as TextBlock;

                txbLstCategories.Text = "";
                for (int c = 0; c < _jeux[dgJeux.SelectedIndex].LstCategories.Count; c++)
                {
                    txbLstCategories.Text += _jeux[dgJeux.SelectedIndex].LstCategories[c].Nom + ", ";
                }
                txbLstCategories.Text = txbLstCategories.Text.Substring(0, txbLstCategories.Text.Length - 2) + ".";
            }
            catch (Exception) { }
            
        }

        /// <summary>
        /// Fonction qui va permettre l'apparition des boutons de
        /// modification et de suppresion d'une catégorie. Seulement
        /// si une seule catégorie est sélectionné dans la liste.
        /// </summary>
        /// <param name="sender">L'expéditeur</param>
        /// <param name="e">L'événement</param>
        private void ltbCategories_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            if (ltbCategories.SelectedItem != null && ltbCategories.SelectedItems.Count < 2)
            {
                btnModifierCategorie.Visibility = Visibility.Visible;
                btnSupprimerCategorie.Visibility = Visibility.Visible;
            }
            else
            {
                btnModifierCategorie.Visibility = Visibility.Collapsed;
                btnSupprimerCategorie.Visibility = Visibility.Collapsed;
            }
        }

        /// <summary>
        /// Fonction qui va modifier une catégorie existante.
        /// </summary>
        /// <param name="sender">L'expéditeur</param>
        /// <param name="e">L'événement</param>
        private void btnModifierCategorie_Click(object sender, RoutedEventArgs e)
        {
            ModifyCategory modifier = new ModifyCategory(_categories[ltbCategories.SelectedIndex]);
            modifier.Show();
        }

        /// <summary>
        /// Fonction qui va ajouter une nouvelle catégorie à la liste.
        /// </summary>
        /// <param name="sender">L'expéditeur</param>
        /// <param name="e">L'événement</param>
        private void btnAjouterCategorie_Click(object sender, RoutedEventArgs e)
        {
            AddCategory ajouter = new AddCategory();
            ajouter.Show();
        }

        /// <summary>
        /// Fonction qui va supprimer une catégorie.
        /// </summary>
        /// <param name="sender">L'expéditeur</param>
        /// <param name="e">L'événement</param>
        private void btnSupprimerCategorie_Click(object sender, RoutedEventArgs e)
        {
            if (ltbCategories.SelectedItem == null)
            {
                MessageBox.Show("Vous devez sélectionner une ligne contenant le nom d'une catégorie avant de la supprimer.", "Avertissement", MessageBoxButton.OK, MessageBoxImage.Warning);
            }
            else
            {
                _categories.RemoveAt(ltbCategories.SelectedIndex);

                Categorie.ReecrirefCategories();
            }
        }

        /// <summary>
        /// Fonction qui va ouvrir la fenêtre pour le troisième onglet.
        /// </summary>
        /// <param name="sender">L'expéditeur</param>
        /// <param name="e">L'événement</param>
        private void btnOnglet3_Click(object sender, RoutedEventArgs e)
        {
            Tab3 onglet3 = new Tab3();
            onglet3.Show();
        }
    }
}