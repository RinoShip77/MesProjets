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

namespace _1875009_UIL
{
    /// <summary>
    /// Logique d'interaction pour UCListerLesVentes.xaml
    /// </summary>
    public partial class UCListerLesVentes : UserControl
    {
        public UCListerLesVentes()
        {
            InitializeComponent();

            //Remplissage de la collection en appelant la classe Ventes
            Ventes.LoadVentesList();

            //Chargements des données de la liste dans le DataGrid
            dgVentes.ItemsSource = Ventes.ventes;
        }        

        private void cboTrier_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            //Appel la méthode de trie selon l'élément choisi dans le ComboBox
            dgSortDescending(cboTrier.SelectedItem.ToString().Split(':')[1].Trim());
        }

        private void dgSortDescending(string trie)
        {
            switch (trie)
            {
                case "Année":
                    //Remet à jour la liste des items du DataGrid pour qui soient triées selon l'année en ordre décroissant
                    dgVentes.ItemsSource = new ObservableCollection<Vente>(Ventes.ventes.OrderByDescending(vente => vente.Annee));
                    break;

                case "Nombre d'unités":
                    //Remet à jour la liste des items du DataGrid pour qui soient triées selon le nombre d'unitée en ordre décroissant
                    dgVentes.ItemsSource = new ObservableCollection<Vente>(Ventes.ventes.OrderByDescending(vente => vente.NbUnites));
                    break;

                case "Prix moyen de vente":
                    //Remet à jour la liste des items du DataGrid pour qui soient triées selon le prix moyen de vente en ordre décroissant
                    dgVentes.ItemsSource = new ObservableCollection<Vente>(Ventes.ventes.OrderByDescending(vente => vente.PrixMoyen()));
                    break;

                default:
                    //Si la sélection ne correspond à aucun des choix, on réaffecte simplement la liste des ventes qui n'est pas trié
                    dgVentes.ItemsSource = Ventes.ventes;
                    break;
            }
        }
    }
}
