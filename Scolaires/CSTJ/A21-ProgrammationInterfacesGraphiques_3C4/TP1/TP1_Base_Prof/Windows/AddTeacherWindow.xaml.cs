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
    public partial class AddTeacherWindow : Window
    {
        public AddTeacherWindow()
        {
            InitializeComponent();

            MaxId(); //Trouver le plus grand Id et L'Id suivant comme valeur par défaut
        }

        private void AddButton_Click(object sender, RoutedEventArgs e)
        {
            try
            {
                //Vérifier si l'Id est vide 
                if (IdTextBox.Text == "")
                {
                    IdTextBox.Text = "0";
                }
                //Vérifer si le prénom est vide 
                if (FirstNameTextBox.Text == "")
                {
                    MessageBox.Show("Le prénom ne doit pas être vide.", "Erreur", MessageBoxButton.OK);
                }
                else
                {
                    //Vérifer si le nom est vide
                    if (LastNameTextBox.Text == "")
                    {
                        MessageBox.Show("Le nom ne doit pas être vide.", "Erreur", MessageBoxButton.OK);
                    }
                    else
                    {
                        //Vérifier si l'Id existe
                        if (IsFind())
                        {
                            MessageBox.Show("L'étudiant avec l'identifiant " + IdTextBox.Text + " existe déjà.", "Erreur", MessageBoxButton.OK);
                        }
                        else
                        {
                            MessageBox.Show("Voulez-vous ajouter l'étudiant '" + IdTextBox.Text + "' - " + FirstNameTextBox.Text + ", " + LastNameTextBox.Text + " ?", "Ajouter nouvel étudiant", MessageBoxButton.YesNo);
                            //Les informations sont valides on crée un nouvel étudiant
                            App.Current.Teachers.Add(Convert.ToInt32(IdTextBox.Text), new Teacher()
                            { Id = Convert.ToInt32(IdTextBox.Text), FirstName = FirstNameTextBox.Text, LastName = LastNameTextBox.Text, Password = CreatePassword() });
                            Close();
                            var window = new ModifyTeacherWindow();
                            window.Show();
                        }
                    }
                }
            }
            catch (Exception)
            {

            }
        }

        private string CreatePassword()
        {
            //Crée un mot de passe par défaut       
            //Prendre la première lettre du prénom et le nom de famille complet (en minuscule)
            return FirstNameTextBox.Text.ToLower()[0] + LastNameTextBox.Text.ToLower();
        }

        private void MaxId()
        {
            int IdMax = 0;
            foreach (var teacher in App.Current.Teachers.Values)
            {
                if (IdMax < teacher.Id)
                {
                    IdMax = teacher.Id;
                }
            }
            //Retourne le plus grand Id + 1
            IdTextBox.Text = Convert.ToString(IdMax + 1);
        }

        private bool IsFind()
        {
            //Vérifier si l'Id existe déjà
            foreach (var teacher in App.Current.Teachers.Values)
            {
                if (IdTextBox.Text == Convert.ToString(teacher.Id))
                {
                    return true;
                }
            }
            return false;
        }

        private void CancelButton_Click(object sender, RoutedEventArgs e)
        {
            Close();
            var window = new ModifyTeacherWindow();
            window.Show();
        }
    }
}
