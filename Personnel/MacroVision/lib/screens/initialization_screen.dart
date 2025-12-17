// Fichier : lib/screens/initialization_screen.dart

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:macro_vision/services/database_service.dart';
import 'package:macro_vision/widgets/main_navigator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:macro_vision/helpers/helpers.dart';
import 'package:macro_vision/helpers/l10n_extension.dart';

class InitializationScreen extends StatefulWidget {
  const InitializationScreen({super.key});

  @override
  State<InitializationScreen> createState() => _InitializationScreenState();
}

class _InitializationScreenState extends State<InitializationScreen> {
  // Clé et état de l'écran
  static const String _guideSeenKey = 'hasSeenUserGuide';
  static const String _dbSeededKey = 'hasSeededDatabase';
  String _guideText = 'Chargement des instructions...';
  String _warningText = 'Chargement de l\'avertissement légal...';

  @override
  void initState() {
    super.initState();

    // Exécute l'initialisation après que le widget ait été monté
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initializeData();
    });
  }

  // =======================================================================
  // Fonction principale pour charger les données et gérer les dialogues
  // =======================================================================
  Future<void> _initializeData() async {
    // Délai minimal pour éviter le "flash" sur les appareils rapides
    const Duration minDuration = Duration(milliseconds: 3000);

    // FUTURE A : Le travail réel de l'initialisation
    final Future<void> initializationWork = () async {
      await _loadAssets();

      final prefs = await SharedPreferences.getInstance();
      final hasSeeded = prefs.getBool(_dbSeededKey) ?? false;

      // Logique de peuplement unique de la base de données de test
      if (kDebugMode && !hasSeeded) {
        print("[DB] Début du peuplement de la base de données de test.");
        await DatabaseService().seedDatabaseForTesting();
        await prefs.setBool(_dbSeededKey, true);
        print("[DB] Peuplement terminé et drapeau levé.");
      } else if (kDebugMode) {
        print(
          "[DB] Le peuplement de la DB est ignoré car le drapeau est levé.",
        );
      }
    }();

    // FUTURE B : Le délai minimal.
    final Future<void> minTimeDelay = Future.delayed(minDuration);

    // Attendre que les DEUX Futures soient complétés.
    await Future.wait([initializationWork, minTimeDelay]);

    // 3. GESTION DE LA NAVIGATION
    final prefs = await SharedPreferences.getInstance();
    final hasSeenGuide = prefs.getBool(_guideSeenKey) ?? false;

    if (context.mounted) {
      if (hasSeenGuide) {
        // Naviguer vers l'écran principal
        navigate(context, const MainNavigator());
      } else {
        // Afficher le guide suivi de l'avertissement légal
        openDialog(
          context: context,
          title: 'Guide d\'utilisation',
          content: _guideText,
          warningContent: _warningText,
          key: _guideSeenKey,
        );
      }
    }
  }

  // ========================================================================
  // Charger les deux assets simultanément
  // =======================================================================
  Future<void> _loadAssets() async {
    // Logique de chargement des fichiers .md
    try {
      // Chargement du guide
      final guideFuture = DefaultAssetBundle.of(
        context,
      ).loadString('assets/user_guide.md', cache: false);

      // Chargement de l'avertissement
      final warningFuture = DefaultAssetBundle.of(
        context,
      ).loadString('assets/legal_warning.md', cache: false);

      // Attendre que les deux futures soient terminées
      final results = await Future.wait([guideFuture, warningFuture]);

      if (mounted) {
        setState(() {
          _guideText = results[0];
          _warningText = results[1]; // Stocke le contenu du fichier .md
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _guideText = 'Erreur lors du chargement des instructions.';
          _warningText = 'Erreur lors du chargement de l\'avertissement.';
        });
        if (context.mounted) {
          showSnackBar(
            context,
            "Erreur: Impossible de lire les fichiers de l'application.",
            true,
          );
        }
      }
    }
  }

  // Affiche l'écran de chargement pendant l'initialisation
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // 1. Image (Logo ou élément visuel central)
            // Si votre image est le cœur, vous pouvez garder le Icon,
            // sinon utilisez Image.asset. Utilisons Image.asset pour plus de généralité.
            Image(
              // 🚨 Mettre le chemin correct de votre logo ici !
              image: AssetImage('assets/images/home_logo.png'),
              fit: BoxFit.contain,
            ),

            const SizedBox(), // Grand espace entre l'image et la barre
            // 2. Linear Progress Indicator
            SizedBox(
              width:
                  MediaQuery.sizeOf(context).width *
                  0.75, // Largeur de la barre
              child: LinearProgressIndicator(
                // value: null = Indéterminé (pour un écran de chargement)
                value: null,
                minHeight: 10,
              ),
            ),

            const SizedBox(height: 15),

            // 3. Texte de chargement
            const Text(
              'Initialisation...',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }
}
