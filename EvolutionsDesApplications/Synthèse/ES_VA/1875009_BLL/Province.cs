using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.ComponentModel;
using _1875009_DAL;

namespace _1875009_BLL
{
    public class Province : INotifyPropertyChanged
    {
        public event PropertyChangedEventHandler PropertyChanged;
        public void NotifyPropertyCanged(string propName)
        {
            if (this.PropertyChanged != null)
            {
                PropertyChanged(this, new PropertyChangedEventArgs(propName));
            }
        }

        private string nomProvince;
        public string NomProvince
        {
            get
            {
                return nomProvince;
            }
            set
            {
                if (this.nomProvince != value)
                {
                    this.nomProvince = value;
                    this.NotifyPropertyCanged("NomProvince");
                }
            }
        }

        private string capitale;
        public string Capitale
        {
            get
            {
                return capitale;
            }
            set
            {
                if (this.capitale != value)
                {
                    this.capitale = value;
                    this.NotifyPropertyCanged("capitale");
                }
            }
        }

        private double superficie;
        public double Superficie
        {
            get
            {
                return superficie;
            }
            set
            {
                if (this.superficie != value)
                {
                    this.superficie = value;
                    this.NotifyPropertyCanged("Superficie");
                }
            }
        }

        private double population;
        public double Population
        {
            get
            {
                return population;
            }
            set
            {
                if (this.population != value)
                {
                    this.population = value;
                    this.NotifyPropertyCanged("Population");
                }
            }
        }

        public Province(string nomProvince, string capitale, double superficie, double population)
        {
            NomProvince = nomProvince;
            Capitale = capitale;
            Superficie = superficie;
            Population = population;
        }
    }
}
