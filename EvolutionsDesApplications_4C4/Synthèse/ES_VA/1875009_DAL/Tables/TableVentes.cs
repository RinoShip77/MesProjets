//Olivier Bourgault: 1875009

using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data;
using MySql.Data.MySqlClient;
using System.Diagnostics;

namespace _1875009_DAL
{
    public class TableVentes
    {
        //Fonction qui va appeler la méthode pour se connecter à la base de données selon la table voulue
        public static DataTable ConnectTableVentes()
        {
            return AccessDB.ConnectDB("ventes");
        }
    }
}
