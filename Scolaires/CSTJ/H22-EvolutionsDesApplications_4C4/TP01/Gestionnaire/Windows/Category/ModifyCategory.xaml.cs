// ------------------------------------------------
// Projet:   Gestionnaire
// Cours:    420-4C4-JR
// Fichier:  ModifyCategory.xaml.cs
// Auteur:   Olivier Bourgault
// Date:     2022-04-15
// ------------------------------------------------

using System;
using System.Windows;

namespace Gestionnaire
{
    /// <summary>
    /// Logique d'interaction pour ModifyCategory.xaml
    /// </summary>
    public partial class ModifyCategory : Window
    {
        private Categorie cat;

        /// <summary>
        /// L’application doit s’assurer qu’il n’y a pas déjà
        /// une catégorie qui porte le même nom avant de faire
        /// la modification.
        /// </summary>

        /// <summary>
        /// Initialise la vue et déclare le constructeur de la classe.
        /// </summary>
        public ModifyCategory(Categorie categorie)
        {
            InitializeComponent();

            this.cat = categorie;
            lblNomCategorie.Content = "Modification de la catégorie " + categorie.Nom + ":";
        }

        /// <summary>
        /// Fonction qui va se déclancher sur l'appui du bouton 'OK' de la fenêtre.
        /// Il permettra la modification de la catégorie.
        /// </summary>
        /// <param name="sender">l'expéditeur</param>
        /// <param name="e">l'événement</param>
        private void btnOK_Click(object sender, RoutedEventArgs e)
        {
            try
            {
                foreach (Categorie categorie in PrincipalManager._categories)
                {
                    if (categorie.Nom != txbNomCategorie.Text)
                    {
                        PrincipalManager._categories.Remove(cat);
                        PrincipalManager._categories.Add(new Categorie(txbNomCategorie.Text));
                        Categorie.ReecrirefCategories();
                    }
                }
            }
            catch (Exception) { }

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
