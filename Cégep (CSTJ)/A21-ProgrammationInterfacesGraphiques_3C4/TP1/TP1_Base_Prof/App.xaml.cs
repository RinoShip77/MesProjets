using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Threading.Tasks;
using System.Windows;

namespace TP1_Base_Prof
{
    /// <summary>
    /// Logique d'interaction pour App.xaml
    /// </summary>
    public partial class App : Application
    {
        public static new App Current { get { return Application.Current as App; } }

        public T GetWindow<T>() { return Windows.OfType<T>().First(); }

        public Dictionary<int, Student> Students { get => _students; }
        private Dictionary<int, Student> _students = new Dictionary<int, Student>()
        {
            { 21000123, new Student() { Id = 21000123, FirstName = "Paul", LastName = "Berube", Password = "pberube" } },
            { 21000456, new Student() { Id = 21000456, FirstName = "Mathieu", LastName = "Gagnon", Password = "mgagnon" } },
            { 21000789, new Student() { Id = 21000789, FirstName = "Robert", LastName = "Simard", Password = "rsimard" } },
            { 19887766, new Student() { Id = 19887766, FirstName = "Elise", LastName = "Huard", Password = "ehuard" } },
            { 19559977, new Student() { Id = 19559977, FirstName = "Marie", LastName = "Sauve", Password = "msauve" } },
            { 18996644, new Student() { Id = 18996644, FirstName = "Sylvie", LastName = "Michaud", Password = "smichaud" } },
        };

        public Dictionary<int, Teacher> Teachers { get => _teachers; }
        private Dictionary<int, Teacher> _teachers = new Dictionary<int, Teacher>()
        {
            { 1001, new Teacher() { Id = 1001, FirstName = "Mael", LastName = "Perreault", Password = "mperreault" } },
            { 1002, new Teacher() { Id = 1002, FirstName = "Yannick", LastName = "Charron", Password = "ycharron" } },
            { 1003, new Teacher() { Id = 1003, FirstName = "Karine", LastName = "Moreau", Password = "kmoreau"  } },
            { 1004, new Teacher() { Id = 1004, FirstName = "Robert", LastName = "Turenne", Password = "rturenne" } },
            { 1005, new Teacher() { Id = 1005, FirstName = "Alain", LastName = "Martel", Password = "amartel" } },
        };

        public List<Cours> Cours { get => _cours; }
        private List<Cours> _cours = new List<Cours>()
        {
            new Cours()
            {
                Id = "1C5",
                Name = "Ordinateurs et systèmes d'exploitation",
                Semester = Semester.A21,
                Group = 1,
                Local = Local.D134,
                CoursePeriods = new List<CoursePeriod>()
                {
                    new CoursePeriod() {
                        DayOfWeek = DayOfWeek.Tuesday,
                        PeriodStart = 7,
                        PeriodLength = 2 },
                    new CoursePeriod() { DayOfWeek = DayOfWeek.Thursday, PeriodStart = 0, PeriodLength = 3 },
                },
                TeacherId = 1001,
                StudentIds = new List<int>()
                {
                    21000123,
                    21000456,
                    21000789,
                    19887766,
                    19559977,
                    18996644,
                },
                Evaluations = new List<Evaluation>()
                {
                    new Evaluation() {
                        Name = "Exam 1",
                        Value = 20,
                        StudentResults = new Dictionary<int, int>
                        {
                            { 21000123, 15 },
                            { 21000456, 10 },
                            { 21000789, 5 },
                            { 19887766, 5 },
                            { 19559977, 10 },
                            { 18996644, 15 },
                        }
                    },
                    new Evaluation() {
                        Name = "TP 1",
                        Value = 30,
                        StudentResults = new Dictionary<int, int>
                        {
                            { 21000123, 25 },
                            { 21000456, 20 },
                            { 21000789, 15 },
                            { 19887766, 15 },
                            { 19559977, 20 },
                            { 18996644, 25 },
                        }
                    },
                    new Evaluation() {
                        Name = "Exam 2",
                        Value = 30,
                        StudentResults = new Dictionary<int, int>
                        {
                            { 21000123, 25 },
                            { 21000456, 20 },
                            { 21000789, 15 },
                            { 19887766, 15 },
                            { 19559977, 20 },
                            { 18996644, 25 },
                        }
                    }
                }
            },
            new Cours()
            {
                Id = "3C4",
                Name = "Programmation d'interfaces graphiques",
                Semester = Semester.H21,
                Group = 1,
                Local = Local.D136,
                CoursePeriods = new List<CoursePeriod>()
                {
                    new CoursePeriod() { DayOfWeek = DayOfWeek.Monday, PeriodStart = 5, PeriodLength = 2 },
                    new CoursePeriod() { DayOfWeek = DayOfWeek.Wednesday, PeriodStart = 2, PeriodLength = 2 },
                },
                TeacherId = 1001,
                StudentIds = new List<int>()
                {
                    21000123,
                    21000456,
                    21000789,
                    19887766,
                    19559977,
                    18996644,
                },
                Evaluations = new List<Evaluation>()
                {
                    new Evaluation() {
                        Name = "Exam 1",
                        Value = 50,
                        StudentResults = new Dictionary<int, int>
                        {
                            { 21000123, 35 },
                            { 21000456, 30 },
                            { 21000789, 25 },
                            { 19887766, 25 },
                            { 19559977, 30 },
                            { 18996644, 25 },
                        }
                    },
                    new Evaluation() {
                        Name = "Exam 2",
                        Value = 50,
                        StudentResults = new Dictionary<int, int>
                        {
                            { 21000123, 45 },
                            { 21000456, 40 },
                            { 21000789, 35 },
                            { 19887766, 35 },
                            { 19559977, 40 },
                            { 18996644, 45 },
                        }
                    }
                }
            },
            new Cours()
            {
                Id = "3C4",
                Name = "Programmation d'interfaces graphiques",
                Semester = Semester.A20,
                Group = 2,
                Local = Local.D139,
                CoursePeriods = new List<CoursePeriod>()
                {
                    new CoursePeriod() { DayOfWeek = DayOfWeek.Monday, PeriodStart = 2, PeriodLength = 2 },
                    new CoursePeriod() { DayOfWeek = DayOfWeek.Wednesday, PeriodStart = 9, PeriodLength = 2 },
                },
                TeacherId = 1001,
                StudentIds = new List<int>()
                {
                    21000123,
                    21000456,
                    21000789,
                    19887766,
                    19559977,
                    18996644,
                },
                Evaluations = new List<Evaluation>()
                {
                    new Evaluation() {
                        Name = "Exam 1",
                        Value = 50,
                        StudentResults = new Dictionary<int, int>
                        {
                            { 21000123, 35 },
                            { 21000456, 30 },
                            { 21000789, 25 },
                            { 19887766, 25 },
                            { 19559977, 30 },
                            { 18996644, 25 },
                        }
                    },
                    new Evaluation() {
                        Name = "Exam 2",
                        Value = 50,
                        StudentResults = new Dictionary<int, int>
                        {
                            { 21000123, 45 },
                            { 21000456, 40 },
                            { 21000789, 35 },
                            { 19887766, 35 },
                            { 19559977, 40 },
                            { 18996644, 45 },
                        }
                    }
                }
            },
        };
    }
}
