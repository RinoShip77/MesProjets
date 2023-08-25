//Olivier Bourgault: 1875009

using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.ComponentModel;
using _1875009_DAL;

namespace _1875009_BLL
{
    public class Vehicule : INotifyPropertyChanged
    {
        //Va s'assurer de notifier lorsque l'on fait des changements
        public event PropertyChangedEventHandler PropertyChanged;
        public void NotifyPropertyCanged(string propName)
        {
            if (this.PropertyChanged != null)
            {
                PropertyChanged(this, new PropertyChangedEventArgs(propName));
            }
        }

        private string typeVehicule;
        public string TypeVehicule
        {
            get
            {
                return typeVehicule;
            }
            set
            {
                if (this.typeVehicule != value)
                {
                    this.typeVehicule = value;
                    this.NotifyPropertyCanged("NomProvince");
                }
            }
        }

        //Constructeur paramétrés
        public Vehicule(string typeVehicule)
        {
            TypeVehicule = typeVehicule;
        }

        public Vehicule() { }
    }
}
