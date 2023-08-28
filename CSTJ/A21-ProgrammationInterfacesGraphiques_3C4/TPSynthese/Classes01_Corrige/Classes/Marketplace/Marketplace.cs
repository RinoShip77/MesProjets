using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Classes01_Corrige
{
   public abstract class Marketplace 
   {
      public List<int> IdsOffers = new List<int>();

      public IEnumerable<Offer> Offers
      {
         get
         {
            return App.Current.Offers.Values.Where(offer => IdsOffers.Contains(offer.Id));
         }
      }
   }
}
