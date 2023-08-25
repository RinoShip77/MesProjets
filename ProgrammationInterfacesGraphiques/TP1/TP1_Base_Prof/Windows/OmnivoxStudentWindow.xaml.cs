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
    public partial class OmnivoxStudentWindow : Window
    {
        private readonly Student _student;

        // Replace default constructor by adding parameter if window can only be opened with data
        public OmnivoxStudentWindow(Student student)
        {
            InitializeComponent();

            //IdLabel.Content = student.Id;
            //PasswordLabel.Content = student.Password;
            FirstNameLabel.Content = student.FirstName;
            LastNameLabel.Content = student.LastName;

            //On conserve l'étudiant de la fenêtre
            _student = student;

            // Prendre les valeurs du dictionnaires de cours dans la proprité de l'application courante
            SessionsComboBox.Items.Clear();
            foreach (var cours in App.Current.Cours)
            {
                if (cours.StudentIds.Contains(student.Id))
                {
                    SessionsComboBox.Items.Add(cours.Semester); // Ajoute la session à laquelle il est associé
                }
            }

            CourseListView.SelectionChanged += CoursListView_SelectionChanged;
            // Prendre les valeurs du dictionnaires de cours dans la proprité de l'application courante
            CourseListView.Items.Clear();
            foreach (var cours in App.Current.Cours)
            {
                CourseListView.Items.Add(cours);
            }
        }

        private void CoursListView_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            var cours = CourseListView.SelectedItem as Cours;
            if (cours != null)
            {
                var window = new CourseDetailStudentWindow(cours, _student);
                window.Show();
            }
        }

        private void Hyperlink_RequestNavigate(object sender, RequestNavigateEventArgs e)
        {
            Process.Start(new ProcessStartInfo(e.Uri.AbsoluteUri));
            e.Handled = true;
        }

        private void AcountButton_Click(object sender, RoutedEventArgs e)
        {
            MessageBox.Show("TODO");

            Close();
        }

        private void QuitButton_Click(object sender, RoutedEventArgs e)
        {            
            var window = new LogonWindow();
            window.Show();
            Close();
        }

        private void ScheduleToggleButton_Click(object sender, RoutedEventArgs e)
        {
            MessageBox.Show("TODO");
        }

        private void ChangeToggleButton_Click(object sender, RoutedEventArgs e)
        {        
            var window = new ChangePasswordWindow(_student);
            window.Show();
        }

        private void ResetToggleButton_Click(object sender, RoutedEventArgs e)
        {
            var window = new ResetPasswordWindow();
            window.Show();
        }
    }
}
