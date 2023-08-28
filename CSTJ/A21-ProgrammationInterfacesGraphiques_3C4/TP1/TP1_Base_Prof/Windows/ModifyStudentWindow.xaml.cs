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
    /// Logique d'interaction pour ModifyStudentWindow.xaml
    /// </summary>
    public partial class ModifyStudentWindow : Window
    {
        // Replace default constructor by adding parameter if window can only be opened with data
        public ModifyStudentWindow()
        {
            InitializeComponent();

            // Get values in project by using App.Current properties
            StudentListView.Items.Clear();
            foreach (var student in App.Current.Students.Values)
            {
                StudentListView.Items.Add(student);
            }
        }

        private void AddButton_Click(object sender, RoutedEventArgs e)
        {
            Close();
            var window = new AddStudentWindow();
            window.Show();
        }

        private void DeleteButton_Click(object sender, RoutedEventArgs e)
        {
            //Supprime l'étudiant sélectionné
            Student student = (Student)StudentListView.SelectedValue;
            if (student != null)
            {
                MessageBox.Show($"Voulez-vous supprimer l'étudiant {student} ?", "Supprimer l'étudiant", MessageBoxButton.YesNo);
                App.Current.Students.Remove(student.Id);
                MessageBox.Show("L'étudiant a été supprimé", "Supprimer", MessageBoxButton.OK);
                Close();
            }
        }

        private void UserTextBox_TextChanged(object sender, TextChangedEventArgs e)
        {
            StudentListView.Items.Clear();
            foreach (var student in App.Current.Students.Values)
            {
                if (student.FirstName.Contains(UserTextBox.Text) || student.LastName.Contains(UserTextBox.Text) || Convert.ToString(student.Id).Contains(UserTextBox.Text))
                {
                    StudentListView.Items.Add(student);
                }
            }
        }
    }
}