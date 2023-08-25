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
    /// Logique d'interaction pour AdministrationWindow.xaml
    /// </summary>
    public partial class AdministrationWindow : Window
    {
        public AdministrationWindow()
        {
            InitializeComponent();
        }

        private void StudentButton_Click(object sender, RoutedEventArgs e)
        {
            var window = new ModifyStudentWindow();
            window.Show();
        }

        private void TeacherButton_Click(object sender, RoutedEventArgs e)
        {
            var window = new ModifyTeacherWindow();
            window.Show();
        }

        private void ScheduleButton_Click(object sender, RoutedEventArgs e)
        {
            var window = new ModifyScheduleWindow();
            window.Show();
        }

        private void QuitButton_Click(object sender, RoutedEventArgs e)
        {
            // Ferme toutes les 'Windows' et retourne à 'LogonWindow'
            var window = new LogonWindow();
            window.Show();

            for (int i = App.Current.Windows.Count - 1; i >= 0; i--)
            {
                if (App.Current.Windows[i] != window)
                {
                    App.Current.Windows[i].Close();
                }
            }
        }
    }
}
