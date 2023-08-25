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
    public class Ventes
    {
        //Collection statique pour pouvoir ajouter ou supprimer sur la même ObservableCollection dans toute l'application
        public static ObservableCollection<Vente> ventes = new ObservableCollection<Vente>();

        public static void LoadVentesList()
        {
            //On crée une variable pour la table
            DataTable dt = TableVentes.ConnectTableVentes();

            //On crée une liste temporaire pour contenir les données de la table
            var ventesList = new ObservableCollection<Vente>();

            //Parcourir tous les enregistrements de la table ventes
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                var vente = new Vente
                {
                    Province = dt.Rows[i]["Province"].ToString(),
                    TypeVeh = dt.Rows[i]["TypeVeh"].ToString(),
                    Annee = int.Parse(dt.Rows[i]["Annee"].ToString()),
                    NbUnites = int.Parse(dt.Rows[i]["NbUnites"].ToString()),
                    Mntx1000 = int.Parse(dt.Rows[i]["Mntx1000"].ToString())
                };
                ventesList.Add(vente);
            }

            ventes = ventesList;
        }
    }
}
