using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Classes01_Corrige
{
   public class Blog : Post
   {
      public int IdBlog;
      public int IdUser;
      public string Text;
      public Dictionary<int, Share> TextShare = new Dictionary<int, Share>();
   }
}
