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
    /// Logique d'interaction pour ModifyTeacherWindow.xaml
    /// </summary>
    public partial class ModifyTeacherWindow : Window
    {
        // Replace default constructor by adding parameter if window can only be opened with data
        public ModifyTeacherWindow()
        {
            InitializeComponent();

            // Get values in project by using App.Current properties
            TeacherListView.Items.Clear();
            foreach (var teacher in App.Current.Teachers.Values)
            {
                TeacherListView.Items.Add(teacher);
            }
        }

        private void AddButton_Click(object sender, RoutedEventArgs e)
        {
            Close();
            var window = new AddTeacherWindow();
            window.Show();
        }

        private void DeleteButton_Click(object sender, RoutedEventArgs e)
        {
            //Supprime l'enseignant sélectionné
            Teacher teacher = (Teacher)TeacherListView.SelectedValue;
            if (teacher != null)
            {
                MessageBox.Show($"Voulez-vous supprimer l'enseignant {teacher} ?", "Supprimer l'enseignant", MessageBoxButton.YesNo);
                App.Current.Teachers.Remove(teacher.Id);
                MessageBox.Show("L'enseignant a été supprimé", "Supprimer", MessageBoxButton.OK);
                Close();
            }
        }

        private void UserTextBox_TextChanged(object sender, TextChangedEventArgs e)
        {
            TeacherListView.Items.Clear();
            foreach (var teacher in App.Current.Teachers.Values)
            {
                if (teacher.FirstName.Contains(UserTextBox.Text) || teacher.LastName.Contains(UserTextBox.Text) || Convert.ToString(teacher.Id).Contains(UserTextBox.Text))
                {
                    TeacherListView.Items.Add(teacher);
                }
            }
        }
    }
}
