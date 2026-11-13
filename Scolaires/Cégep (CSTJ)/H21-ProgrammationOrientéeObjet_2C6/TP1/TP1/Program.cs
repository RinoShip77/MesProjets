using System;

// NE MODIFIER PAS CE FICHIER SAUF POUR ENLEVER LES COMMENTAIRES

namespace TP1
{
   /// <summary>
   /// Classe principale du programme de test
   /// </summary>
   class Program
   {
      static void Main()
      {
         // On boucle tant que l'utilisateur ne choisi pas de quitter
         while (true)
         {
            string choix = AfficherMenu();
            if (choix == "Q")
            {
               break;
            }
            Executer(choix);
         }

         Pause("Fin du programme");
      }

      /// <summary>
      /// Test de la classe Pion
      /// </summary>
      static void TestPion()
      {

         AfficherTitre("Test de la classe Pion");
         int nbErreurs = 0;

         Pion pionRouge = new Pion(CouleurPion.Rouge);
         Pion autrePionRouge = new Pion(CouleurPion.Rouge);
         Pion pionBlanc = new Pion(CouleurPion.Blanc);
         Pion autrePionBlanc = new Pion(CouleurPion.Blanc);

         // Compare 2 pions de la même couleur
         if (!pionRouge.EstDeMemeCouleurQue(autrePionRouge) || /* !!!!!! */
             !pionBlanc.EstDeMemeCouleurQue(autrePionBlanc))
         {
            IndiquerErreur("2 pions de la même couleur ne sont pas considés identiques", ref nbErreurs);
         }

         // Compare 2 pions de couleurs différentes
         if (pionRouge.EstDeMemeCouleurQue(autrePionBlanc) ||
             pionBlanc.EstDeMemeCouleurQue(autrePionRouge))
         {
            IndiquerErreur("2 pions de couleurs différentes sont considés identiques", ref nbErreurs);
         }

         Pause(nbErreurs == 0 ? "OK" : "");

      }

      /// <summary>
      /// Test de la classe Joueur
      /// </summary>
      static void TestJoueur()
      {

         AfficherTitre("Test de la classe Joueur");
         int nbErreurs = 0;

         // La création d'un joueur doit demander son nom
         Console.WriteLine("!!! DEVRAIT DEMANDER LE NOM DU JOUEUR Rouge >>>>");
         Joueur joueurRouge = new Joueur(CouleurPion.Rouge);

         // Compare la couleur indiquée avec la couleur donnée à la création du joueur
         if (joueurRouge.Couleur != CouleurPion.Rouge)
         {
            IndiquerErreur("La couleur du joueur Rouge est incorrecte", ref nbErreurs);
         }

         Console.WriteLine("Nom du joueur Rouge: \"{0}\"", joueurRouge.Nom);
         // Valide que le nom n'est pas vide
         if (joueurRouge.Nom.Length == 0)
         {
            IndiquerErreur("Le nom du joueur ne devrait pas être vide", ref nbErreurs);
         }

         // Valide que le nom ne contient pas d'espaces superflues
         if (joueurRouge.Nom.Length != joueurRouge.Nom.Trim().Length)
         {
            IndiquerErreur("Le nom du joueur ne devrait pas contenir d'espaces superflues", ref nbErreurs);
         }

         // La création d'un joueur doit demander son nom
         Console.WriteLine("!!! DEVRAIT DEMANDER LE NOM DU JOUEUR Blanc >>>>");
         Joueur joueurBlanc = new Joueur(CouleurPion.Blanc);

         // Compare la couleur indiquée avec la couleur donnée à la création du joueur
         if (joueurBlanc.Couleur != CouleurPion.Blanc)
         {
            IndiquerErreur("La couleur du joueur Blanc est incorrecte", ref nbErreurs);
         }

         Console.WriteLine("Nom du joueur Blanc: \"{0}\"", joueurBlanc.Nom);
         // Valide que le nom n'est pas vide
         if (joueurBlanc.Nom.Length == 0)
         {
            IndiquerErreur("Le nom du joueur ne devrait pas être vide", ref nbErreurs);
         }

         // Valide que le nom ne contient pas d'espaces superflues
         if (joueurBlanc.Nom.Length != joueurBlanc.Nom.Trim().Length)
         {
            IndiquerErreur("Le nom du joueur ne devrait pas contenir d'espaces superflues", ref nbErreurs);
         }

         // Valide les points initiaux
         if (joueurBlanc.Points != 167)
         {
            IndiquerErreur("La valeur initiale des points du joueur est incorrecte", ref nbErreurs);
         }
         else
         {
            // Valide l'ajout de points
            joueurBlanc.AjouterPoints(20);
            if (joueurBlanc.Points != 187) // 167 + 20
            {
               IndiquerErreur("L'ajout de points est incorrecte", ref nbErreurs);
            }
            else
            {
               // Valide la soustraction de points
               joueurBlanc.EnleverPoints(40);
               if (joueurBlanc.Points != 147) // 187 - 40
               {
                  IndiquerErreur("La soustraction de points est incorrecte", ref nbErreurs);
               }
               else
               {
                  joueurBlanc.EnleverPoints(148);
                  if (joueurBlanc.Points != 147)
                  {
                     IndiquerErreur("La soustraction d'un trop grand nombre de points ne devrait pas être possible", ref nbErreurs);
                  }
                  else
                  {
                     joueurBlanc.EnleverPoints(146); // Points = 1
                     if (joueurBlanc.EstGagnant())
                     {
                        IndiquerErreur("Le joueur ne doit pas être considéré gagnant si son nombre de points est supérieur à 0", ref nbErreurs);
                     }
                     else
                     {
                        joueurBlanc.EnleverPoints(1); // Points = 0
                        // À 0 points, le joueur est gagnant
                        if (!joueurBlanc.EstGagnant())
                        {
                           IndiquerErreur("Le joueur doit être considéré gagnant si son nombre de points est 0", ref nbErreurs);
                        }
                     }
                  }
               }
            }
         }

         Pause(nbErreurs == 0 ? "OK" : "");

      }

