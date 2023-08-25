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
    /// Logique d'interaction pour MainWindow.xaml
    /// </summary>
    public partial class MainWindow : Window
    {
        public MainWindow()
        {
            InitializeComponent();

            ProductListView.SelectionChanged += ProductListView_SelectionChanged;

            // Get values in project by using App.Current properties
            ProductListView.Items.Clear();
            foreach (var student in App.Current.Students.Values)
            {
                ProductListView.Items.Add(student);
            }

            ProductListView.SelectedItem = 0;

            // Close all windows except a new window
            //var window = new MyNewWindow();
            //window.Show();

            //for (int i = App.Current.Windows.Count - 1; i >= 0; i--)
            //{
            //    if (App.Current.Windows[i] != window)
            //    {
            //        App.Current.Windows[i].Close();
            //    }
            //}
        }

        private void ProductListView_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            var student = ProductListView.SelectedItem as Student;
            if (student != null)
            {
                var window = new StudentSelectedWindow(student);
                window.Show();
            }
        }

        private void Hyperlink_RequestNavigate(object sender, RequestNavigateEventArgs e)
        {
            // using System.Diagnostics;
            Process.Start(new ProcessStartInfo(e.Uri.AbsoluteUri));
            e.Handled = true;
        }

        public void DoSomethingFromOtherWindow()
        {
            MessageBox.Show("TODO");
        }
    }
}
