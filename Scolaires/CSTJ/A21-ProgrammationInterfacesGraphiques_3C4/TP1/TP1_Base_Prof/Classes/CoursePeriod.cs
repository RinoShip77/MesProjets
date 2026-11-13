namespace TP1_Base_Prof
{
    public enum DayOfWeek
    {
        Monday,
        Tuesday,
        Wednesday,
        Thursday,
        Friday
    }

    public class CoursePeriod
    {
        public DayOfWeek DayOfWeek;
        public int PeriodStart;
        public int PeriodLength;
    }
}
