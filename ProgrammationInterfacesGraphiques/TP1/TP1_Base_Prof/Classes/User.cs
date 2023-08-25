namespace TP1_Base_Prof
{
    public class User
    {
        public int Id;
        public string FirstName;
        public string LastName;
        public string Password;

        // ToString() will be used in ListView instead of class name
        public override string ToString()
        {
            return $"{Id} - {LastName}, {FirstName}";
        }
    }
}