      /// <summary>
      /// Test de la classe DeAJouer
      /// </summary>
      static void TestDeAJouer()
      {

         AfficherTitre("Test de la classe DeAJouer");
         int nbErreurs = 0;

         DeAJouer de = new DeAJouer();
         DeAJouer autreDe = new DeAJouer();

         // Validation de l'état initial
         if (de.EstJouable || autreDe.EstJouable)
         {
            IndiquerErreur("Un dé non lancé ne doit pas être jouable", ref nbErreurs);
         }

         // Compteur pour chaque valeur possible (L'index 0 n'est jamais utilisé)
         int[] compteurs = new int[7];

         // Effectue un grand nombre d'itérations pour valider l'aspect aléatoire
         const int NbIterations = 1000000;
         for (int i = 0; i < NbIterations; ++i)
         {
            // Lancer un dé lui assigne aléatoirement une valeur entre 1 et 6
            de.Lancer();
            if (de.Valeur < 1 || de.Valeur > 6)
            {
               IndiquerErreur("La valeur d'un dé doit être entre 1 et 6", ref nbErreurs);
               break;
            }
            else
            {
               // On compte le nombre d'occurences de chaque valeur
               compteurs[de.Valeur]++;
            }

            // Lancer un dé le rend jouable
            if (!de.EstJouable)
            {
               IndiquerErreur("Un dé nouvellement lancé doit être jouable", ref nbErreurs);
               break;
            }

            // Après la duplication, autreDe doit avoir la même valeur et le même statut que le dé d'origine
            autreDe.Dupliquer(de);
            if (de.Valeur != autreDe.Valeur || de.EstJouable != autreDe.EstJouable)
            {
               IndiquerErreur("La duplication des dés ne fonctionne pas", ref nbErreurs);
               break;
            }

            // Un dé ne se joue qu'une seule fois
            de.Jouer();
            autreDe.Jouer();
            if (de.EstJouable || autreDe.EstJouable)
            {
               IndiquerErreur("Un dé joué ne doit plus être jouable tant qu'il n'est pas relancé", ref nbErreurs);
               break;
            }
         }

         // Validation de la distribution aléatoire des valeurs
         if (nbErreurs == 0)
         {
            int probabilite = NbIterations / 6;
            for (int i = 1; i < compteurs.Length; ++i)
            {
               double diff = (double)(compteurs[i] - probabilite) / (double)probabilite;
               if (diff > 0.02 || diff < -0.02)
               {
                  IndiquerErreur("La distribution ne semble pas aléatoire.\n" +
                                 "Relancez le test.\n" +
                                 "Si le problème persiste, revoyez la génération des valeurs des dés.", ref nbErreurs);
                  break;
               }
            }
         }

         Pause(nbErreurs == 0 ? "OK" : "");

      }

