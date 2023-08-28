using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Classes01_Corrige
{
   public class Comment : Post
   {
      public int IdComment;
      public int IdUser;
      public string Text;
      public string ImageURL; //Optionnelle
      public List<PostReaction> ReactionsComments = new List<PostReaction>();
   }
}
