import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:macro_vision/screens/feedback_screen.dart';
import 'package:macro_vision/screens/settings_screen.dart';
import 'package:macro_vision/screens/user_profile_screen.dart';
import 'package:macro_vision/services/theme_provider.dart';
import 'package:provider/provider.dart';

/// Helper functions and utilities for the MacroVision application.
///
/// This module provides a collection of helper functions and utilities
/// that can be reused across the MacroVision application.
///
/// Usage:
/// ```
/// ``` import 'package:macro_vision/helpers/helpers.dart';
/// ```

// =======================================================================
// Genral functions
// =======================================================================
// Call with navigate(context, const $nextScreen()),
void navigate(BuildContext context, nextScreen) {
  Navigator.of(
    context,
  ).push(MaterialPageRoute(builder: (context) => nextScreen));
}

// Call with showSnackBar(context, $messsage, true/false);
void showSnackBar(
  BuildContext context,
  String message,
  isError, {
  int duration = 500,
}) {
  final snackbar = SnackBar(
    content: Text(
      message,
      textAlign: TextAlign.center,
      style: TextStyle(
        color: isError ? Colors.white : Theme.of(context).colorScheme.onPrimary,
      ),
    ),
    backgroundColor: isError
        ? Colors.red
        : Theme.of(context).colorScheme.primary,
    behavior: SnackBarBehavior.floating,
    duration: Duration(milliseconds: duration),
    margin: EdgeInsets.all(20),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
  );

  ScaffoldMessenger.of(context).showSnackBar(
    snackbar,
    snackBarAnimationStyle: AnimationStyle(
      duration: const Duration(
        milliseconds: 1000,
      ), // Override show animation duration
      reverseDuration: const Duration(
        milliseconds: 1500,
      ), // Override hide animation duration
    ),
  );
}

// Call with universalScaffold($title, $body)
Widget universalScaffold({
  required BuildContext context,
  String title = 'MacroVision',
  List<Widget>? appBarActions,
  required Widget
  body, // This parameter is not used in the current implementation
  List<dynamic>? listData,
}) {
  return Scaffold(
    extendBodyBehindAppBar: true,
    appBar: glassAppBar(
      context: context,
      title: title,
      appBarActions: appBarActions,
    ), // Cannot use GlassAppBar easily here
    body: Stack(
      alignment: Alignment.topRight,
      children: [
        CustomScrollView(
          slivers: <Widget>[
            // --- The Bridge Widget: SliverToBoxAdapter ---
            // This allows standard box widgets to live in a CustomScrollView
            SliverToBoxAdapter(
              // Now you can put a SingleChildScrollView inside here
              child: SingleChildScrollView(
                // NOTE: This nested SingleChildScrollView must have its own
                // physics disabled to prevent nested/conflicting scrolling behavior.
                physics: NeverScrollableScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 20,
                    right: 20,
                    top: kToolbarHeight + 55,
                    bottom: 20,
                  ),
                  child: body,
                ),
              ),
            ),

            // You can still have a different SliverList below this section
            // SliverList(
            //   delegate: SliverChildBuilderDelegate((
            //     BuildContext context,
            //     int index,
            //   ) {
            //     return ListTile(
            //       title: Text('List Item $index (below the single child view)'),
            //     );
            //   }, childCount: 10),
            // ),
          ],
        ),

        // body,
        Padding(
          padding: EdgeInsets.only(top: kToolbarHeight + 60, right: 5),
          child: feedbackButton(context),
        ),
      ],
    ),
  );
}

// Call with glassAppBar($title)),
PreferredSizeWidget glassAppBar({
  required BuildContext context,
  required String title,
  List<Widget>? appBarActions,
}) {
  return PreferredSize(
    preferredSize: Size.fromHeight(kToolbarHeight),
    child: ClipRRect(
      borderRadius: BorderRadiusGeometry.circular(15),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        child: AppBar(
          title: Text(title),
          actions: appBarActions,
          backgroundColor: Theme.of(context).colorScheme.primary.withAlpha(75),
          iconTheme: Theme.of(context).iconTheme,
          shadowColor: Theme.of(context).colorScheme.primary.withAlpha(25),
          toolbarHeight: kToolbarHeight + 20,
          titleTextStyle: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
      ),
    ),
  );
}

// Call with feedbackButton($context),
Widget feedbackButton(BuildContext context) {
  return Positioned(
    top: 10,
    right: 10,
    child: FloatingActionButton(
      heroTag: 'feedbackBtn',
      tooltip: 'Retour utilisateur.',
      onPressed: () => navigate(context, const FeedbackScreen()),
      child: const Icon(Icons.feedback_rounded),
    ),
  );
}

// =======================================================================
// SettingsScreen
// =======================================================================
Widget buildThemeOption({
  required String title,
  required target,
  required current,
  required onChanged,
}) {
  return Tooltip(
    message: title,
    child: RadioListTile<dynamic>(
      title: Text(title),
      value: target,
      groupValue: current,
      onChanged: (value) {
        if (value != null) {
          onChanged(value);
        }
      },
    ),
  );
}

// =======================================================================
// UserProfileScreen
// =======================================================================
Widget buildTextField({
  required TextEditingController controller,
  required String label,
  required TextInputType keyboardType,
  List<TextInputFormatter>? formatters, // NOUVEAU: Paramètre optionnel
  String? Function(String?)? validator,
}) {
  return Tooltip(
    message: label,
    child: Padding(
      padding: const EdgeInsets.only(bottom: 15.0),
      child: TextFormField(
        controller: controller,
        // Utilisation du paramètre formatters
        inputFormatters: formatters,
        keyboardType: keyboardType,
        decoration: InputDecoration(labelText: label),
        validator:
            validator ??
            (value) {
              if (value == null || value.isEmpty) {
                return 'Ce champ est requis.';
              }
              return null;
            },
      ),
    ),
  );
}

// =======================================================================
// ResultScreen
// =======================================================================
// Fonction pour formater les nombres au format français (point -> virgule)
String formatNumber(double value, {int fractionDigits = 1}) {
  // Formate la valeur avec la précision souhaitée (ex: "12.3")
  String formatted = value.toStringAsFixed(fractionDigits);

  // Remplace le point décimal par une virgule
  return formatted.replaceAll('.', ',');
}

// Widget utilitaire pour afficher une ligne principale
Widget buildFactRow(
  BuildContext context,
  String label,
  double value,
  String unit,
) {
  // Utilise 0 chiffre après la virgule pour les mg (Cholestérol, Sodium, Potassium)
  final int fractionDigits = unit == 'mg' ? 0 : 1;

  return Tooltip(
    message: label,
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
          ),
          Text(
            '${formatNumber(value, fractionDigits: fractionDigits)} $unit',
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    ),
  );
}

// Widget utilitaire pour afficher une sous-ligne
Widget buildSubFactRow(
  BuildContext context,
  String label,
  double value,
  String unit,
) {
  final int fractionDigits = unit == 'mg' ? 0 : 1;

  return Tooltip(
    message: label,
    child: Padding(
      padding: const EdgeInsets.only(left: 16.0, top: 4.0, bottom: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: Theme.of(context).textTheme.labelLarge),
          Text(
            '${formatNumber(value, fractionDigits: fractionDigits)} $unit',
            style: Theme.of(context).textTheme.labelLarge,
          ),
        ],
      ),
    ),
  );
}

// Bouton pour sauvegarder et revenir (Prompt 2.1)
void saveAndReturn(BuildContext context, facts) {
  // Renvoie les faits ajustés (ou non ajustés) à l'écran précédent.
  Navigator.of(context).pop(facts);
}
