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
    public partial class AddResultWindow : Window
    {
        private readonly Evaluation _evaluation;
        private readonly int _result;
        public AddResultWindow(Evaluation evaluation)
        {
            InitializeComponent();

            _evaluation = evaluation;

            if (ResultTextBox.Text == "")
                _result = 0;
        }

        private void AddButton_Click(object sender, RoutedEventArgs e)
        {
            try
            {
                //Vérifer si le champ pour l'identifiant est vide
                if (IdTextBox.Text == "" && ItExists())
                {
                    MessageBox.Show("L'étudiant avec l'identifient '" + IdTextBox.Text + "' n'existe pas.", "Erreur", MessageBoxButton.OK);
                }
                else
                {
                    MessageBox.Show("Voulez-vous remplacer le résultat pour l'étudiant '" + IdTextBox.Text + "' de '" + _evaluation.StudentResults[Convert.ToInt32(IdTextBox.Text)] + "' à '" + _result + "' ?", "Confirmation d'ajout", MessageBoxButton.YesNo);
                    //Les informations sont valides, on crée une nouvelle évaluation
                    _evaluation.StudentResults[Convert.ToInt32(IdTextBox.Text)] = _result;
                    Close();
                }
            }
            catch (Exception)
            {

            }
        }

        private void CancelButton_Click(object sender, RoutedEventArgs e)
        {
            Close();            
        }

        private bool ItExists()
        {
            //Vérifier si l'identifiant existe
            foreach (var student in App.Current.Students.Values)
            {
                if (IdTextBox.Text == Convert.ToString(student.Id))
                {
                    return true;
                }
            }
            return false;
        }
    }
}