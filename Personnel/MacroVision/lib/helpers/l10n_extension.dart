import 'package:flutter/material.dart';
import 'package:macro_vision/config/l10n/app_localizations.dart'; 

extension AppLocalizationsExtension on BuildContext {
  /// Accède facilement à l'instance de AppLocalizations via `context.l10n`
  AppLocalizations get l10n => AppLocalizations.of(this);
}