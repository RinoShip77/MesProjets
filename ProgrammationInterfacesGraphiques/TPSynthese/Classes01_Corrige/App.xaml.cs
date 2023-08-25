using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Threading.Tasks;
using System.Windows;

namespace Classes01_Corrige
{
   /// <summary>
   /// Logique d'interaction pour App.xaml
   /// </summary>
   public partial class App : Application
   {

      public static new App Current
      {
         get { return Application.Current as App; }
      }

      public Dictionary<int, Friend> Friends = new Dictionary<int, Friend>();
      public Dictionary<int, Group> Groups = new Dictionary<int, Group>();
      public Dictionary<int, Offer> Offers = new Dictionary<int, Offer>();

      public Dictionary<int, Post> Posts = new Dictionary<int, Post>();
      private Dictionary<int, Post> _posts = new Dictionary<int, Post>()
      {
         {0,new Post(){ Id = 0, User = "Tom", Title = "Nice snack with a book", Description = "BlaBlaBla", ImageURL = "post1.jpg", Date = new DateTime(2021, 11, 20, 7, 0, 0), Accessibility = PostAccessibility.Public, Like = "", Love = "", Sad = "", Angry = "" } },
         {1,new Post(){ Id = 1, User = "Elliot", Title = "Relaxing night at the beach", Description = "BlaBlaBla", ImageURL = "post2.jpg", Date = new DateTime(2021, 11, 21, 10, 30, 0), Accessibility = PostAccessibility.Public, Like = "Tom", Love = "", Sad = "", Angry = "" } },
         {2,new Post(){ Id = 2, User = "Rachel", Title = "Trekking in the woods", Description = "BlaBlaBla", ImageURL = "post3.jpg", Date = new DateTime(2021, 11, 22, 16, 30, 0), Accessibility = PostAccessibility.Public, Like = "", Love = "Tom", Sad = "", Angry = "" } },
         {3,new Post(){ Id = 3, User = "Myriam", Title = "King of the world!", Description = "BlaBlaBla", ImageURL = "post4.jpg", Date = new DateTime(2021, 11, 23, 21, 0, 0), Accessibility = PostAccessibility.Public, Like = "", Love = "", Sad = "Tom", Angry = "Elliot" } },
         {4,new Post(){ Id = 4, User = "Paul", Title = "After work", Description = "BlaBlaBla", ImageURL = "post5.jpg", Date = new DateTime(2021, 11, 24, 12, 0, 0), Accessibility = PostAccessibility.Public, Like = "", Love = "", Sad = "", Angry = "" } },
         {5,new Post(){ Id = 5, User = "Tom", Title = "New Zeleand 2017", Description = "BlaBlaBla", ImageURL = "post6.jpg", Date = new DateTime(2021, 11, 25, 1, 0, 0), Accessibility = PostAccessibility.FriendsOnly, Like = "", Love = "Elliot", Sad = "", Angry = "" } },
         {6,new Post(){ Id = 6, User = "Tom", Title = "Sweden 2018", Description = "BlaBlaBla", ImageURL = "post7.jpg", Date = new DateTime(2021, 11, 26, 9, 0, 0), Accessibility = PostAccessibility.FriendsExcept, Like = "", Love = "", Sad = "Rachel", Angry = "" } },
         {7,new Post(){ Id = 7, User = "Tom", Title = "Internet cafe Sundays", Description = "BlaBlaBla", ImageURL = "post8.jpg", Date = new DateTime(2021, 11, 27, 11, 30, 0), Accessibility = PostAccessibility.FriendsSpecific, Like = "", Love = "", Sad = "", Angry = "" } },
         {8,new Post(){ Id = 8, User = "Elliot", Title = "Surprise!", Description = "BlaBlaBla", ImageURL = "post9.jpg", Date = new DateTime(2021, 11, 28, 14, 30, 0), Accessibility = PostAccessibility.FriendsOnly, Like = "Tom Rachel", Love = "", Sad = "", Angry = "" } },
         {9,new Post(){ Id = 9, User = "Elliot", Title = "Secret painting", Description = "BlaBlaBla", ImageURL = "post10.jpg", Date = new DateTime(2021, 11, 29, 17, 30, 0), Accessibility = PostAccessibility.OnlyMe, Like = "", Love = "", Sad = "Elliot", Angry = "" } }
      };