      /// <summary>
      /// Test de la classe Gobelet
      /// </summary>
      static void TestGobelet()
      {

         AfficherTitre("Test de la classe Gobelet");
         int nbErreurs = 0;

         Gobelet gobelet = new Gobelet();

         // Le gobelet est vide tant qu'il n'est pas brassé
         if (!gobelet.EstVide)
         {
            IndiquerErreur("Le gobelet doit être vide au début", ref nbErreurs);
         }

         // Pour valider de des paires seront obtenues
         int nbPaires = 0;

         // Effectue un grand nombre d'itérations pour valider l'aspect aléatoire
         const int NbIterations = 1000;
         for (int i = 0; i < NbIterations; ++i)
         {
            // Lance les dés du gobelet
            gobelet.Brasser();
            if (gobelet.EstVide)
            {
               IndiquerErreur("Le gobelet ne doit pas être vide après un brassage", ref nbErreurs);
               break;
            }

            // Compteur pour chaque valeur possible (L'index 0 n'est jamais utilisé)
            int[] compteurs = new int[7];

            // Récupère le premier dé
            DeAJouer premierDe = gobelet.De(0);
            if (premierDe == null)
            {
               IndiquerErreur("L'index de dé 0 doit retourner un dé valide", ref nbErreurs);
               break;
            }
            compteurs[premierDe.Valeur]++;

            // Récupère le deuxième dé
            DeAJouer deuxiemeDe = gobelet.De(1);
            if (deuxiemeDe == null)
            {
               IndiquerErreur("L'index de dé 1 doit retourner un dé valide", ref nbErreurs);
               break;
            }
            compteurs[deuxiemeDe.Valeur]++;

            // Valide le statut des dés
            if (!premierDe.EstJouable || !deuxiemeDe.EstJouable)
            {
               IndiquerErreur("Les dés doivent être jouables après un brassage", ref nbErreurs);
               break;
            }

            // Vérifie que les valeurs obtenues (compteur > 0) sont considérées valides par le gobelet
            // et que les valeurs non obtenues (compteur == 0) sont considérées invalides
            for (int valeur = 1; valeur < compteurs.Length; ++valeur)
            {
               if ((compteurs[valeur] > 0 && !gobelet.EstValide(valeur)) ||
                   (compteurs[valeur] == 0 && gobelet.EstValide(valeur)))
               {
                  IndiquerErreur("EstValide ne retourne pas la bonne valeur", ref nbErreurs);
                  break;
               }
            }
            if (nbErreurs > 0)
            {
               break;
            }

            // Récupère le troisième dé
            DeAJouer troisiemeDe = gobelet.De(2);
            if (troisiemeDe == null)
            {
               IndiquerErreur("L'index de dé 2 doit retourner un dé valide", ref nbErreurs);
               break;
            }

            // Récupère le quatrième dé
            DeAJouer quatriemeDe = gobelet.De(3);
            if (quatriemeDe == null)
            {
               IndiquerErreur("L'index de dé 3 doit retourner un dé valide", ref nbErreurs);
               break;
            }

            //
            // S'il y a une paire
            //
            if (premierDe.Valeur == deuxiemeDe.Valeur)
            {
               ++nbPaires;
               // Tous les dés doivent être jouables avec la même valeur
               if (troisiemeDe.Valeur != premierDe.Valeur || quatriemeDe.Valeur != premierDe.Valeur ||
                   !troisiemeDe.EstJouable || !quatriemeDe.EstJouable)
               {
                  IndiquerErreur("En cas de paire, il doit y avoir 4 dés jouables avec la même valeur", ref nbErreurs);
                  break;
               }

               // On joue le premier dé
               gobelet.Jouer(premierDe.Valeur);
               if (!gobelet.EstValide(premierDe.Valeur))
               {
                  IndiquerErreur("Une même valeur est valide plusieurs fois dans le cas d'une paire", ref nbErreurs);
                  break;
               }
               if (gobelet.EstVide)
               {
                  IndiquerErreur("Le gobelet ne doit pas être vide, il devrait rester 3 dés à jouer", ref nbErreurs);
                  break;
               }

               // On joue le deuxième dé
               gobelet.Jouer(deuxiemeDe.Valeur);
               if (!gobelet.EstValide(deuxiemeDe.Valeur))
               {
                  IndiquerErreur("Une même valeur est valide plusieurs fois dans le cas d'une paire", ref nbErreurs);
                  break;
               }
               if (gobelet.EstVide)
               {
                  IndiquerErreur("Le gobelet ne doit pas être vide, il devrait rester 2 dés à jouer", ref nbErreurs);
                  break;
               }

               // On joue le troisième dé
               gobelet.Jouer(troisiemeDe.Valeur);
               if (!gobelet.EstValide(troisiemeDe.Valeur))
               {
                  IndiquerErreur("Une même valeur est valide plusieurs fois dans le cas d'une paire", ref nbErreurs);
                  break;
               }
               if (gobelet.EstVide)
               {
                  IndiquerErreur("Le gobelet ne doit pas être vide, il devrait rester 1 dé à jouer", ref nbErreurs);
                  break;
               }

               // Dernier dé, la valeur n'est plus valide aprés ce jeu
               gobelet.Jouer(quatriemeDe.Valeur);
               if (gobelet.EstValide(quatriemeDe.Valeur))
               {
                  IndiquerErreur("Un dé ne doit plus être jouable après avoir été joué", ref nbErreurs);
                  break;
               }
            }
            //
            // S'il n'y a pas de paire
            //
            else
            {
               // Seul des 2 premiers dés doivent être jouables
               if (troisiemeDe.EstJouable || quatriemeDe.EstJouable)
               {
                  IndiquerErreur("S'il n'y a pas de paire, seulement 2 dés sont jouables", ref nbErreurs);
                  break;
               }

               // On joue le premier dé
               gobelet.Jouer(premierDe.Valeur);
               if (gobelet.EstValide(premierDe.Valeur))
               {
                  IndiquerErreur("Un dé ne doit plus être jouable après avoir été joué", ref nbErreurs);
                  break;
               }
               if (gobelet.EstVide)
               {
                  IndiquerErreur("Le gobelet ne doit pas être vide, il devrait rester 1 dé à jouer", ref nbErreurs);
                  break;
               }

               // On joue le deuxième dé
               gobelet.Jouer(deuxiemeDe.Valeur);
               if (gobelet.EstValide(deuxiemeDe.Valeur))
               {
                  IndiquerErreur("Un dé ne doit plus être jouable après avoir été joué", ref nbErreurs);
                  break;
               }
            }

            // Tous les dés ont été joués
            if (!gobelet.EstVide)
            {
               IndiquerErreur("Le gobelet doit être vide lorsque tous les dés sont joués", ref nbErreurs);
               break;
            }

            // Un index invalide (autre que 0, 1, 2 ou3) retourne null
            DeAJouer deInvalide1 = gobelet.De(-1);
            DeAJouer deInvalide2 = gobelet.De(4);
            if (deInvalide1 != null || deInvalide2 != null)
            {
               IndiquerErreur("Un index de dé invalide doit retourner null", ref nbErreurs);
               break;
            }
         }

         // Avec un grand nombre d'itérations, des paires auraient dû être obtenues
         if (nbErreurs == 0 && nbPaires == 0)
         {
            IndiquerErreur("Aucune paire n'a été brasser dans " + NbIterations + " itérations, c'est peu probable", ref nbErreurs);
         }

         if (nbErreurs == 0)
         {
            // Effectue un grand nombre d'itérations pour valider l'aspect aléatoire
            for (int i = 0; i < NbIterations; ++i)
            {
               gobelet.BrasserSansPaire();
               DeAJouer premierDe = gobelet.De(0);
               DeAJouer deuxiemeDe = gobelet.De(1);

               // BrasserSansPaire ne doit jamais générer de paire
               if (premierDe.Valeur == deuxiemeDe.Valeur)
               {
                  IndiquerErreur("Une paire a été obtenue avec BrasserSansPaire", ref nbErreurs);
                  break;
               }

               // Les dés doivent être jouable
               if (!premierDe.EstJouable || !deuxiemeDe.EstJouable)
               {
                  IndiquerErreur("BrasserSansPaire doit générer des dés jouables", ref nbErreurs);
                  break;
               }

               // Seul des 2 premiers dés doivent être jouables
               DeAJouer troisiemeDe = gobelet.De(2);
               DeAJouer quatriemeDe = gobelet.De(3);
               if (troisiemeDe.EstJouable || quatriemeDe.EstJouable)
               {
                  IndiquerErreur("S'il n'y a pas de paire, seulement 2 dés sont jouables", ref nbErreurs);
                  break;
               }
            }
         }

         Pause(nbErreurs == 0 ? "OK" : "");

      }

