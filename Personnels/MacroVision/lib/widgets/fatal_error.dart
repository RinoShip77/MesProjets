import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/foundation.dart';
import 'package:macro_vision/screens/error_screen.dart';
import 'package:macro_vision/utils/l10n_extension.dart';
import 'package:macro_vision/services/theme_provider.dart';
import 'package:macro_vision/config/l10n/app_localizations.dart';

/// A self-contained application tree that runs when a fatal error occurs.
/// It brings its own ThemeProvider and Localization to ensure it can render
/// even if the main app is corrupted.
class FatalError extends StatelessWidget {
  final Object error;

  const FatalError({super.key, required this.error});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => ThemeProvider())],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            // Fallback to system locale
            locale: Locale(
              WidgetsBinding
                  .instance
                  .platformDispatcher
                  .locales
                  .first
                  .languageCode,
            ),
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(
                seedColor: Theme.of(context).colorScheme.error,
              ),
              useMaterial3: true,
            ),
            home: Builder(
              builder: (context) {
                return ErrorScreen(
                  message:
                      context.l10n.appError, // ✅ Traduction réussie depuis main
                  details: kDebugMode ? error.toString() : null,
                );
              },
            ),
          );
        },
      ),
    );
  }
}
