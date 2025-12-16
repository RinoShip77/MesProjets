import 'package:flutter/material.dart';
import 'package:macro_vision/screens/dashboard_screen.dart';
import 'package:macro_vision/screens/feedback_screen.dart';
import 'package:macro_vision/screens/home_screen.dart';
import 'package:macro_vision/screens/settings_screen.dart';
import 'package:macro_vision/screens/user_profile_screen.dart';
// Importez tous les écrans que vous souhaitez avoir dans la barre de navigation.
// Exemple hypothétique: SettingsScreen()

class MainNavigator extends StatefulWidget {
  const MainNavigator({super.key});

  @override
  State<MainNavigator> createState() => _MainNavigatorState();
}

class _MainNavigatorState extends State<MainNavigator> {
  final Duration animationDuration = Duration(milliseconds: 400);

  // 1. Liste des Widgets (écrans) à afficher
  final List<Widget> _screens = [
    const SettingsScreen(),
    const DashboardScreen(),
    const HomeScreen(),
    const UserProfileScreen(),
    const FeedbackScreen(),
    // Ajoutez d'autres écrans principaux ici:
  ];

  // 2. Index de l'écran actuellement sélectionné (commence par l'Accueil)
  int _selectedIndex = 2;

  // 3. Action lors de la sélection d'un nouvel élément
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // La largeur moyenne d'un élément dans la Row de 5 éléments
  double _getNavItemWidth(BuildContext context) {
    return MediaQuery.of(context).size.width / _screens.length;
  }

  // Position X de l'élément sélectionné (centre de l'icône)
  double _getFabPosition(BuildContext context, int index) {
    final itemWidth = _getNavItemWidth(context);
    // Centre de l'icône : (index + 0.5) * itemWidth
    return (index + 0.5) * itemWidth;
  }

  // Fichier : lib/screens/main_navigator.dart

