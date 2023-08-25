using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Navigation;
using System.Windows.Shapes;

namespace TP1_Base_Prof
{
   /// <summary>
   /// Logique d'interaction pour LogonWindow.xaml
   /// </summary>
   public partial class LogonWindow : Window
   {
      public LogonWindow()
      {
         InitializeComponent();
      }

      private void LoginButton_Click(object sender, RoutedEventArgs e)
      {
         try
         {
            bool IsConnected = false; //Sert à vérifer si l'utilisateur a réussi à se connecter à Omnivox
            if (UserTextBox.Text == "admin" && PasswordPasswordBox.Password == "admin")
            {
               //Entrer en tant qu'admin
               var window = new AdministrationWindow();
               window.Show();
            }
            else
            {
               //Utilise les informations de l'utilisateur
               User user = new User()
               {
                  Id = Convert.ToInt32(UserTextBox.Text),
                  Password = PasswordPasswordBox.Password,
               };

               //Tester pour un étudiant
               if (LeftToggleButton.IsChecked == true)
               {
                  foreach (var student in App.Current.Students.Values)
                  {
                     if (user.Id == student.Id && user.Password == student.Password)
                     {
                        //Entrer en tant qu'étudiant
                        var window = new OmnivoxStudentWindow(student);
                        window.Show();
                        //Connection réussi
                        IsConnected = true;
                        // Ferme toutes les 'Windows' et va à 'OmnivoxStudentWindow'
                        for (int i = App.Current.Windows.Count - 1; i >= 0; i--)
                        {
                           if (App.Current.Windows[i] != window)
                           {
                              App.Current.Windows[i].Close();
                           }
                        }
                     }
                  }
                  //Étudiant invalide
                  if(!IsConnected)
                  {
                     //Ne pas afficher le message si la connection a réussi
                     MessageBox.Show("Erreur dans le nom d'utilisateur ou le mot de passe. Réessayer de nouveau!", "Erreur", MessageBoxButton.OK);
                  }                  
               }
               else 
               {
                  //Tester pour les enseignants
                  if (RightToggleButton.IsChecked == true)
                  {
                     foreach (var teacher in App.Current.Teachers.Values)
                     {

                        if (user.Id == teacher.Id && user.Password == teacher.Password)
                        {
                           //Entrer en tant qu'enseignant
                           var window = new OmnivoxTeacherWindow(teacher);
                           window.Show();
                           //Connection réussi
                           IsConnected = true;
                           // Ferme toutes les 'Windows' et va à 'OmnivoxStudentWindow'
                           for (int i = App.Current.Windows.Count - 1; i >= 0; i--)
                           {
                              if (App.Current.Windows[i] != window)
                              {
                                 App.Current.Windows[i].Close();
                              }
                           }
                        }
                     }
                     //Enseignant invalide
                     if (!IsConnected)
                     {
                        //Ne pas afficher le message si la connection a réussi
                        MessageBox.Show("Erreur dans le nom d'utilisateur ou le mot de passe. Réessayer de nouveau!", "Erreur", MessageBoxButton.OK);
                     }
                  }
               }
            }
         }
         catch (Exception) //Affiche un message d'erreur dans un pop-up
         {
            MessageBox.Show("Erreur dans le nom d'utilisateur ou le mot de passe. Réessayer de nouveau!", "Erreur", MessageBoxButton.OK);
         }
      }

      private void ForgotButton_Click(object sender, RoutedEventArgs e)
      {
         var window = new ResetPasswordWindow();
         window.Show();
      }

      private void LeftToggleButton_Click(object sender, RoutedEventArgs e)
      {
         //On inverse les valeurs des deux ToggleButton pour simuler un radiobutton 
         RightToggleButton.IsChecked = false;
      }

      private void RightToggleButton_Click(object sender, RoutedEventArgs e)
      {
         //On inverse les valeurs des deux ToggleButton pour simuler un radiobutton
         LeftToggleButton.IsChecked = false;
      }
   }
}