      public Dictionary<int,Car> Cars { get => _cars; }
      private Dictionary<int, Car> _cars = new Dictionary<int, Car>()
      {
         {0,new Car(){ IdCar = 0, ImageURL = "car1.jpg", Date = new DateTime(2021, 11, 19), Price = 6000, Manufacturer = "Honda", Brand = "Accord", Year = 2014, Odometer = 170 } },
         {1,new Car(){ IdCar = 1, ImageURL = "car2.jpg", Date = new DateTime(2021, 11, 19), Price = 5000, Manufacturer = "Toyota", Brand = "Camry", Year = 2015, Odometer = 200 } },
         {2,new Car(){ IdCar = 2, ImageURL = "car3.jpg", Date = new DateTime(2021, 11, 21), Price = 8000, Manufacturer = "Nissan", Brand = "Leaf", Year = 2013, Odometer = 210 } },
         {3,new Car(){ IdCar = 3, ImageURL = "car4.jpg", Date = new DateTime(2021, 11, 21), Price = 10000, Manufacturer = "Toyota", Brand = "Yaris", Year = 2021, Odometer = 20 } },
         {4,new Car(){ IdCar = 4, ImageURL = "car5.jpg", Date = new DateTime(2021, 11, 23), Price = 1000, Manufacturer = "Honda", Brand = "Civic", Year = 2001, Odometer = 350 } },
         {5,new Car(){ IdCar = 5, ImageURL = "car6.jpg", Date = new DateTime(2021, 11, 23), Price = 6000, Manufacturer = "Honda", Brand = "Civic", Year = 2011, Odometer = 140 } },
         {6,new Car(){ IdCar = 6, ImageURL = "car7.jpg", Date = new DateTime(2021, 11, 25), Price = 20000, Manufacturer = "Toyota", Brand = "Accord", Year = 2021, Odometer = 10 } },
         {7,new Car(){ IdCar = 7, ImageURL = "car8.jpg", Date = new DateTime(2021, 11, 25), Price = 7000, Manufacturer = "Nissan", Brand = "Accord", Year = 2015, Odometer = 150 } },
         {8,new Car(){ IdCar = 8, ImageURL = "car9.jpg", Date = new DateTime(2021, 11, 27), Price = 9000, Manufacturer = "Nissan", Brand = "Infiniti", Year = 2016, Odometer = 170 } },
         {9,new Car(){ IdCar = 9, ImageURL = "car10.jpg", Date = new DateTime(2021, 11, 27), Price = 12000, Manufacturer = "Honda", Brand = "Infiniti", Year = 2018, Odometer = 90 } },
         {10,new Car(){ IdCar = 10, ImageURL = "car11.jpg", Date = new DateTime(2021, 11, 29), Price = 5000, Manufacturer = "Totota", Brand = "Yaris", Year = 2013, Odometer = 210 } },
         {11,new Car(){ IdCar = 11, ImageURL = "car12.jpg", Date = new DateTime(2021, 11, 29), Price = 2000, Manufacturer = "Nissan", Brand = "Altima", Year = 2003, Odometer = 320 } },
      };

      public Dictionary<int, User> Users { get => _users; }
      private Dictionary<int, User> _users = new Dictionary<int, User>()
      {
         {0,new User(){Id = 0, FirstName = "Tom", LastName = "Richards" } },
         {1,new User(){Id = 1, FirstName = "Elliot", LastName = "Hart" } },
         {2,new User(){Id = 2, FirstName = "Rachel", LastName = "Chapman" } },
         {3,new User(){Id = 3, FirstName = "Myriam", LastName = "Leblanc" } },
         {4,new User(){Id = 4, FirstName = "Paul", LastName = "Burnham" } },
      };

   }
}
