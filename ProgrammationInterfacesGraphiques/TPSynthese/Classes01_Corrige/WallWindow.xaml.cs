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
using System.Windows.Shapes;

namespace Classes01_Corrige
{
   /// <summary>
   /// Logique d'interaction pour WallWindow.xaml
   /// </summary>
   public partial class WallWindow : Window
   {
      public WallWindow()
      {
         InitializeComponent();

         AddPost();
      }

      public void AddPost()
      {
         foreach (var post in App.Current.Posts.Values)
         {
            PostUserControl Post = new PostUserControl();
            Post.Index = post.Id + 1;            
            Post.UpdateImage();            
         }
      }

      private void DateRadioButton_Click(object sender, RoutedEventArgs e)
      {
         PopularityRadioButton.IsChecked = false;
      }

      private void PopularityRadioButton_Click(object sender, RoutedEventArgs e)
      {
         DateRadioButton.IsChecked = true;
      }
   }
}