      /// <summary>
      /// Test de la classe Fleche
      /// </summary>
      static void TestFleche()
      {

         AfficherTitre("Test de la classe Fleche");
         int nbErreurs = 0;

         Fleche fleche = new Fleche();

         // Pions qui seront placés sur la flèche
         Pion pionRouge1 = new Pion(CouleurPion.Rouge);
         Pion pionRouge2 = new Pion(CouleurPion.Rouge);
         Pion pionBlanc = new Pion(CouleurPion.Blanc);
         Pion autrePion;

         //
         // Valider que la flèche est initialement vide
         // et se comporte comme une flèche doit le faire
         //
         if (fleche.NbPions != 0)
         {
            IndiquerErreur("Initialement, la flèche ne doit contenir aucun pion", ref nbErreurs);
         }

         if (!fleche.EstVide)
         {
            IndiquerErreur("Initialement, la flèche doit être vide", ref nbErreurs);
         }

         autrePion = fleche.DernierPion();
         if (autrePion != null)
         {
            IndiquerErreur("Une flèche vide doit retourner null", ref nbErreurs);
         }

         if (fleche.PeutRetirer(pionRouge1) || fleche.PeutRetirer(pionBlanc))
         {
            IndiquerErreur("Impossible de retirer d'une flèche vide", ref nbErreurs);
         }

         if (!fleche.PeutAjouter(pionRouge1))
         {
            IndiquerErreur("Tout pion doit pouvoir être ajouté à une flèche vide", ref nbErreurs);
         }

         if (fleche.EstUneFrappe(pionRouge1))
         {
            IndiquerErreur("Un ajout à une flèche vide n'est pas une frappe", ref nbErreurs);
         }

         //
         // Ajout d'un pion
         //
         fleche.Ajouter(pionRouge1);

         // Un pion rouge présent
         if (fleche.NbPions != 1)
         {
            IndiquerErreur("Après un ajout, le nombre de pions doit être 1", ref nbErreurs);
         }

         if (fleche.EstVide)
         {
            IndiquerErreur("Après un ajout, la flèche n'est pas vide", ref nbErreurs);
         }

         autrePion = fleche.DernierPion();
         if (autrePion == null)
         {
            IndiquerErreur("Une flèche non-vide doit retourner un pion", ref nbErreurs);
         }
         else if (!autrePion.EstDeMemeCouleurQue(pionRouge1))
         {
            IndiquerErreur("Le pion retourné n'est pas le pion ajouté", ref nbErreurs);
         }

         if (!fleche.PeutRetirer(pionRouge1))
         {
            IndiquerErreur("Doit pouvoir retirer le pion ajouté", ref nbErreurs);
         }
         if (fleche.PeutRetirer(pionBlanc))
         {
            IndiquerErreur("Impossible de retirer un pion d'une autre couleur", ref nbErreurs);
         }

         //
         // Ajout d'un autre pion de même couleur
         //
         if (!fleche.PeutAjouter(pionRouge2))
         {
            IndiquerErreur("Doit pouvoir ajouté un pion de la même couleur", ref nbErreurs);
         }

         if (fleche.EstUneFrappe(pionRouge2))
         {
            IndiquerErreur("L'ajout d'un pion de même couleur n'est pas une frappe", ref nbErreurs);
         }

         if (!fleche.PeutAjouter(pionBlanc))
         {
            IndiquerErreur("Doit pouvoir ajouté un pion adverse si seulement 1 pion est présent", ref nbErreurs);
         }

         if (!fleche.EstUneFrappe(pionBlanc))
         {
            IndiquerErreur("L'ajout d'un pion Blanc sur un pion Rouge est une frappe", ref nbErreurs);
         }

         fleche.Ajouter(pionRouge2);

         // Deux pions rouges présents
         if (fleche.NbPions != 2)
         {
            IndiquerErreur("Après deux ajouts, le nombre de pions doit être 2", ref nbErreurs);
         }

         if (fleche.EstVide)
         {
            IndiquerErreur("Après deux ajouts, la flèche n'est pas vide", ref nbErreurs);
         }

         autrePion = fleche.DernierPion();
         if (autrePion == null)
         {
            IndiquerErreur("Une flèche non-vide doit retourner un pion", ref nbErreurs);
         }
         else if (!autrePion.EstDeMemeCouleurQue(pionRouge2))
         {
            IndiquerErreur("Le pion retourné n'est pas le pion ajouté", ref nbErreurs);
         }

         if (!fleche.PeutRetirer(pionRouge1))
         {
            IndiquerErreur("Doit pouvoir retirer le pion ajouté", ref nbErreurs);
         }
         if (fleche.PeutRetirer(pionBlanc))
         {
            IndiquerErreur("Impossible de retirer un pion d'une autre couleur", ref nbErreurs);
         }

         // Tentative d'un ajout d'un pion d'une autre couleur
         if (fleche.PeutAjouter(pionBlanc))
         {
            IndiquerErreur("Ne doit pas pouvoir ajouté un pion adverse sur plus d'un pion", ref nbErreurs);
         }

         if (fleche.EstUneFrappe(pionBlanc))
         {
            IndiquerErreur("L'ajout d'un pion Blanc sur deux pions Rouges n'est pas une frappe", ref nbErreurs);
         }

         // Retrait du 2e pion
         autrePion = fleche.Retirer();
         if (autrePion == null)
         {
            IndiquerErreur("Le pion retirer ne doit pas être null", ref nbErreurs);
         }
         else if (!autrePion.EstDeMemeCouleurQue(pionRouge1))
         {
            IndiquerErreur("Le pion retirer n'est pas valide", ref nbErreurs);
         }

         // Il reste 1 pion rouge
         if (fleche.NbPions != 1)
         {
            IndiquerErreur("Après un 1er retrait, le nombre de pions doit être 1", ref nbErreurs);
         }

         if (fleche.EstVide)
         {
            IndiquerErreur("Après un 1er retrait, la flèche n'est pas vide", ref nbErreurs);
         }

         if (!fleche.PeutRetirer(pionRouge1))
         {
            IndiquerErreur("Doit pouvoir retirer le pion ajouté", ref nbErreurs);
         }

         // Retrait du 1er pion
         autrePion = fleche.Retirer();
         if (autrePion == null)
         {
            IndiquerErreur("Le pion retirer ne doit pas être null", ref nbErreurs);
         }
         else if (!autrePion.EstDeMemeCouleurQue(pionRouge1))
         {
            IndiquerErreur("Le pion retirer n'est pas valide", ref nbErreurs);
         }

         // La flèche est vide
         if (fleche.NbPions != 0)
         {
            IndiquerErreur("Après tous les retraits, la flèche ne doit contenir aucun pion", ref nbErreurs);
         }

         if (!fleche.EstVide)
         {
            IndiquerErreur("Après tous les retraits, la flèche doit être vide", ref nbErreurs);
         }

         // Ajout d'un pion Blanc
         if (!fleche.PeutAjouter(pionBlanc))
         {
            IndiquerErreur("Tout pion doit pouvoir être ajouté à une flèche vide", ref nbErreurs);
         }

         if (fleche.EstUneFrappe(pionBlanc))
         {
            IndiquerErreur("Un ajout à une flèche vide n'est pas une frappe", ref nbErreurs);
         }

         for (int i = 0; i < 15; ++i)
         {
            fleche.Ajouter(new Pion(CouleurPion.Blanc));
            if (fleche.NbPions != (i + 1))
            {
               IndiquerErreur("La flèche derait contenir " + (i + 1) + " pions", ref nbErreurs);
            }
         }

         Pause(nbErreurs == 0 ? "OK" : "");

      }

