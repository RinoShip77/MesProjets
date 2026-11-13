using System.Collections.Generic; //Pour utiliser les listes

namespace TP1_Base_Prof
{
    public class Evaluation
    {
        public string Name;
        public int Value;
        public Dictionary<int, int> StudentResults;
        
        public override string ToString()
        {
            return $"{Name} - ?Note? / {Value} - Moyenne: ?";
        }
    }
}
