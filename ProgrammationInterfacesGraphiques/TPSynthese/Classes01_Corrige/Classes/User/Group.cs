using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Classes01_Corrige
{
   public class Group : User
   {
      public int IdGroup;
      public string Name;
      public string Description;
      public string ImageURL;
   
      public List<int> IdsAdmins = new List<int>();
      public List<int> IdsUsers = new List<int>();

      public IEnumerable<Group> Admins
      {
         get
         {
            return App.Current.Groups.Values.Where(group => IdsAdmins.Contains(group.IdGroup));
         }
      }

      public IEnumerable<User> Users
      {
         get
         {
            return App.Current.Users.Values.Where(user => IdsUsers.Contains(user.Id));
         }
      }
   }
}
