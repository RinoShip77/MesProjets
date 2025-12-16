import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Packages Externes
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:macro_vision/screens/error_screen.dart';
import 'package:provider/provider.dart';

// Services et Modèles
import 'package:macro_vision/services/theme_provider.dart';
import 'package:macro_vision/services/database_service.dart';
import 'package:macro_vision/services/gemini_service.dart';
import 'package:macro_vision/config/app_theme.dart';

// Écrans de l'application
import 'package:macro_vision/screens/initialization_screen.dart';

Future<void> main() async {
  // =======================================================================
  // 💡 GESTION GLOBALE DES ERREURS PAR DART ZONE
  // =======================================================================
  runZonedGuarded<Future<void>>(
    () async {
      // Ensure the Flutter engine is initialized
      WidgetsFlutterBinding.ensureInitialized();

      // ADDED: Force the app to only run in portrait mode (up or down)
      await SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]);

      // =======================================================
      // 💡 TEST 1 : ERREUR SYNCHRONE CRITIQUE
      // Décommentez la ligne ci-dessous pour forcer une panne
      // =======================================================
      // throw Exception("SIMULATION: Erreur critique synchrone lors du chargement initial.");
      // =======================================================

      // --- LOGIQUE D'INITIALISATION ---
      try {
        // 1. CHARGEMENT DES VARIABLES D'ENVIRONNEMENT
        await dotenv.load(fileName: ".env");
        // 4. Initialisation de la Base de Données
        DatabaseService().database;
        GeminiService().initialize();
      } catch (e) {
        // Une erreur ici sera capturée par le runZonedGuarded
        rethrow; // Rejeter l'erreur pour qu'elle soit capturée par la Zone
      }

      // Lancement de l'application
      runApp(
        MultiProvider(
          providers: [ChangeNotifierProvider(create: (_) => ThemeProvider())],
          child: const MacroVisionApp(),
        ),
      );
    },
    (Object e, StackTrace stack) {
      // Cette fonction est appelée lorsqu'une erreur non gérée se produit.
      // Afficher l'écran d'erreur personnalisé
      runApp(
        MaterialApp(
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
            useMaterial3: true,
          ),
          home: ErrorScreen(
            message: "Une erreur critique s'est produite",
            details: kDebugMode
                ? e.toString()
                : null, // Détails uniquement en mode débogage
          ),
        ),
      );
    },
  );
}

class MacroVisionApp extends StatelessWidget {
  const MacroVisionApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        // Utiliser le thème de 'app_theme.dart'
        final MaterialColor selectedSeedColor =
            themeProvider.themeModeOption == ThemeModeOption.custom
            ? themeProvider.customTheme.color
            : appPrimaryColor;

        return MaterialApp(
          title: 'MacroVision',
          // Affiche que l'app est en mode DEBUG
          debugShowCheckedModeBanner: (kDebugMode && !kReleaseMode) ? true : false,
          themeMode: themeProvider.themeMode,
          theme: getLightTheme(selectedSeedColor),
          darkTheme: getDarkTheme(selectedSeedColor),

          // =========================================================
          // 💡 INTERNATIONALISATION : AJOUTER CES LIGNES
          // =========================================================
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('fr', 'CA'), // Français (Canada)
            Locale('en', 'CA'), // Anglais (Canada)
          ],

          locale: const Locale('fr', 'CA'), // <-- FORCER LA LOCALE PAR DÉFAUT
          // =========================================================
          home: const InitializationScreen(),
        );
      },
    );
  }
}
