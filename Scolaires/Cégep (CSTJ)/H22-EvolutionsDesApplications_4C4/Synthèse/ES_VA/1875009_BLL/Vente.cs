using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.ComponentModel;
using _1875009_DAL;

namespace _1875009_BLL
{
    public class Vente : INotifyPropertyChanged
    {
        public event PropertyChangedEventHandler PropertyChanged;
        public void NotifyPropertyCanged(string propName)
        {
            if (this.PropertyChanged != null)
            {
                PropertyChanged(this, new PropertyChangedEventArgs(propName));
            }
        }

        private string province;
        public string Province
        {
            get
            {
                return province;
            }
            set
            {
                if (this.province != value)
                {
                    this.province = value;
                    this.NotifyPropertyCanged("Province");
                }
            }
        }


        private string typeVeh;
        public string TypeVeh
        {
            get
            {
                return typeVeh;
            }
            set
            {
                if (this.typeVeh != value)
                {
                    this.typeVeh = value;
                    this.NotifyPropertyCanged("TypeVeh");
                }
            }
        }


        private int annee;
        public int Annee
        {
            get
            {
                return annee;
            }
            set
            {
                if (this.annee != value)
                {
                    this.annee = value;
                    this.NotifyPropertyCanged("Annee");
                }
            }
        }


        private double nbunites;
        public double NbUnites
        {
            get
            {
                return nbunites;
            }
            set
            {
                if (this.nbunites != value)
                {
                    this.nbunites = value;
                    this.NotifyPropertyCanged("NbUnites");
                }
            }
        }


        private double mntx1000;
        public double Mntx1000
        {
            get
            {
                return mntx1000;
            }
            set
            {
                if (this.mntx1000 != value)
                {
                    this.mntx1000 = value;
                    this.NotifyPropertyCanged("Mntx1000");
                }
            }
        }

        public Vente(string province, string typeVeh, int annee, double nbunites, double mntx1000)
        {
            Province = province;
            TypeVeh = typeVeh;
            Annee = annee;
            NbUnites = nbunites;
            Mntx1000 = mntx1000;
        }

        public double PrixMoyen(Vente vente)
        {
            return vente.Mntx1000 / vente.NbUnites;
        }
    }
}
