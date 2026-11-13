using System;
using System.Collections.Generic;
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

namespace Classes01_Corrige
{
   /// <summary>
   /// Logique d'interaction pour FacebookWindow.xaml
   /// </summary>
   public partial class FacebookWindow : Window
   {
      public FacebookWindow()
      {
         InitializeComponent();
      }

      private void WallButton_Click(object sender, RoutedEventArgs e)
      {
         var window = new WallWindow();
         window.Show();
      }
      private void MarketplaceButton_Click(object sender, RoutedEventArgs e)
      {
         var window = new MarketplaceWindow();
         window.Show();
      }
   }
}
