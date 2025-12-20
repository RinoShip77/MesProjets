// Fichier : lib/screens/initialization_screen.dart

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:macro_vision/services/database_service.dart';
import 'package:macro_vision/utils/global_key.dart';
import 'package:macro_vision/widgets/main_navigator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:macro_vision/helpers/helpers.dart';
import 'package:macro_vision/utils/l10n_extension.dart';

class InitializationScreen extends StatefulWidget {
  const InitializationScreen({super.key});

  @override
  State<InitializationScreen> createState() => _InitializationScreenState();
}

class _InitializationScreenState extends State<InitializationScreen> {
  // Clé et état de l'écran
  static const String _guideSeenKey = 'hasSeenUserGuide';
  static const String _dbSeededKey = 'hasSeededDatabase';
  String _warningText = globalL10n.initializationScreenDialogDefaultLbl(
    'legalWarning',
  );
  String _guideText = globalL10n.initializationScreenDialogDefaultLbl(
    'userGuide',
  );

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

    if (mounted) {
      if (hasSeenGuide) {
        // Naviguer vers l'écran principal
        navigate(context, const MainNavigator());
      } else {
        // Afficher le guide suivi de l'avertissement légal
        openDialog(
          context: context,
          title: context.l10n.appDialogTitle('userGuide'),
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
      // Chargement de l'avertissement
      final warningFuture = DefaultAssetBundle.of(
        context,
      ).loadString('assets/legal_warning.md', cache: false);

      // Chargement du guide
      final guideFuture = DefaultAssetBundle.of(
        context,
      ).loadString('assets/user_guide.md', cache: false);

      // Attendre que les deux futures soient terminées
      final results = await Future.wait([warningFuture, guideFuture]);

      if (mounted) {
        setState(() {
          _warningText = results[0]; // Stocke le contenu du fichier .md
          _guideText = results[1];
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _warningText = context.l10n.appErrorLoadingContent;
          _guideText = context.l10n.appErrorLoadingContent;
        });
        if (mounted) {
          showSnackBar(context, context.l10n.appErrorReadFile(''), true);
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
            Text(
              context.l10n.appLoadingLbl,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }
}
