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
    /// Logique d'interaction pour UCVentesParProvince.xaml
    /// </summary>
    public partial class UCVentesParProvince : UserControl
    {
        public UCVentesParProvince()
        {
            InitializeComponent();

            //Remplissage de la collection en appelant la classe Vehicules
            Vehicules.LoadVehiculesList();

            //Remplissage de la collection en appelant la classe Ventes
            Ventes.LoadVentesList();

            //Chargements des données de la liste dans le ListBox
            ltbProvinceSomme.ItemsSource = Ventes.ventes
                .GroupBy(vente => vente.Province)
                .Select(_vente => new Vente
                    {
                        Province = _vente.First().Province,
                        SommeMntx1000 = _vente.Sum(province => province.Mntx1000),
                    });
            

            //Remplissage du ComboBox des années de début
            cboAnneeDebut.ItemsSource = Ventes.ventes.GroupBy(vente => vente.Annee);

            //Remplissage du ComboBox pour le type de véhicule à partir de la collections de ce type
            cboTypeVeh.ItemsSource = Vehicules.vehicules;
        }

        private void cboAnneeDebut_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            //Remplissage du ComboBox des années de fin selon la sélection de l'année de départ
            try
            {
                if (cboAnneeDebut.SelectedItem != null)
                {
                    int index = cboAnneeDebut.SelectedIndex;

                    //Crée une liste vide de ventes temporaires
                    List<Vente> _ventes = new List<Vente>();

                    //Parcours chaque élément de la liste principale des ventes
                    foreach (Vente vente in Ventes.ventes)
                    {
                        //Si l'année de l'objet actuelle est supérieur ou égale à celle sélectionnée par l'utilisateur, ...
                        if (vente.Annee >= Ventes.ventes[index].Annee)
                        {
                            //On l'ajoute à la liste temporaire
                            _ventes.Add(vente);
                        }
                    }
                    //On initialise la liste de données pour ce ComboBox avec la liste temporaire
                    cboAnneeFin.ItemsSource = _ventes.GroupBy(vente => vente.Annee);
                }
            }
            catch (Exception) { }
        }

        private void btnValider_Click(object sender, RoutedEventArgs e)
        {
            try
            {
                int indexAnneeDebut = cboAnneeDebut.SelectedIndex;
                int indexAnneeFin = cboAnneeFin.SelectedIndex;
                int indexTypeVehicule = cboTypeVeh.SelectedIndex;

                //Va ordonner la liste selon les critère de l'utilisateur
                ltbProvinceSomme.ItemsSource = new ObservableCollection<Vente>(Ventes.ventes
                    .Where(vente => vente.Annee >= Ventes.ventes[indexAnneeDebut].Annee)
                    .Where(vente => vente.Annee <= Ventes.ventes[indexAnneeFin].Annee)
                    .Where(vente => vente.TypeVeh == Vehicules.vehicules[indexTypeVehicule].TypeVehicule));
            }
            catch (Exception) { }
        }
    }
}
