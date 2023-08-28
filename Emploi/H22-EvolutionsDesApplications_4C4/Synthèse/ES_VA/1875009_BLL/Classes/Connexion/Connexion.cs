//Olivier Bourgault: 1875009

using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace _1875009_BLL
{
    //Classe qui utilise le patron de conception 'Singleton'
    public class Connexion
    {
        public string Id { get; set; }
        public string Passwd { get; set; }

        private static Connexion instance;        

        //Constructeur privé
        private Connexion() { }

        //Méthode static
        public static Connexion GetInstance()
        {
            //Si on a pas encore créé une instance, alors on l'a crée
            if (Connexion.instance == null)
            {
                Connexion.instance = new Connexion();
            }

            return instance;
        }
    }
}
