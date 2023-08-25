//Olivier Bourgault: 1875009

using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.ComponentModel;
using Newtonsoft.Json;
using System.IO;
using System.Collections.ObjectModel;

namespace _1875009_BLL
{
    public class Connexions
    {
        //Collection statique pour pouvoir ajouter ou supprimer sur la même ObservableCollection dans toute l'application
        public static ObservableCollection<Connexion> connexions = new ObservableCollection<Connexion>();

        public static void ChargerFicher()
        {
            StreamReader fichierConnexions;
            string json;

            //Ouvre le fichier de données
            fichierConnexions = new StreamReader(File.OpenRead("connexion.json"));

            //Lit une ligne du fichier
            json = fichierConnexions.ReadLine();

            //Ferme le fichier
            fichierConnexions.Close();

            //Transforme le ficher JSON en objet de type Connexion et les traduient pour les ajouter à la collection observable de connexions
            connexions = JsonConvert.DeserializeObject<ObservableCollection<Connexion>>(json);
        }
    }
}
