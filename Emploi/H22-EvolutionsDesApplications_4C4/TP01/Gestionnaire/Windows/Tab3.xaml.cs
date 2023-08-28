// ------------------------------------------------
// Projet:   Gestionnaire
// Cours:    420-4C4-JR
// Fichier:  Tab3.xaml.cs
// Auteur:   Olivier Bourgault
// Date:     2022-04-02
// ------------------------------------------------

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
using System.Windows.Shapes;
using System.Diagnostics;
using System.Windows.Navigation;

namespace Gestionnaire
{
    /// <summary>
    /// Logique d'interaction pour Onglet3.xaml
    /// </summary>
    public partial class Tab3 : Window
    {
        /// <summary>
        /// Initialise la vue et déclare le constructeur de la classe.
        /// </summary>
        public Tab3()
        {
            InitializeComponent();
        }

        /// <summary>
        /// Fonction qui permet d'avoir un hyperlien fonctionnel pour naviguer sur internet.
        /// </summary>
        /// <param name="sender">L'expéditeur</param>
        /// <param name="e">L'événement</param>
        private void hlkSite_RequestNavigate(object sender, RequestNavigateEventArgs e)
        {
            Process.Start(new ProcessStartInfo(e.Uri.AbsoluteUri) { UseShellExecute = true });
            e.Handled = true;
        }
    }
}
