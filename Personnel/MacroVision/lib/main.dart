import 'dart:async';
import 'dart:io' show Platform;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Packages Externes
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:macro_vision/config/l10n/app_localizations.dart';
import 'package:macro_vision/screens/error_screen.dart';
import 'package:macro_vision/utils/global_key.dart';
import 'package:macro_vision/utils/l10n_extension.dart';
import 'package:provider/provider.dart';

// Services et Modèles
import 'package:macro_vision/services/theme_provider.dart';
import 'package:macro_vision/services/database_service.dart';
import 'package:macro_vision/services/gemini_service.dart';
import 'package:macro_vision/config/app_theme.dart';

// Écrans de l'application
import 'package:macro_vision/screens/initialization_screen.dart';

// Définition de la locale par défaut (français canadien)
final Locale defaultLocale = Locale(
  WidgetsBinding.instance.platformDispatcher.locales.first.languageCode,
);

// ==========================================================
// 💡 NOUVEAU WIDGET : Gère l'état de la Locale pour toute l'application
// ==========================================================
class AppSetup extends StatefulWidget {
  const AppSetup({super.key});

  // Méthode statique pour accéder à l'état depuis n'importe où
  static _AppSetupState of(BuildContext context) =>
      context.findAncestorStateOfType<_AppSetupState>()!;

  @override
  State<AppSetup> createState() => _AppSetupState();
}

class _AppSetupState extends State<AppSetup> {
  Locale _currentLocale = defaultLocale;

  // 💡 Fonction pour changer la locale
  void setLocale(Locale newLocale) {
    setState(() {
      _currentLocale = newLocale;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MacroVisionApp(locale: _currentLocale);
  }
}

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
      // throw Exception(
      //   "SIMULATION: Erreur critique synchrone lors du chargement initial.",
      // );
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
          child: const AppSetup(),
        ),
      );
    },
    (Object e, StackTrace stack) {
      // Cette fonction est appelée lorsqu'une erreur non gérée se produit.
      // Afficher l'écran d'erreur personnalisé
      runApp(
        MultiProvider(
          providers: [
            ChangeNotifierProvider(
              create: (_) => ThemeProvider(),
            ), // Injecte le provider pour l'écran d'erreur
          ],
          child: Consumer<ThemeProvider>(
            builder: (context, themeProvider, child) {
              // On récupère la couleur de semence comme dans MacroVisionApp
              final MaterialColor selectedSeedColor =
                  themeProvider.themeModeOption == ThemeModeOption.custom
                  ? themeProvider.customTheme.color
                  : appPrimaryColor;
              return MaterialApp(
                // 💡 IMPORTANT : Il faut ajouter les délégués ici aussi !
                localizationsDelegates: AppLocalizations.localizationsDelegates,
                supportedLocales: AppLocalizations.supportedLocales,
                // On détecte la langue du système pour ce MaterialApp de secours
                locale: Locale(
                  WidgetsBinding
                      .instance
                      .platformDispatcher
                      .locales
                      .first
                      .languageCode,
                ),
                theme: ThemeData(
                  colorScheme: ColorScheme.fromSeed(seedColor: Theme.of(context).colorScheme.error),
                  useMaterial3: true,
                ),
                // 2. On utilise un Builder pour "descendre" d'un niveau dans l'arbre
                home: Builder(
                  builder: (context) {
                    return ErrorScreen(
                      message: context
                          .l10n
                          .appError, // ✅ Traduction réussie depuis main
                      details: kDebugMode ? e.toString() : null,
                    );
                  },
                ),
              );
            },
          ),
        ),
      );
    },
  );
}

class MacroVisionApp extends StatelessWidget {
  final Locale locale;
  const MacroVisionApp({super.key, required this.locale});

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
          // =========================================================
          // 💡 INTERNATIONALISATION : AJOUTER CES LIGNES
          // =========================================================
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('fr'), // French
            Locale('en'), // English
            Locale('es'), // Espagnol
            Locale('fil'), // Filipino
            Locale('hi'), // Hindi
            Locale('ja'), // Japanese
            Locale('sv'), // Swedish
            Locale('uk'), // Ukrainian
            Locale('zh'), // Chinese
            Locale('sw'), // Swahili
          ],

          locale:
              locale, // <-- FORCER LA LOCALE PAR DÉFAUT SELON LA LANGUE DE L'APPAREIL
          // =========================================================
          navigatorKey: navigatorKey,
          title: 'MacroVision',
          // Affiche que l'app est en mode DEBUG
          debugShowCheckedModeBanner: (kDebugMode && !kReleaseMode)
              ? true
              : false,
          themeMode: themeProvider.themeMode,
          theme: getLightTheme(selectedSeedColor),
          darkTheme: getDarkTheme(selectedSeedColor),
          home: const InitializationScreen(),
        );
      },
    );
  }
}
