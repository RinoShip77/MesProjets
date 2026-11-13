import 'package:flutter/material.dart';
import 'package:macro_vision/config/l10n/app_localizations.dart';

/// Clé globale pour le Navigator. 
/// Utile pour naviguer ou accéder au contexte de plus haut niveau 
/// (comme le MaterialApp, nécessaire pour l10n sans BuildContext)
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

AppLocalizations get globalL10n {
  final context = navigatorKey.currentContext;
  if (context == null) {
    throw Exception("Essai d'accéder aux traductions avant que l'app ne soit prête.");
  }
  return AppLocalizations.of(context)!;
}