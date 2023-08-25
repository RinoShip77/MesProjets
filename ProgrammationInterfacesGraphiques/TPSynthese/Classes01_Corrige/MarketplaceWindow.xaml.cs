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
   /// Logique d'interaction pour MarketplaceWindow.xaml
   /// </summary>
   public partial class MarketplaceWindow : Window
   {
      public MarketplaceWindow()
      {
         InitializeComponent();

         AddOffer();
      }

      public void AddOffer()
      {
         foreach (var offer in App.Current.Cars.Values)
         {
            OfferUserControl Offer = new OfferUserControl();
            Offer.Index = offer.IdCar + 1;
            Offer.PriceLabel.Content = offer.Price + "$";
            Offer.DateLabel.Content = offer.Date;
            Offer.YearLabel.Content = offer.Year;
            Offer.MakerLabel.Content = offer.Manufacturer;
            Offer.BrandLabel.Content = offer.Brand;
            Offer.MileageLabel.Content = offer.Odometer + "k km";
            Offer.UpdateImage();
            OfferPanel.Children.Add(Offer);
         }
      }

      private void SearchButton_Click(object sender, RoutedEventArgs e)
      {
         try
         {
            //Sort by date
            if (DateRadioButton.IsChecked.Value == true)
            {
               App.Current.Cars.Values.OrderBy(c => c.Date);
            }

            //Sort by price
            if (PriceRadioButton.IsChecked.Value == true)
            {
               App.Current.Cars.Values.OrderByDescending(c => c.Price);
            }

            //Price
            if (PriceMinTextBlock.Text != null && PriceMaxTextBlock.Text != null)
            {
               App.Current.Cars.Values.Where(c =>
                  c.Price > Convert.ToDouble(PriceMinTextBlock.Text)
                  &&
                  c.Price < Convert.ToDouble(PriceMaxTextBlock.Text));
            }

            //Maker
            if (MakerComboBox.Text != null)
            {
               App.Current.Cars.Values.Where(c => c.Manufacturer == MakerComboBox.Text);
            }

            //Brand
            if (BrandComboBox.Text != null)
            {
               App.Current.Cars.Values.Where(c => c.Brand == BrandComboBox.Text);
            }

            //Year
            if (YearMinTextBlock.Text != null && YearMaxTextBlock.Text != null)
            {
               App.Current.Cars.Values.Where(c =>
                  c.Year > Convert.ToInt32(YearMinTextBlock.Text)
                  &&
                  c.Year < Convert.ToInt32(YearMaxTextBlock.Text));
            }

            //Mileage
            if (MileageMinTextBlock.Text != null && MileageMaxTextBlock.Text != null)
            {
               App.Current.Cars.Values.Where(c =>
                  c.Odometer > Convert.ToInt32(PriceMinTextBlock.Text)
                  &&
                  c.Odometer < Convert.ToInt32(PriceMaxTextBlock.Text));
            }

            Close();
            var window = new MarketplaceWindow();
            window.Show();
         }
         catch (Exception)
         {

         }
      }
   }
}
