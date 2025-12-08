import 'package:flutter/material.dart';
import 'package:macro_vision/screens/camera_screen.dart';
import 'package:macro_vision/screens/dashboard_screen.dart';
import 'package:macro_vision/screens/settings_screen.dart';
import 'package:macro_vision/screens/user_profile_screen.dart';

// Convertir en StatefulWidget
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // TODO: Envoyer cette fonction de un fichier "helpers.dart"
  // Fonction pour naviguer vers les réglages et attendre le retour
  void _navigate(BuildContext context, screen) async {
    // Naviguer et attendre que l'écran SettingsScreen soit "popped" (fermé)
    await Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (context) => screen));

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
            onPressed: () => _navigate(context, const SettingsScreen()),
            tooltip: 'Réglages',
          ),
          // Bouton 2 : Connexion (Placeholder)
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () => _navigate(context, const UserProfileScreen()),
            tooltip: 'Profil',
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo ou titre stylisé
            // Icon(
            //   Icons.fitness_center,
            //   size: 150,
            //   color: Theme.of(context).colorScheme.primary,
            // ),
            Image(
              image: AssetImage(
                'assets/images/home_logo.png',
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Bienvenue sur MacroVision',
              style: Theme.of(
                context,
              ).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 50),

            // Bouton vers le Tableau de Bord
            OutlinedButton.icon(
              icon: const Icon(Icons.bar_chart_rounded),
              label: const Text('Voir le tableau de bord'),
              onPressed: () => _navigate(context, const DashboardScreen()),
            ),

            const SizedBox(height: 15),

            // Bouton principal pour la caméra
            ElevatedButton.icon(
              icon: const Icon(Icons.camera_alt),
              label: const Text('Commencer l\'analyse'),
              onPressed: () => _navigate(context, const CameraScreen()),
            ),
          ],
        ),
      ),
    );
  }
}
