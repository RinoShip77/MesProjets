using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Navigation;
using System.Windows.Shapes;

namespace TP1_Base_Prof
{
    /// <summary>
    /// Logique d'interaction pour ModifyScheduleWindow.xaml
    /// </summary>
    public partial class ModifyScheduleWindow : Window
    {
        private readonly Cours _cours;
        // Replace default constructor by adding parameter if window can only be opened with data
        public ModifyScheduleWindow()
        {
            InitializeComponent();

         
            SessionComboBox.Items.Clear();
            foreach (var cours in App.Current.Cours)
            {
                SessionComboBox.Items.Add(cours.Semester); // Ajoute la session à laquelle il est associé
            }

            LocalComboBox.Items.Clear();
            foreach (var cours in App.Current.Cours)
            {
                LocalComboBox.Items.Add(cours.Local); // Ajoute le local à lequel il est associé
            }

            CoursComboBox.Items.Clear();
            foreach (var cours in App.Current.Cours)
            {
                CoursComboBox.Items.Add(cours); // Ajoute le cours à lequel il est associé
                _cours = cours;
            }

         
         //if (Monday1.IsChecked == true)
         //{
         //   Tuesday1.IsChecked = false;
         //   Tuesday2.IsChecked = false;
         //   Tuesday3.IsChecked = false;
         //   Tuesday4.IsChecked = false;
         //   Tuesday5.IsChecked = false;
         //   Tuesday6.IsChecked = false;
         //   Tuesday7.IsChecked = false;
         //   Tuesday8.IsChecked = false;
         //   Tuesday9.IsChecked = false;
         //   Tuesday10.IsChecked = false;
         //   Tuesday11.IsChecked = false;
         //   Wednesday1.IsChecked = false;
         //   Wednesday2.IsChecked = false;
         //   Wednesday3.IsChecked = false;
         //   Wednesday4.IsChecked = false;            
         //   Wednesday8.IsChecked = false;
         //   Wednesday9.IsChecked = false;
         //   Wednesday10.IsChecked = false;
         //   Wednesday11.IsChecked = false;
         //   Thursday1.IsChecked = false;
         //   Thursday2.IsChecked = false;
         //   Thursday3.IsChecked = false;
         //   Thursday4.IsChecked = false;
         //   Thursday5.IsChecked = false;
         //   Thursday6.IsChecked = false;
         //   Thursday7.IsChecked = false;
         //   Thursday8.IsChecked = false;
         //   Thursday9.IsChecked = false;
         //   Thursday10.IsChecked = false;
         //   Thursday11.IsChecked = false;
         //   Friday1.IsChecked = false;
         //   Friday2.IsChecked = false;
         //   Friday3.IsChecked = false;
         //   Friday4.IsChecked = false;
         //   Friday5.IsChecked = false;
         //   Friday6.IsChecked = false;
         //   Friday7.IsChecked = false;
         //   Friday8.IsChecked = false;
         //   Friday9.IsChecked = false;
         //   Friday10.IsChecked = false;
         //   Friday11.IsChecked = false;
         //}
         
        }

        private void AddButton_Click(object sender, RoutedEventArgs e)
        {
            

            Close();
        }
        
        private void DeleteButton_Click(object sender, RoutedEventArgs e)
        {
            MessageBox.Show("Supprimer une leçon -> TODO");

            Close();
        }
    }
}
