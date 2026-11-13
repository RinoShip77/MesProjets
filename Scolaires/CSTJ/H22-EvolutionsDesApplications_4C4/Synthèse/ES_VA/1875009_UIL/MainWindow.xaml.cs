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

namespace _1875009_UIL
{
    /// <summary>
    /// Logique d'interaction pour MainWindow.xaml
    /// </summary>
    public partial class MainWindow : Window
    {
        public UserControl ContenuEcran { get; set; }

        //Instantion d'objets du type de nos différents UserControl
        public UCAccueil EcranAccueil = new UCAccueil();
        public UCListerLesVentes EcranListerVentes = new UCListerLesVentes();
        public UCVentesParProvince EcranVentesProvince = new UCVentesParProvince();
        public UCEvolutionVentes EcranEvolutionVentes = new UCEvolutionVentes();

        public MainWindow()
        {
            InitializeComponent();

            //Chargement du UserControl UCAccueil dans la fenêtre principale MainWindow
            ContenuEcran = EcranAccueil;
            Grid.SetRow(ContenuEcran, 0);
            Grid.SetColumn(ContenuEcran, 0);

            //Ajoute l'écran dans la grille de MainWindow
            gPrincipal.Children.Add(ContenuEcran);
        }

        private void mniListeVentes_Click(object sender, RoutedEventArgs e)
        {
            //Déchargement du UserControl actuellement présent dans la fenêtre principale MainWindow
            MainWindow mw = (MainWindow)Application.Current.MainWindow;
            mw.gPrincipal.Children.Remove(mw.ContenuEcran);

            //Chargement de UCListerLesVentes dans MainWindow
            mw.ContenuEcran = EcranListerVentes;
            Grid.SetRow(mw.ContenuEcran, 0);
            mw.gPrincipal.Children.Add(mw.ContenuEcran);
        }

        private void mniVentesProvince_Click(object sender, RoutedEventArgs e)
        {
            //Déchargement du UserControl actuellement présent dans la fenêtre principale MainWindow
            MainWindow mw = (MainWindow)Application.Current.MainWindow;
            mw.gPrincipal.Children.Remove(mw.ContenuEcran);

            //Chargement de UCVentesParProvinces dans MainWindow
            mw.ContenuEcran = EcranVentesProvince;
            Grid.SetRow(mw.ContenuEcran, 0);
            mw.gPrincipal.Children.Add(mw.ContenuEcran);
        }

        private void mniEvolutionVentes_Click(object sender, RoutedEventArgs e)
        {
            //Déchargement du UserControl actuellement présent dans la fenêtre principale MainWindow
            MainWindow mw = (MainWindow)Application.Current.MainWindow;
            mw.gPrincipal.Children.Remove(mw.ContenuEcran);

            //Chargement de UCEvolutionVentes dans MainWindow
            mw.ContenuEcran = EcranEvolutionVentes;
            Grid.SetRow(mw.ContenuEcran, 0);
            mw.gPrincipal.Children.Add(mw.ContenuEcran);
        }

        private void mniFermer_Click(object sender, RoutedEventArgs e)
        {
            //Affiche un boîte de dialogue pour s'assurer que l'utilisateur veut quitter
            if(MessageBox.Show("Voulez-vous vraiment quitter notre applications?", "Quitter!?", MessageBoxButton.YesNo) == MessageBoxResult.Yes)
            {
                Close();
            }
        }
    }
}
