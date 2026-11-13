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
    public partial class AddEvaluationWindow : Window
    {
        private readonly Cours _cours;
        public AddEvaluationWindow(Cours cours)
        {
            InitializeComponent();

            _cours = cours;
        }

        private void AddButton_Click(object sender, RoutedEventArgs e)
        {
            try
            {
                //Vérifer si le nom est vide 
                if (NameTextBox.Text == "")
                {
                    MessageBox.Show("Le nom de l'évaluation ne doit pas être vide.", "Erreur", MessageBoxButton.OK);
                }
                else
                {
                    //Vérifer si la pondération respecte les critères
                    if (PonderationTextBox.Text == "" && Convert.ToInt32(PonderationTextBox.Text) <= 0)
                    {
                        MessageBox.Show("La pondération doit être supérieure à 0.", "Erreur", MessageBoxButton.OK);
                    }
                    else
                    {
                        MessageBox.Show("Voulez-vous créer l'évaluation '" + NameTextBox.Text + "' de pondération '" + PonderationTextBox.Text + "'% ?", "Confirmation d'ajout", MessageBoxButton.YesNo);
                        //Les informations sont valides, on crée une nouvelle évaluation
                        _cours.Evaluations.Add(new Evaluation()
                        {
                            Name = NameTextBox.Text,
                            Value = Convert.ToInt32(PonderationTextBox.Text),
                            StudentResults = new Dictionary<int, int>
                            {
                                { 21000123, 15 },
                                { 21000456, 10 },
                                { 21000789, 5 },
                                { 19887766, 5 },
                                { 19559977, 10 },
                                { 18996644, 15 },
                            }
                        });
                        Close();
                    }
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
    }
}
