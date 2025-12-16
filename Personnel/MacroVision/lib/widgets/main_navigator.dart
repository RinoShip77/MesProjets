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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // L'AppBar sera maintenant dans chaque écran si nécessaire,
      // ou vous pouvez l'intégrer ici si elle est vraiment universelle.
      // Pour les BottomNavigators, il est souvent préférable de laisser l'AppBar
      // dans les écrans individuels pour une meilleure flexibilité.

      // 4. Afficher l'écran correspondant à l'index
      body: AnimatedSwitcher(
        // 1. La durée de la transition (doit être similaire à celle de la barre de navigation)
        duration: const Duration(milliseconds: 350),

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
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(
              context,
            ).colorScheme.surface, // Couleur de fond de la barre
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                offset: const Offset(0, -2),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              // 💡 Élément 1 : Settings
              _buildCustomNavItem(
                context: context,
                index: 0,
                unselectedIcon: Icons.settings_applications_outlined,
                selectedIcon: Icons.settings,
                label: 'Paramètres',
                selectedIndex: _selectedIndex,
                onTap: _onItemTapped,
              ),
              // 💡 Élément 2 : Dashboard
              _buildCustomNavItem(
                context: context,
                index: 1,
                unselectedIcon: Icons.insert_chart_outlined_outlined,
                selectedIcon: Icons.bar_chart_rounded,
                label: 'Tableau de bord',
                selectedIndex: _selectedIndex,
                onTap: _onItemTapped,
              ),
              // 💡 Élément 3 : Home
              _buildCustomNavItem(
                context: context,
                index: 2,
                unselectedIcon: Icons.home_outlined,
                selectedIcon: Icons.home_rounded,
                label: 'Historique',
                selectedIndex: _selectedIndex,
                onTap: _onItemTapped,
              ),
              // 💡 Élément 4 : Profile
              _buildCustomNavItem(
                context: context,
                index: 3,
                unselectedIcon: Icons.person_outline_rounded,
                selectedIcon: Icons.person,
                label: 'Profil',
                selectedIndex: _selectedIndex,
                onTap: _onItemTapped,
              ),
              // 💡 Élément 5 : Feedback
              _buildCustomNavItem(
                context: context,
                index: 4,
                unselectedIcon: Icons.feedback_outlined,
                selectedIcon: Icons.feedback,
                label: 'Commentaire',
                selectedIndex: _selectedIndex,
                onTap: _onItemTapped,
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Dans un nouveau fichier ou dans main_navigator.dart

  Widget _buildCustomNavItem({
    required int index,
    required IconData unselectedIcon,
    required IconData selectedIcon,
    required String label,
    required int selectedIndex,
    required ValueChanged<int> onTap,
    required BuildContext context,
  }) {
    final isSelected = index == selectedIndex;
    final theme = Theme.of(context);

    return Expanded(
      child: InkWell(
        onTap: () => onTap(index),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AnimatedContainer(
                // 💡 LE CONTENEUR ANIMÉ POUR LE BACKGROUND
                duration: const Duration(milliseconds: 350),
                curve: Curves.fastOutSlowIn,
                padding: const EdgeInsets.all(15.0),
                decoration: BoxDecoration(
                  color: isSelected
                      ? theme
                            .colorScheme
                            .primaryContainer // 💡 COULEUR DE FOND QUAND SÉLECTIONNÉ
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(25), // Forme arrondie
                ),
                child: Icon(
                  isSelected ? selectedIcon : unselectedIcon,
                  color: isSelected
                      ? theme.colorScheme.primary
                      : theme.colorScheme.onSurfaceVariant,
                  size: isSelected ? 35 : 20,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
