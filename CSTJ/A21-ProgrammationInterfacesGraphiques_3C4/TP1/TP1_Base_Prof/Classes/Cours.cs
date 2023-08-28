using System.Collections.Generic; //Pour utiliser les listes

namespace TP1_Base_Prof
{
    public enum Semester
    {
        A21,
        H21,
        A20
    }

    public enum Local
    {
        D134,
        D136,
        D139
    }

    public class Cours
    {
        public string Id;
        public string Name;
        public Semester Semester;
        public int Group;
        public Local Local;
        public List<CoursePeriod> CoursePeriods;
        public int TeacherId;
        public List<int> StudentIds;
        public List<Evaluation> Evaluations;

        public override string ToString()
        {
            return $"{Id} - gr. 00{Group}";
        }
    }
}