  Widget _buildNavItem(
    BuildContext context, {
    required int index,
    required IconData? selectedIcon,
    required IconData? unselectedIcon,
    required String label,
    required int selectedIndex,
    required ValueChanged<int> onTap,
  }) {
    final isSelected = index == selectedIndex;
    final double iconSize = isSelected ? 40.0 : 25.0;
    final IconData? iconData = isSelected ? selectedIcon : unselectedIcon;
    final Color iconColor = isSelected
        ? Theme.of(context).colorScheme.primary
        : Theme.of(context).colorScheme.onSurfaceVariant;

    return Expanded(
      child: InkWell(
        onTap: () => onTap(index),
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // 💡 1. RÉINTRODUIRE L'ANIMATEDCONTAINER POUR LE FOND ET LA FORME
              AnimatedContainer(
                duration: animationDuration, // Utiliser votre durée d'animation
                curve: Curves.fastEaseInToSlowEaseOut,

                // 💡 Propriétés à animer pour le fond
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0), // Forme arrondie
                ),

                // 💡 2. LE WIDGET ENFANT (VOTRE CONTENU D'ICÔNE) EST MAINTENANT LE TOOLTIP
                child: Tooltip(
                  message: label,
                  child: AnimatedSwitcher(
                    duration: animationDuration,
                    child: Icon(
                      // La clé est essentielle pour que AnimatedSwitcher détecte le changement
                      iconData,
                      key: ValueKey<int>(selectedIndex),
                      color: iconColor, // Couleur définie ici
                      size: iconSize, // Taille définie ici
                    ),
                  ),
                ),
              ),

              // Tooltip(
              //   message: label,
              //   child:
              //       // L'icône change de couleur, mais n'a plus de fond animé ici
              //       Icon(
              //         isSelected ? selectedIcon : unselectedIcon,
              //         color: isSelected
              //             ? Theme.of(context)
              //                   .colorScheme
              //                   .primary // Couleur active
              //             : Theme.of(context).colorScheme.onSurfaceVariant,
              //         size: isSelected ? 40 : 20,
              //       ),
              // ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final itemWidth = _getNavItemWidth(context);

    return Scaffold(
      // L'AppBar sera maintenant dans chaque écran si nécessaire,
      // ou vous pouvez l'intégrer ici si elle est vraiment universelle.
      // Pour les BottomNavigators, il est souvent préférable de laisser l'AppBar
      // dans les écrans individuels pour une meilleure flexibilité.

      // 4. Afficher l'écran correspondant à l'index
      body: AnimatedSwitcher(
        // 1. La durée de la transition (doit être similaire à celle de la barre de navigation)
        duration: animationDuration,

        // 2. La courbe d'animation (pour la sensation)
        switchInCurve: Curves.easeIn,
        switchOutCurve: Curves.easeOut,

        // 3. Le type de transition (FadeTransition est souvent le meilleur pour les onglets)
        transitionBuilder: (Widget child, Animation<double> animation) {
          // Nous utilisons FadeTransition pour une transition en fondu simple et fluide.
          return FadeTransition(opacity: animation, child: child);

          // Alternative : Utiliser une transition qui glisse légèrement
          // return SlideTransition(
          //   position: Tween<Offset>(
          //     begin: const Offset(1.0, 0.0), // Vient de la droite
          //     end: Offset.zero,
          //   ).animate(animation),
          //   child: child,
          // );
        },

        // 4. Le Widget enfant dont on suit l'état (l'écran sélectionné)
        child: Center(
          // Utiliser la clé (key) est CRUCIAL pour que l'AnimatedSwitcher sache que le widget a changé.
          // On utilise un ValueKey basé sur l'index pour forcer la détection du changement.
          key: ValueKey<int>(_selectedIndex),
          child: _screens.elementAt(_selectedIndex),
        ),
      ),

      // 5. La barre de navigation inférieure
      bottomNavigationBar: SafeArea(
        top: false,
        child: Padding(
          padding: EdgeInsetsGeometry.only(top: 10),
          child: Stack(
            children: [
              // ----------------------------------------------------
              // A) L'Animation du Fond Coloré (La Goutte d'Eau)
              // ----------------------------------------------------
              AnimatedPositioned(
                duration: animationDuration,
                curve:
                    Curves.easeInOut, // Pour le déplacement horizontal fluide
                // Position X : Centre de l'icône sélectionnée - rayon de la bulle
                left:
                    _getFabPosition(context, _selectedIndex) -
                    (itemWidth * 0.4),
                top: 0,
                bottom: 0,
                child: AnimatedOpacity(
                  // Animation de transparence
                  opacity: 1.0, // On le garde opaque pour l'instant
                  duration: animationDuration,

                  child: Container(
                    width:
                        itemWidth *
                        0.8, // Largeur de la bulle (80% de la largeur d'un item)
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primaryContainer,
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                  ),
                ),
              ),

              // ----------------------------------------------------
              // B) Les Icônes et Libellés (Superposés)
              // ----------------------------------------------------
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: _screens.asMap().entries.map((entry) {
                  final index = entry.key;

                  return _buildNavItem(
                    context,
                    index: index,
                    selectedIcon: switch (index) {
                      0 => Icons.settings,
                      1 => Icons.bar_chart_rounded,
                      2 => Icons.home_rounded,
                      3 => Icons.person,
                      4 => Icons.feedback,
                      _ => Icons.not_interested_rounded,
                    },
                    unselectedIcon: switch (index) {
                      0 => Icons.settings_applications_outlined,
                      1 => Icons.insert_chart_outlined_rounded,
                      2 => Icons.home_outlined,
                      3 => Icons.person_outline_rounded,
                      4 => Icons.feedback_outlined,
                      _ => Icons.not_interested_rounded,
                    },
                    label: switch (index) {
                      0 => 'Paramètres',
                      1 => 'Tableau de bord',
                      2 => 'Accueil',
                      3 => 'Profil',
                      4 => 'Commentaire',
                      _ => 'Item $index',
                    },
                    selectedIndex: _selectedIndex,
                    onTap: _onItemTapped,
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
