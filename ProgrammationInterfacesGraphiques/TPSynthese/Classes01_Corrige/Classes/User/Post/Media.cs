using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Classes01_Corrige
{
   public class Media : Post
   {
      public int IdMedia;
      public string URLMedia;
      public int MediaFormat;
      public int IdUserInMedia;
      public float PositionInImage;
      public int IdUser;
      public List<int> IdsMedias = new List<int>();
      public Dictionary<int, Media> IdsUsersTags = new Dictionary<int, Media>();
   }
}
