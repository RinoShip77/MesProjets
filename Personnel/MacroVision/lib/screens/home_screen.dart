import 'package:flutter/material.dart';
import 'package:macro_vision/screens/dashboard_screen.dart';
import 'package:macro_vision/screens/settings_screen.dart';
import 'package:macro_vision/screens/user_profile_screen.dart';

// Convertir en StatefulWidget
class HomeScreen extends StatefulWidget {
  final Widget cameraScreen;

  const HomeScreen({super.key, required this.cameraScreen});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  
  // Fonction pour naviguer vers les réglages et attendre le retour
  void _navigateToSettings(BuildContext context) async {
    // Naviguer et attendre que l'écran SettingsScreen soit "popped" (fermé)
    await Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => const SettingsScreen()),
    );
    
    // Une fois revenu, force la reconstruction de l'HomeScreen. 
    // Ceci est crucial pour rafraîchir le contexte de l'application.
    setState(() {});
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MacroVision'),
        elevation: 0,
        actions: [
          // Bouton 1 : Réglages
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () => _navigateToSettings(context), // Appel de la fonction asynchrone
            tooltip: 'Réglages',
          ),
          // Bouton 2 : Connexion (Placeholder)
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {
              // Navigation vers le nouvel écran de profil
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const UserProfileScreen()),
              );
            },
            tooltip: 'Profil',
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo ou titre stylisé
            Icon(Icons.fitness_center, size: 100, color: Theme.of(context).colorScheme.primary),
            const SizedBox(height: 20),
            Text(
              'Bienvenue sur MacroVision',
              selectionColor: Theme.of(context).colorScheme.primary,
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 50),

            // NOUVEAU: Bouton vers le Tableau de Bord
            Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: OutlinedButton.icon(
                icon: const Icon(Icons.show_chart),
                label: const Text('Voir le Tableau de Bord'),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  side: BorderSide(color: Theme.of(context).colorScheme.primary, width: 2),
                  foregroundColor: Theme.of(context).colorScheme.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const DashboardScreen()),
                  );
                },
              ),
            ),
            
            // Bouton principal pour la caméra
            ElevatedButton.icon(
              icon: const Icon(Icons.camera_alt),
              label: const Text('Commencer l\'analyse', style: TextStyle(fontSize: 18)),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                // Utilisation de la couleur primaire dynamique
                backgroundColor: Theme.of(context).colorScheme.primary,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              onPressed: () {
                // Navigue vers l'écran de la caméra (qui utilisera le contexte rafraîchi)
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => widget.cameraScreen),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}