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
    public partial class ResetPasswordWindow : Window
    {
        public ResetPasswordWindow()
        {
            InitializeComponent();
        }

        private void ResetButton_Click(object sender, RoutedEventArgs e)
        {
            bool isFind = false; //L'utilisateur n'est pas trouvé au départ
            if (MessageBox.Show("Voulez-vous réinitialiser le mot de passe, l'ancien mot de passe sera perdu!", "Réinitialiser mot de passe", MessageBoxButton.YesNo) == MessageBoxResult.Yes)
            {
                //L'utilisateur veut changer le mot de passe
                //Vérifier si c'est un étudiant
                foreach (var student in App.Current.Students.Values)
                {
                    //Si l'étudiant existe
                    if (IdTextBox.Text == Convert.ToString(student.Id) && FirstNameTextBox.Text == student.FirstName && LastNameTextBox.Text == student.LastName)
                    {
                        //Mettre un mot de passe par défaut pour l'utilisateur trouvé
                        //Prendre la première lettre du prénom et le nom de famille complet (en minuscule)
                        student.Password = student.FirstName.ToLower()[0] + student.LastName.ToLower();
                        isFind = true; //Un étudiant a été trouvé
                    }
                }
                //Vérifier si c'est un enseignant
                foreach (var teacher in App.Current.Teachers.Values)
                {
                    //Si l'enseignant existe
                    if (IdTextBox.Text == Convert.ToString(teacher.Id) && FirstNameTextBox.Text == teacher.FirstName && LastNameTextBox.Text == teacher.LastName)
                    {
                        //Mettre un mot de passe par défaut pour l'utilisateur trouvé
                        //Prendre la première lettre du prénom et le nom de famille complet (en minuscule)
                        teacher.Password = teacher.FirstName.ToLower()[0] + teacher.LastName.ToLower();
                        isFind = true; //Un enseignant a été trouvé
                    }
                }
                //Si aucun utilisateur n'est trouvé
                if (!isFind)
                {
                    MessageBox.Show("Une des informations fournie est érronée", "Erreur", MessageBoxButton.OK);
                }
            }
            else
            {
                //L'utilisateur ne veut pas changer le mot de passe           
            }
        }

        private void CancelButton_Click(object sender, RoutedEventArgs e)
        {
            Close();
        }
    }
}
