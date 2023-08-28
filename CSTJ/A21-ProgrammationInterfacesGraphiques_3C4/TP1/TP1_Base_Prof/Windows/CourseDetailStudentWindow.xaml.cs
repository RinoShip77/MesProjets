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
    public partial class CourseDetailStudentWindow : Window
    {
        public CourseDetailStudentWindow(Cours cours, Student student)
        {
            InitializeComponent();

            //Initialisations de certains champs par des données passées en paramètre
            Title = $"{cours.Id} - { cours.Name} gr. 00{cours.Group}";
            IdTextBox.Text = student.Id.ToString();
            FirstNameTextBox.Text = student.FirstName;
            LastNameTextBox.Text = student.LastName;

            //Remplie la liste d'évaluations
            CourseListView.Items.Clear();
            foreach (var evaluation in cours.Evaluations)
            {
                CourseListView.Items.Add($"{evaluation.Name} - {evaluation.StudentResults[student.Id]} / {evaluation.Value} - Moyenne : {evaluation.StudentResults.Average(eval => eval.Value)}");
            }
        }
    }
}
