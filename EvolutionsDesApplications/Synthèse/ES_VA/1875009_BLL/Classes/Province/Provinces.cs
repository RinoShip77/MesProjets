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
    public class Provinces
    {
        //Collection statique pour pouvoir ajouter ou supprimer sur la même ObservableCollection dans toute l'application
        public static ObservableCollection<Province> provinces = new ObservableCollection<Province>();

        public static void LoadProvincesList()
        {
            //On crée une variable pour la table
            DataTable dt = TableProvinces.ConnectTableProvinces();

            //On crée une liste temporaire pour contenir les données de la table
            var provincesList = new ObservableCollection<Province>();

            //Parcourir tous les enregistrements de la table provinces
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                var province = new Province
                {
                    NomProvince = dt.Rows[i]["nomProvince"].ToString(),
                    Capitale = dt.Rows[i]["capitale"].ToString(),
                    Superficie = int.Parse(dt.Rows[i]["superficie"].ToString()),
                    Population = int.Parse(dt.Rows[i]["population"].ToString())
                };
                provincesList.Add(province);
            }

            provinces = provincesList;
        }
    }
}
