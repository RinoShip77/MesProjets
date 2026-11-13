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
    public class AccessDB
    {
        //Se connecte à la base de données et retourne la table portant le nom passé en paramètre
        public static DataTable ConnectDB(string tableName)
        {
            //Établie la connexion
            MySqlConnection conn = new MySqlConnection("SERVER=localhost;DATABASE=donneesventes;UID=root;PASSWORD=;");

            try
            {
                conn.Open();
                MySqlCommand cmd = new MySqlCommand("Select * FROM " + tableName + "", conn);

                //Applique la ligne de commande sur la table
                MySqlDataAdapter adp = new MySqlDataAdapter(cmd);

                DataSet ds = new DataSet();
                adp.Fill(ds, tableName);
                var dt = ds.Tables[tableName];

                //Retourne la table
                return dt;
            }
            catch (MySqlException ex)
            {
                Debug.WriteLine(ex.ToString());
                return null;
            }
            finally
            {
                conn.Close();
            }
        }
    }
}
