using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Classes01_Corrige
{
   public class User
   {
      public int Id;      
      public string FirstName;
      public string LastName;
      public string Mail; 
      public string Password;     
      public string ProfileImageURL; //Photo de profil
      public string WallpaperURL;    //Fond d'écran

      public List<int> IdsFriends = new List<int>();
      public List<int> IdsRequests = new List<int>();
      public List<int> IdsRequestsSent = new List<int>();
      public List<int> IdsGroups = new List<int>();
      public List<int> IdsGroupsAdmins = new List<int>();
      public List<int> IdsPosts = new List<int>();

      public IEnumerable<Friend> Friends 
      {
         get
         {
            return App.Current.Friends.Values.Where(friend => IdsFriends.Contains(friend.IdFriend));
         }
      }
      //Liste des amis du plus récent au plus vieux
      public IEnumerable<Friend> FriendsOrderNewwestOldest
      {
         get
         {
            return App.Current.Friends.Values.OrderByDescending(friend => IdsFriends.Contains(friend.IdFriend));
         }
      }
      //Liste des amis en ordre alphabétique
      public IEnumerable<Friend> FriendsOrderAlphabetic
      {
         get
         {
            return App.Current.Friends.Values.OrderBy(friend => friend.FirstName);
         }
      }

      public IEnumerable<Friend> Resquests
      {
         get
         {
            return App.Current.Friends.Values.Where(friend => IdsRequestsSent.Contains(friend.IdFriend));                                 
         }
      }

      public IEnumerable<Friend> ResquestsSent
      {
         get
         {
            return App.Current.Friends.Values.Where(friend => IdsRequestsSent.Contains(friend.IdFriend));
         }
      }

      public IEnumerable<Group> Groups
      {
         get
         {
            return App.Current.Groups.Values.Where(group => IdsGroups.Contains(group.IdGroup));
         }
      }

      public IEnumerable<Group> GroupsAdmins
      {
         get
         {
            return App.Current.Groups.Values.Where(group => IdsGroupsAdmins.Contains(group.IdGroup));
         }
      }

      public IEnumerable<Post> Posts
      {
         get
         {
            return App.Current.Posts.Values.Where(post => IdsPosts.Contains(post.Id));
         }
      }


   }
}
