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
using _1875009_BLL;
using System.Collections.ObjectModel;
using LiveCharts;   //Pour utiliser la bibliothèque
using LiveCharts.Wpf;   //Pour accéder aux outils pour les graphiques

namespace _1875009_UIL
{
    /// <summary>
    /// Logique d'interaction pour UCEvolutionVentes.xaml
    /// </summary>
    public partial class UCEvolutionVentes : UserControl
    {
        public SeriesCollection SC { get; set; }

        public string[] Annees { get; set; }
        public UCEvolutionVentes()
        {
            InitializeComponent();

            //Remplissage de la collection en appelant la classe Vehicules
            Vehicules.LoadVehiculesList();

            //Remplissage de la collection en appelant la classe Ventes
            Ventes.LoadVentesList();

            //Chargements des données pour remplir la liste des provinces
            cboProvince.ItemsSource = Ventes.ventes.GroupBy(vente => vente.Province);

            //Chargements des données pour remplir la liste des types de vehicules
            cboTypeVeh.ItemsSource = Ventes.ventes.GroupBy(vente => vente.TypeVeh);

            //Initialisation du graphique
            var _prixMoyens = new ChartValues<double>();

            foreach (Vente vente in Ventes.ventes)
            {
                if(vente.PrixMoyen() != double.NaN)
                {
                    _prixMoyens.Add(vente.PrixMoyen());
                }
            }

            foreach (var item in _prixMoyens)
            {
                Console.WriteLine(item);
            }

            SC = new SeriesCollection
            {
                new ColumnSeries
                {
                    Title = "Prix moyens de vente",
                    //Values = _prixMoyens
                    Values = new ChartValues<double> {14826, 21365, 28413, 50052, 78630}
                }
            };

            //Création d'une liste temporaire
            List<string> _annees = new List<string>();

            foreach (Vente vente in Ventes.ventes)
            {
                _annees.Add(vente.Annee.ToString());
            }

            //Assignsation de la liste de chaînes de caractères au tableau des années
            Annees = _annees.Distinct().ToArray();

            //On précise le contexte des données
            DataContext = this;
        }

        private void cboProvince_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            lvcGraphique.Update();
        }

        private void cboTypeVeh_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            lvcGraphique.Update();
        }
    }
}
