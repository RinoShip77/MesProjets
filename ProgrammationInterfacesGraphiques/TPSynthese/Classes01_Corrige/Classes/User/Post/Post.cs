using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Classes01_Corrige
{
   public class Post
   {
      public int Id;
      public string Title;
      public string Description;
      public string ImageURL;
      public DateTime Date;
      public string User;
      public string Like;
      public string Love;
      public string Sad;
      public string Angry;
      public PostAccessibility Accessibility;
      public List<PostReaction> Reactions = new List<PostReaction>();
      public List<int> IdsComments = new List<int>();
   }
}
