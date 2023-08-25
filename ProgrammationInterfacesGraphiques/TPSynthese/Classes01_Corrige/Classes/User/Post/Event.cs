using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Classes01_Corrige
{
   public class Event : Post
   {
      public int IdEvent;
      public string Title;
      public string Description;
      public DateTime Date;
      public DateTime Time;
      public string Address;
      public string ImageURL;
      public EventsCategories Categorie;
      public EventsAccessibility EventAccessibility;
      public EventStatus Status;

      public User MostUserWithGoing
      {
         get
         {
            //int max = App.Current.Posts.Values.Max(p => p.Status.Count());

            //Product product =
            //    Products.Values
            //    .FirstOrDefault(p => p.Cards.Count() == max);

            //IEnumerable<Product> enumerableSorted =
            //    Products.Values
            //    .OrderBy(p => p.Cards.Count());

            //return enumerableSorted.FirstOrDefault();
            return null;
         }
      }

      public User MostUserWithIntereted
      {
         get
         {
            //Min. Max.

            //int max = Products.Values.Max(p => p.Cards.Count());

            //Product product =
            //    Products.Values
            //    .FirstOrDefault(p => p.Cards.Count() == max);

            //IEnumerable<Product> enumerableSorted =
            //    Products.Values
            //    .OrderBy(p => p.Cards.Count());

            //return enumerableSorted.FirstOrDefault();
            return null;
         }
      }
   }
}
