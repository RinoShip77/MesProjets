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
   /// Logique d'interaction pour AdministrationWindow.xaml
   /// </summary>
   public partial class ChangePasswordWindow : Window
   {
      private readonly User _user;

      public ChangePasswordWindow(User user)
      {
         InitializeComponent();
         //Pour utiliser les informations de l'utilisateur (peut être un étudiant ou un enseignant)
         _user = user;
      }

      private void ChangeButton_Click(object sender, RoutedEventArgs e)
      {
         //Vérifier si les champs sont vide
         if (OldPasswordBox.Password.Length == 0)
         {
            MessageBox.Show("L'ancien mot de passe ne doit pas être vide","Erreur",MessageBoxButton.OK);
         }
         else
         {
            if (NewPasswordBox.Password.Length == 0)
            {
               MessageBox.Show("Le nouveau mot de passe ne doit pas être vide","Erreur", MessageBoxButton.OK);
            }
            else
            {
               if (ConfirmPasswordBox.Password.Length == 0)
               {
                  MessageBox.Show("La confirmation du mot de passe ne doit pas être vide","Erreur", MessageBoxButton.OK);
               }
               else
               {
                  //Vérifier si les champs sont valide
                  MessageBox.Show("Voulez-vous changer le mot de passe, l'ancien mot de passe sera perdu ?", "Changer mot de passe", MessageBoxButton.YesNo);
                  if (_user.Password == OldPasswordBox.Password)
                  {
                     if(NewPasswordBox.Password == ConfirmPasswordBox.Password)
                     {
                        //Changer le mot de passe
                        MessageBox.Show("Le mot de passe a été changé.","Changement effectué",MessageBoxButton.OK);
                        _user.Password = NewPasswordBox.Password;
                     }
                     else
                     {
                        MessageBox.Show("Les nouveaux mots de passe doivent être identique.","Erreur", MessageBoxButton.OK);
                     }
                  }
                  else
                  {
                     MessageBox.Show("L'ancien mot de passe est érroné.","Erreur", MessageBoxButton.OK);
                  }
               }
            }
         }
      }

      private void CancelButton_Click(object sender, RoutedEventArgs e)
      {
         Close();
      }
   }
}
