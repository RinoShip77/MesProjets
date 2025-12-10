import 'package:flutter/material.dart';
import 'package:macro_vision/screens/camera_screen.dart';
import 'package:macro_vision/screens/dashboard_screen.dart';
import 'package:macro_vision/screens/feedback_screen.dart';
import 'package:macro_vision/screens/settings_screen.dart';
import 'package:macro_vision/screens/user_profile_screen.dart';
import 'package:macro_vision/helpers/helpers.dart';
// Import du parseur markdown. Nécessaire si vous voulez manipuler les nœuds

// Convertir en StatefulWidget
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // static const String _guideSeenKey = 'hasSeenUserGuide';
  // String _guideText = 'Chargement des instructions...';
  String _guideText = '';

  @override
  void initState() {
    super.initState();
    // loadGuideText();
  }

  // =========================================================================
  // LOGIQUE DU GUIDE UTILISATEUR
  // =========================================================================

  Future<String> getGuideText() async {
  // Future<void> loadGuideText() async {
    if (_guideText.isNotEmpty) {
      return _guideText;
    }
    try {
      final String text = await DefaultAssetBundle.of(
        context,
      ).loadString('assets/user_guide.md', cache: false);

      if (mounted) {
        setState(() {
          // Met en cache le texte pour les clics suivants
          _guideText = text;
        });
      }
      return text;
    } catch (e) {
      // if (mounted) {
      //   setState(() {
      //     _guideText = 'Erreur lors du chargement des instructions.';
      //   });
        if (context.mounted) {
          showSnackBar(
            context,
            'Erreur: Impossible de lire le guide utilisateur.',
            true,
          );
        }
        return 'Erreur lors du chargement des instructions.';
      // }
    }
  }

  // =========================================================================
  // WIDGET BUILD
  // =========================================================================
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
      body: Stack(
        children: [
          Center(
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
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
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

          // --- Positioned container for both FABs ---
          Positioned(
            // top: 90.0 ensures space below the 56.0 height AppBar
            top: 10.0,
            left: 10.0, // Standard margin from the left edge
            child: Column(
              mainAxisSize: MainAxisSize.min, // Keep column tight
              crossAxisAlignment:
                  CrossAxisAlignment.start, // Align buttons to the left
              children: <Widget>[
                FloatingActionButton(
                  heroTag: 'feedbackBtn',
                  tooltip: 'Retour utilisateur.',
                  onPressed: () => navigate(context, const FeedbackScreen()),
                  child: const Icon(Icons.feedback_rounded),
                ),

                SizedBox(height: 10), // Vertical spacing

                FloatingActionButton(
                  heroTag: 'guideBtn', // Must be unique
                  tooltip: 'Guide d\'utilisation.',
                  onPressed: () async =>
                      // showUserGuide(context),
                      await openDialog(context, 'Guide d\'utilisation', await getGuideText()), // Navigate to a different screen
                  child: const Icon(Icons.info_outline_rounded), // A different icon
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
