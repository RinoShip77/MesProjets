import 'package:flutter/material.dart';
import 'package:macro_vision/config/l10n/app_localizations.dart';
import 'package:macro_vision/utils/global_key.dart'; 

class LocalizationUtils {
  /// Accède aux traductions SANS BuildContext.
  /// Renvoie null si la traduction n'est pas encore initialisée (rarement)
  static AppLocalizations? get currentL10n {
    // 1. On récupère le BuildContext à partir de la GlobalKey du Navigator.
    final context = navigatorKey.currentContext;

    if (context == null) {
      // Gérer le cas où le contexte n'est pas encore disponible
      return null;
    }
    
    // 2. On utilise le BuildContext trouvé pour accéder aux localisations
    return AppLocalizations.of(context);
  }
}

extension AppLocalizationsExtension on BuildContext {
  /// Accède facilement à l'instance de AppLocalizations via `context.l10n`
  AppLocalizations get l10n => AppLocalizations.of(this);
}