      /// <summary>
      /// Afficher le menu et demande le choix de l'utilisateur
      /// </summary>
      /// <returns>Le choix de l'utilisateur, en majuscules, sans espaces surperflues</returns>
      static string AfficherMenu()
      {
         Console.Clear();
         AfficherTitre("Test des classes du jeu de Backgammon");
         Console.WriteLine(" P) Tester la classe Pion");
         Console.WriteLine(" J) Tester la classe Joueur");
         Console.WriteLine(" D) Tester la classe DeAJouer");
         Console.WriteLine(" G) Tester la classe Gobelet");
         Console.WriteLine(" F) Tester la classe Fleche");
         Console.WriteLine(" T) Tester toutes les classes");
         Console.WriteLine(" Q) Quitter");
         Console.Write("\nVotre choix: ");

         // On convertit le choix en majuscule pour limiter les comparaisons
         // et on supprimer les espaces superflues
         return Console.ReadLine().ToUpper().Trim();
      }

      /// <summary>
      /// Exécute la méthode demandée
      /// </summary>
      /// <param name="choix">Le choix de l'utilisateur qui détermine la méthode à exécuter</param>
      static void Executer(string choix)
      {
         switch (choix)
         {
            case "P":
               TestPion();
               break;
            case "J":
               TestJoueur();
               break;
            case "D":
               TestDeAJouer();
               break;
            case "G":
               TestGobelet();
               break;
            case "F":
               TestFleche();
               break;
            case "T":
               TestPion();
               TestJoueur();
               TestDeAJouer();
               TestGobelet();
               TestFleche();
               break;
            case "":
               break;
            default:
               Pause("Choix invalide");
               break;
         }
      }

      /// <summary>
      /// Affiche le titre donné, en ajoutant 2 lignes de tirets de la même longeur
      /// </summary>
      /// <param name="titre">Le titre à afficher</param>
      static void AfficherTitre(string titre)
      {
         string tirets = new string('-', titre.Length);

         Console.WriteLine(tirets);
         Console.WriteLine(titre);
         Console.WriteLine(tirets);
      }

      /// <summary>
      /// Affiche un message d'erreur et incrémente le nombre d'erreurs
      /// </summary>
      /// <param name="message">Le message à afficher</param>
      /// <param name="nbErreurs">Le nombre d'erreurs à incrémenter</param>
      static void IndiquerErreur(string message, ref int nbErreurs)
      {
         ++nbErreurs;
         Console.WriteLine("ERREUR: " + message);
      }

      /// <summary>
      /// Pause le programme pour laisser le temps à l'utilisateur de lire la console
      /// </summary>
      /// <param name="message">Message à afficher</param>
      static void Pause(string message)
      {
         Console.WriteLine(message);
         Console.WriteLine("Appuyez sur une touche pour continuer...");
         Console.ReadKey(true);
      }
   }
}
