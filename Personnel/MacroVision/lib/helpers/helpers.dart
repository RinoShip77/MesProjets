import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:macro_vision/screens/feedback_screen.dart';
import 'package:macro_vision/widgets/main_navigator.dart';
import 'package:markdown_widget/config/markdown_generator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:macro_vision/utils/l10n_extension.dart';

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
void navigate(BuildContext context, nextScreen, {bool replace = false}) {
  if (replace) {
    // 💡 pushReplacement : Retire la page actuelle de la pile (pour l'initialisation)
    Navigator.of(
      context,
    ).pushReplacement(MaterialPageRoute(builder: (context) => nextScreen));
  } else {
    // push : Laisse la page actuelle dans la pile (pour les navigations normales)
    Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (context) => nextScreen));
  }
}

// Call with showSnackBar($context, $messsage, $true/false, $duration);
void showSnackBar(
  BuildContext context,
  String message,
  isError, {
  int duration = 1500,
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
        ? Theme.of(context).colorScheme.error
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
// HomeScreen
// =======================================================================
// Fonction pour afficher la boîte de dialogue du guide utilisateur
Future<void> openDialog({
  required BuildContext context,
  required String title,
  required String content,
  String? warningContent,
  String? key,
  dynamic onDismiss,
}) async {
  // void openDialog(BuildContext context, String title, String text) {
  // Utilisation de la fonction builder pour gérer le contenu long.
  final children = MarkdownGenerator().buildWidgets(content);

  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        icon: title.toLowerCase().contains('guide')
            ? Icon(Icons.auto_stories_rounded, color: Colors.blue, size: 40)
            : Icon(Icons.warning_rounded, color: Colors.orange, size: 40),
        title: Center(
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 30.0, // Set your desired font size
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
        ),
        content: SizedBox(
          child: SingleChildScrollView(
            // REMPLACEMENT : Utilisation du widget Column pour contenir les widgets générés par MarkdownGenerator
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: children, // Les widgets générés par MarkdownWidget
            ),
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: title.toLowerCase().contains('guide')
                ? Text('Compris!')
                : Text('Continuer'),
            onPressed: () async {
              try {
                if (onDismiss != null) {
                  // Cas 1 : Dialogue Général ou Avertissement Légal (onDismiss est défini)
                  // On exécute l'action de fermeture (navigate)
                  if (context.mounted) {
                    onDismiss(); // Exécute la fonction de fermeture (qui navigue vers HomeScreen)
                    Navigator.of(context).pop(); // Ferme le dialogue
                  }
                } else {
                  if (key != null) {
                    // Nous sommes en phase d'initialisation. On sauvegarde et on enchaîne.
                    await saveHasSeenGuide(key);

                    if (context.mounted) {
                      Navigator.of(context).pop();

                      openDialog(
                        context: context,
                        title: 'Avertissement légal',
                        content: warningContent ?? '',
                        onDismiss: () => navigate(
                          context,
                          const MainNavigator(),
                          replace: true,
                        ),
                      );
                    }
                  } else {
                    // Nous sommes sur l'HomeScreen (Menu > Guide). On ferme simplement.
                    if (context.mounted) {
                      Navigator.of(context).pop();
                    }
                  }
                }
              } catch (e, stack) {
                // Gère l'erreur localement (si le contexte est encore valide)
                print("Erreur critique dans openDialog: $e");
                print(stack);
                if (context.mounted) {
                  // Optionnel : Afficher un message d'erreur moins fatal à l'utilisateur
                  showSnackBar(
                    context,
                    "Une erreur est survenue lors de la sauvegarde ou de la navigation.",
                    true,
                  );
                }
              }
            },
          ),
        ],
      );
    },
  );
}

Future<void> saveHasSeenGuide(String key) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setBool(key, true);
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

// =======================================================================
// FeedbackScreen
// =======================================================================
String? formatEmailSubject(BuildContext context, name) {
  String subject = 'Feedback MacroVision';

  if (name.isNotEmpty) {
    subject += ' de ${name.trim()}';
  }

  return subject;
}

String? formatEmailBody(BuildContext context, feedback) {
  // Déterminer la plateforme (utile pour le débogage)
  final String platform = (Theme.of(context).platform == TargetPlatform.iOS)
      ? 'iOS'
      : 'Android/Autre';

  return '''Plateforme: ${Theme.of(context).platform.name}\n--- Message de l'utilisateur ---\n\n$feedback''';
  // return '''Version : 1.0.0\nPlateforme: ${Theme.of(context).platform.name}\n--- Message de l'utilisateur ---\n\n$feedback''';
}

// =======================================================================
// DatabaseService
// =======================================================================
// Obtient le timestamp de début de journée pour une date donnée (minuit)
int getStartOfDayTimestamp(DateTime date) {
  final startOfDay = DateTime(date.year, date.month, date.day);
  return startOfDay.millisecondsSinceEpoch;
}

// Obtient le DateTime du début de la semaine (lundi à 00:00:00)
DateTime getStartOfCurrentWeek() {
  final now = DateTime.now();
  // 1 = Lundi, 7 = Dimanche
  int weekday = now.weekday;

  // Calcule le décalage pour revenir à Lundi.
  // Si aujourd'hui est Lundi (1), daysToSubtract sera 0.
  // Si aujourd'hui est Jeudi (4), daysToSubtract sera 3.
  final startOfWeek = now.subtract(Duration(days: weekday - 1));

  return DateTime(startOfWeek.year, startOfWeek.month, startOfWeek.day);
}

// Formate une date en nom de jour (Lun, Mar, etc.) pour les graphiques
String formatDateForSummary(DateTime dateTime) {
  // 'E' donne le nom abrégé du jour (Lun, Mar, ...)
  // Le paramètre locale: 'fr_CA' force l'utilisation des noms français.
  return (DateFormat('E', 'fr_CA').format(dateTime))
      .substring(0, (DateFormat('E', 'fr_CA').format(dateTime)).length - 1)
      .capitalize();
}

// Fonction utilitaire pour formater la date comme "dd-MM-yyyy"
String formatDate(DateTime dateTime) {
  // Utilise le format 'dd-MM-yyyy' et force la locale pour les formats de date numériques
  return DateFormat('dd-MM-yyyy', 'fr_CA').format(dateTime);
}

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1)}";
  }
}
