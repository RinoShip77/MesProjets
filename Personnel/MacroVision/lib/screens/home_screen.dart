import 'package:flutter/material.dart';
import 'package:macro_vision/screens/camera_screen.dart';
import 'package:macro_vision/screens/dashboard_screen.dart';
import 'package:macro_vision/screens/feedback_screen.dart';
import 'package:macro_vision/screens/settings_screen.dart';
import 'package:macro_vision/screens/user_profile_screen.dart';
import 'package:macro_vision/helpers/helpers.dart';

// Convertir en StatefulWidget
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MacroVision'),
        actions: [
          // Bouton 1 : Réglages
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () => navigate(context, SettingsScreen()),
            tooltip: 'Réglages',
          ),
          // Bouton 2 : Connexion
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () => navigate(context, UserProfileScreen()),
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
            Image(image: AssetImage('assets/images/home_logo.png')),

            const SizedBox(height: 20),

            Text(
              'Bienvenue sur MacroVision',
              style: Theme.of(
                context,
              ).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 50),

            // Bouton vers le Tableau de Bord
            Tooltip(
              message: 'Voir le tableau de bord.',
              child: OutlinedButton.icon(
              icon: const Icon(Icons.bar_chart_rounded),
              label: const Text('Voir le tableau de bord'),
              onPressed: () => navigate(context, DashboardScreen()),
            ),
            ),

            const SizedBox(height: 15),

            // Bouton principal pour la caméra
            Tooltip(
              message: 'Commencer l\'analyse.',
              child: ElevatedButton.icon(
                icon: const Icon(Icons.camera_enhance_rounded),
                label: const Text('Commencer l\'analyse'),
                onPressed: () => navigate(context, CameraScreen()),
              ),
            ),
          ],
        ),
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.miniStartTop,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(top: 90),
        child: FloatingActionButton(
          heroTag: 'feedbackBtn',
          tooltip: 'Retour utilisateur.',
          onPressed: () => navigate(context, const FeedbackScreen()),
          child: const Icon(Icons.feedback_rounded),
        ),
      ),
    );
  }
}
