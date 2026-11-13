import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:macro_vision/helpers/helpers.dart';
import 'package:macro_vision/utils/global_key.dart';
import 'package:macro_vision/utils/l10n_extension.dart';
import 'package:macro_vision/widgets/main_navigator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:macro_vision/services/database_service.dart';

class InitializationScreen extends StatefulWidget {
  const InitializationScreen({super.key});

  @override
  State<InitializationScreen> createState() => _InitializationScreenState();
}

class _InitializationScreenState extends State<InitializationScreen> {
  // Clé et état de l'écran
  static const String _guideSeenKey = 'hasSeenUserGuide';
  static const String _dbSeededKey = 'hasSeededDatabase';

  String _warningText = '';
  String _guideText = '';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initializeData();
    });
  }

  // =======================================================================
  // Fonction principale pour charger les données et gérer les dialogues
  // =======================================================================
  Future<void> _initializeData() async {
    const Duration minDuration = Duration(milliseconds: 2000);
    // const Duration minDuration = Duration(milliseconds: 3000);

    // 1. Do the work (Load Assets + Seed DB)
    final Future<void> loader = () async {
      await _loadAssets();

      if (kDebugMode) {
        final prefs = await SharedPreferences.getInstance();
        if (!(prefs.getBool(_dbSeededKey) ?? false)) {
          await DatabaseService().seedDatabaseForTesting();
          await prefs.setBool(_dbSeededKey, true);
        } else {
          debugPrint('[DB] Seed skipped: Data already exists.');
        }
      }
    }();

    // 2. Wait for Work + Min Delay
    await Future.wait([loader, Future.delayed(minDuration)]);

    // 3. CHECK FIRST RUN LOGIC
    if (!mounted) return;

    final prefs = await SharedPreferences.getInstance();
    final hasSeenGuide = prefs.getBool(_guideSeenKey) ?? false;

    if (mounted) {
      if (hasSeenGuide) {
        // CASE A: Returning User -> Go straight to App
        navigate(context, const MainNavigator(), replace: true);
      } else {
        // CASE B: First Run -> Show Sequence

        // Step 1: Show Guide (Wait for user to click "Compris!")
        if (mounted) {
          await openDialog(
            context: context,
            title: context.l10n.appDialogTitle('userGuide'),
            content: _guideText,
            buttonText: 'Compris!',
          );
        }

        // Step 2: Save that they saw it
        await prefs.setBool(_guideSeenKey, true);

        // Step 3: Show Legal Warning (Wait for user to click "Accepter")
        if (mounted) {
          await openDialog(
            context: context,
            title: context.l10n.appDialogTitle('legalWarning'),
            content: _warningText,
            buttonText: 'Accepter',
          );
        }

        // Step 4: Go to App
        if (mounted) {
          navigate(context, const MainNavigator(), replace: true);
        }
      }
    }
  }

  // ===============================================================================
  // Load both assets simultaneously
  // ==============================================================================

  Future<void> _loadAssets() async {
    try {
      final results = await Future.wait([
        loadLocalizedAsset(context, 'legal_warning'),
        loadLocalizedAsset(context, 'user_guide'),
      ]);
      // final results = await Future.wait([
      //   DefaultAssetBundle.of(context).loadString('assets/legal_warning.md'),
      //   DefaultAssetBundle.of(context).loadString('assets/user_guide.md'),
      // ]);

      if (mounted) {
        setState(() {
          _warningText = results[0];
          _guideText = results[1];
        });
      }
    } catch (e) {
      debugPrint('🔴 Asset Load Error: $e');
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
            const Image(
              // 🚨 Put the correct path of your logo here!
              image: AssetImage('assets/images/home_logo.png'),
              fit: BoxFit.contain,
            ),
            const SizedBox(),
            SizedBox(
              width: MediaQuery.sizeOf(context).width * 0.75,
              child: const LinearProgressIndicator(value: null, minHeight: 10),
            ),
            const SizedBox(height: 15),
            Text(
              context.l10n.appLoadingLbl,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }
}
