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
    /// Logique d'interaction pour StudentSelectedWindow.xaml
    /// </summary>
    public partial class StudentSelectedWindow : Window
    {
        private Student Student { get => _student; }
        private Student _student;

        // Replace default constructor by adding parameter if window can only be opened with data
        public StudentSelectedWindow(Student student)
        {
            InitializeComponent();

            OkButton.Click += OkButton_Click;

            // Keep paramater inside window for use later
            _student = student;

            StudentIdTextBlock.Text = Student.Id.ToString();
            StudentFirstNameTextBlock.Text = Student.FirstName;
        }

        // Trick to open window with dummy data, keep a private constructor and send some dummy date to other constructor
        private StudentSelectedWindow() : this(App.Current.Students[0])
        {
        }

        private void OkButton_Click(object sender, RoutedEventArgs e)
        {
            Close();

            // Get any other window from App.Current.GetWindow<>()
            var mainWindow = App.Current.GetWindow<MainWindow>();
            mainWindow.DoSomethingFromOtherWindow();
        }
    }
}
