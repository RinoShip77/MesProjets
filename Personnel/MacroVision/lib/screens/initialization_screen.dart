// Fichier : lib/screens/initialization_screen.dart

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:markdown_widget/markdown_widget.dart';
import 'package:macro_vision/helpers/helpers.dart';
import 'package:macro_vision/screens/home_screen.dart';

class InitializationScreen extends StatefulWidget {
  const InitializationScreen({super.key});

  @override
  State<InitializationScreen> createState() => _InitializationScreenState();
}

class _InitializationScreenState extends State<InitializationScreen> {
  static const String _guideSeenKey = 'hasSeenUserGuide';
  String _guideText = 'Chargement des instructions...';
  String _warningText = 'Chargement de l\'avertissement légal...';

  @override
  void initState() {
    super.initState();

    // Exécute l'initialisation après que le widget ait été monté
    WidgetsBinding.instance.addPostFrameCallback((_) {
      initializeData();
    });
  }

  // Fonction principale pour charger les données et gérer les dialogues
  Future<void> initializeData() async {
    // 1. CHARGEMENT ASYNCHRONE DES DONNÉES
    await loadAssets();

    final prefs = await SharedPreferences.getInstance();
    // Utilise un booléen simple pour cet exemple, mais la logique est dans _initializeData
    final hasSeen = prefs.getBool(_guideSeenKey) ?? false;

    // 2. GESTION DE L'AFFICHAGE (si première utilisation)
    // Vérifie que les deux textes sont chargés pour éviter des dialogues vides.
    if (!hasSeen &&
        mounted &&
        _guideText.length > 50 &&
        _warningText.length > 50) {
      // ÉTAPE 1: Afficher l'avertissement légal (maintenant avec le contenu du fichier)
      await openDialog(context, 'Avertissement légal', _warningText);
      // await showLegalWarning(context);

      // ÉTAPE 2: Puis afficher le guide
      await openDialog(context, 'Guide d\'utilisation', _guideText);
      // showUserGuide(context); /////////

      await saveHasSeenGuide();
    }

    // 3. NAVIGATION VERS L'ÉCRAN D'ACCUEIL
    if (mounted) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    }
  }

  // Nouvelle fonction pour charger les deux assets simultanément
  Future<void> loadAssets() async {
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

  Future<void> saveHasSeenGuide() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_guideSeenKey, true);
  }

  // Affiche l'écran de chargement pendant l'initialisation
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 20),
            Text("Préparation de l'application..."),
          ],
        ),
      ),
    );
  }
}
