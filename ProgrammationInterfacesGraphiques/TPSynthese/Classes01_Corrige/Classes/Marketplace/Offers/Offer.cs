using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Classes01_Corrige
{
   public class Offer : Marketplace
   {
      public int Id;
      public string Title;
      public string Description;
      public string ImageURL;

      public double Price;
      public DateTime Date;
      public int PriceMin;
      public int PriceMax;
      public DateTime DateMin;
      public DateTime DateMax;
      

      public int IdUser;
      public List<int> IdsFriends = new List<int>();
      public List<int> IdsUsers = new List<int>();

      public IEnumerable<User> UsersList
      {
         get
         {
            return App.Current.Users.Values.Where(user => IdsUsers.Contains(user.Id));
         }
      }

      public User User
      {
         get
         {
            return App.Current.Users.Values.FirstOrDefault(user => IdsUsers.Contains(IdUser));
         }
      }

      public IEnumerable<Friend> Friends
      {
         get
         {
            return App.Current.Friends.Values.Where(friend => IdsFriends.Contains(friend.IdFriend));
         }
      }

   }
}
