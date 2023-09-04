//Olivier Bourgault: 1875009

using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using _1875009_DAL;
using System.Collections.ObjectModel;
using System.Data;

namespace _1875009_BLL
{
    public class Vehicules
    {
        //Collection statique pour pouvoir ajouter ou supprimer sur la même ObservableCollection dans toute l'application
        public static ObservableCollection<Vehicule> vehicules = new ObservableCollection<Vehicule>();

        public static void LoadVehiculesList()
        {
            //On crée une variable pour la table
            DataTable dt = TableVehicules.ConnectTableVehicules();

            //On crée une liste temporaire pour contenir les données de la table
            var vehiculesList = new ObservableCollection<Vehicule>();

            //Parcourir tous les enregistrements de la table vehicules
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                var vehicule = new Vehicule
                {
                    TypeVehicule = dt.Rows[i]["typeVehicule"].ToString()
                };
                vehiculesList.Add(vehicule);
            }

            vehicules = vehiculesList;
        }
    }
}
