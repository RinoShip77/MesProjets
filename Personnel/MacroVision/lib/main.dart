import 'dart:async';
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
import 'package:macro_vision/widgets/fatal_error.dart';
import 'package:provider/provider.dart';

// Services et Modèles
import 'package:macro_vision/services/theme_provider.dart';
import 'package:macro_vision/services/database_service.dart';
import 'package:macro_vision/services/gemini_service.dart';
import 'package:macro_vision/config/app_theme.dart';

// Écrans de l'application
import 'package:macro_vision/screens/initialization_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  Locale get getLocale => _currentLocale;

  @override
  void initState() {
    super.initState();
    _loadLocalePreference();
  }

  // 💡 Fonction pour changer la locale
  Future<void> setLocale(Locale newLocale) async {
    setState(() => _currentLocale = newLocale);
    // Save the preference
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('user_language', newLocale.languageCode);
  }

  Future<void> _loadLocalePreference() async {
    final prefs = await SharedPreferences.getInstance();
    final String? savedLanguageCode = prefs.getString('user_language');
    if (savedLanguageCode != null) {
      setState(() => _currentLocale = Locale(savedLanguageCode));
    }
  }

  @override
  Widget build(BuildContext context) {
    return MacroVisionApp(locale: _currentLocale);
  }
}

// =======================================================================
// 💡 MAIN FUNCTION WITH UNIVERSAL ERROR HANDLING
// =======================================================================
Future<void> main() async {
  await runZonedGuarded<Future<void>>(
    () async {
      // Ensure the Flutter engine is initialized
      WidgetsFlutterBinding.ensureInitialized();

      // ADDED: Force the app to only run in portrait mode (up or down)
      await SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]);

      //region TEST CRASH
      // ===============================================================================
      // 💡 TEST 1: CRITICAL STARTUP CRASH/ERROR
      // Uncomment the line below to force a crash
      // ===============================================================================
      // throw Exception('☠️ TEST: Critical Startup Failure!');
      // ===============================================================================
      //endregion

      // 1. CATCH RENDER ERRORS ("Red Screen of Death")
      // Instead of the red box, we render the ErrorScreen directly in the tree.
      ErrorWidget.builder = (FlutterErrorDetails details) {
        return Material(
          child: ErrorScreen(
            message: 'Rendering Error',
            details: kDebugMode ? details.exceptionAsString() : null,
          ),
        );
      };

      // 2. CATCH FRAMEWORK ERRORS (Logic crashes managed by Flutter)
      FlutterError.onError = (FlutterErrorDetails details) {
        FlutterError.presentError(details); // Still print to console logs
        _handleFatalError(details.exception, details.stack);
      };

      // --- INIT LOGIC ---
      try {
        await dotenv.load(fileName: '.env');
        await DatabaseService().database;
        GeminiService().initialize();
      } catch (e) {
        rethrow; // Pass to ZonedGuard
      }

      runApp(
        MultiProvider(
          providers: [ChangeNotifierProvider(create: (_) => ThemeProvider())],
          child: const AppSetup(),
        ),
      );
    },
    _handleFatalError,
  );
}

/// 💡 UNIVERSAL ERROR HANDLER
/// Decides whether to use Navigation (smoother) or RunApp (nuclear fallback)
void _handleFatalError(Object error, StackTrace? stack) {
  debugPrint('🔴 FATAL ERROR CAUGHT: $error');

  // SCENARIO A: The App is running and we have a Navigator.
  // We push the full FatalErrorApp as a new route.
  // This essentially "nests" a fresh app inside the current window.
  if (navigatorKey.currentState != null) {
    try {
      navigatorKey.currentState!.pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (_) => FatalError(error: error),
        ),
        (route) => false, // Remove back history so user is stuck on error
      );
      return; // Success!
    } catch (e) {
      debugPrint('Could not use Navigator to show error: $e');
      // Fall through to Scenario B
    }
  }

  // SCENARIO B: Startup Crash or Navigator Missing.
  // We Re-Run the entire app using our safe widget.
  runApp(FatalError(error: error));
}

class MacroVisionApp extends StatelessWidget {
  final Locale locale;
  const MacroVisionApp({super.key, required this.locale});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return MaterialApp(
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('fr'), // French
            Locale('en'), // English
          ],

          locale: locale,
          navigatorKey: navigatorKey,
          title: 'MacroVision',
          // Shows that the app is in DEBUG mode
          debugShowCheckedModeBanner: (kDebugMode && !kReleaseMode)
              ? true
              : false,
          themeMode: themeProvider.themeMode,
          theme: getLightTheme(themeProvider.customTheme.color),
          darkTheme: getDarkTheme(themeProvider.customTheme.color),
          home: const InitializationScreen(),
        );
      },
    );
  }
}
