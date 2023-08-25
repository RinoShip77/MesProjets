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
    public partial class CourseDetailTeacherWindow : Window
    {
        private readonly Cours _cours;
        private readonly Evaluation _evaluation;
        public CourseDetailTeacherWindow(Cours cours)
        {
            InitializeComponent();

            //On conserve les données passées en paramètre
            _cours = cours;

            //Initialisations de certains champs par des données passées en paramètre
            Title = $"{cours.Id} - { cours.Name} gr. 00{cours.Group}";

            //Initialise la liste déroulante des évaluations
            EvaluationComboBox.Items.Clear();
            foreach (var evaluation in cours.Evaluations)
            {
                EvaluationComboBox.Items.Add(evaluation.Name); // Ajoute les noms des évaluation
                _evaluation = evaluation;
            }

            PonderationTextBox.Text = _evaluation.Value.ToString();
            MoyenneTextBox.Text = _evaluation.StudentResults.Average(eval => eval.Value).ToString();

            StudentListView.SelectionChanged += StudentListView_SelectionChanged;
            //Remplie la liste d'élèves
            StudentListView.Items.Clear();
            foreach (var student in App.Current.Students.Values)
            {
                StudentListView.Items.Add(student);
            }

            //On initialise des boîtes de texte selon le premier étudiant
            Student _student = App.Current.Students.Values.First();
            IdTextBox.Text = _student.Id.ToString();
            FirstNameTextBox.Text = _student.FirstName;
            LastNameTextBox.Text = _student.LastName;

            //Initialise la liste de résultats
            ResultListView.Items.Clear();
            foreach (var evaluation in _cours.Evaluations)
            {
                ResultListView.Items.Add($"{evaluation.Name}\t\t{evaluation.StudentResults[_student.Id]} / {evaluation.Value}\t\tMoyenne : {evaluation.StudentResults.Average(eval => eval.Value)}");
            }
        }

        private void StudentListView_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            //L'étudiant sera celui choisie dans la liste
            var student = StudentListView.SelectedItem as Student;
            if (student != null)
            {
                IdTextBox.Text = student.Id.ToString();
                FirstNameTextBox.Text = student.FirstName;
                LastNameTextBox.Text = student.LastName;

                //Remplie la liste de résultats
                ResultListView.Items.Clear();
                foreach (var evaluation in _cours.Evaluations)
                {
                    ResultListView.Items.Add($"{evaluation.Name}\t\t{evaluation.StudentResults[student.Id]} / {evaluation.Value}\t\tMoyenne : {evaluation.StudentResults.Average(eval => eval.Value)}");
                }
            }
        }

        private void AddEvaluationButton_Click(object sender, RoutedEventArgs e)
        {
            var window = new AddEvaluationWindow(_cours);
            window.Show();
        }

        private void AddResultButton_Click(object sender, RoutedEventArgs e)
        {
            var window = new AddResultWindow(_evaluation);
            window.Show();
        }
    }
}
