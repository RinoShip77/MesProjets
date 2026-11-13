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
   /// Logique d'interaction pour PostUserControl.xaml
   /// </summary>
   public partial class PostUserControl : UserControl
   {
      private int index = 1;
      private string UriPrefix = "pack://application:,,,/Classes01_Corrige;component";
      public int Index { get => index; set => index = value; }
      public PostUserControl()
      {
         InitializeComponent();
      }

      public void UpdateImage()
      {
         Uri uri = new Uri(UriPrefix + "/Assets/Posts/post" + Index + ".jpg");
         BitmapImage bitmapImage = new BitmapImage(uri);
         PostImage.Source = bitmapImage;
         PostImage.Width = 200;
      }
   }
}
