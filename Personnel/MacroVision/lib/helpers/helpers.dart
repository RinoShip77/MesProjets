import 'dart:ui';
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // For rootBundle if needed
import 'package:macro_vision/main.dart';
import 'package:macro_vision/models/user_profile.dart';
import 'package:macro_vision/utils/global_key.dart';
import 'package:macro_vision/screens/feedback_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:markdown_widget/config/markdown_generator.dart';
import 'package:macro_vision/models/nutritional_facts_entry.dart';

/// Helper functions and utilities for the MacroVision application.
///
/// This module provides a collection of helper functions and utilities
/// that can be reused across the MacroVision application.
///
/// Usage:
/// ```
/// ``` import 'package:macro_vision/helpers/helpers.dart';
/// ```

/// =======================================================================
/// 1. PREFERENCES & STORAGE HELPERS
/// =======================================================================
/// These functions simplify interactions with SharedPreferences.
/// Usage: await saveToPrefs('my_key', 10);

/// Loads a localized markdown file (e.g., 'user_guide_en.md').
/// Falls back to 'fr' if the target language file is missing.
Future<String> loadLocalizedAsset(BuildContext context, String baseName) async {
  final lang = Localizations.localeOf(context).languageCode;

  // 1. Try Target Language
  try {
    return await DefaultAssetBundle.of(
      context,
    ).loadString('assets/${baseName}_$lang.md');
  } catch (e) {
    debugPrint('Asset not found for $lang, falling back to default.');
  }

  // 2. Fallback to Default
  // Used if the user is in 'es' or 'de' and not in the supported languages.
  try {
    return await DefaultAssetBundle.of(
      context,
    ).loadString('assets/${baseName}_fr.md');
  } catch (e) {
    return 'Error: Content not found.';
  }
}

/// Saves an integer value to local storage.
Future<void> saveToPrefs(String key, value) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setInt(key, value);
}

/// =======================================================================
/// 2. JSON & DATA PARSING
/// =======================================================================

/// Cleans a string containing Markdown JSON (e.g., ```json ... ```) and parses it.
/// Returns `null` if the string is empty or parsing fails.
/// This is crucial for handling responses from Generative AI models which often
/// wrap JSON in Markdown code blocks.
Map<String, dynamic>? cleanAndParseJson(String? rawText) {
  if (rawText == null || rawText.isEmpty) return null;

  try {
    // 1. Remove Markdown code block syntax
    String clean = rawText.replaceAll(RegExp(r'^```json|```$'), '').trim();

    // 2. Fallback cleanup
    clean = clean.replaceAll('```json', '').replaceAll('```', '').trim();

    // 3. Safety: Normalize critical values (e.g. portion size) to prevent division by zero in UI
    final Map<String, dynamic> data = jsonDecode(clean);

    // Safety: Normalize portion size if missing or zero
    if (data.containsKey('portionInGrams') &&
        (data['portionInGrams'] as num?) == 0) {
      data['portionInGrams'] = 100.0;
    }

    return data;
  } catch (e) {
    debugPrint('🔴 JSON Parsing Helper Error: $e');
    return null;
  }
}

/// =======================================================================
/// 3. DATE & TIME UTILITIES
/// =======================================================================

/// Returns the timestamp (ms) for the start (00:00:00) of the given date.
/// Used for database queries to filter by day.
int getStartOfDayTimestamp(DateTime date) {
  final startOfDay = DateTime(date.year, date.month, date.day);
  return startOfDay.millisecondsSinceEpoch;
}

/// Returns a DateTime representing the Monday of the current week at 00:00:00.
/// Used for weekly summary calculations.
DateTime getStartOfCurrentWeek() {
  final now = DateTime.now();
  // Calculate offset to get back to Monday (Weekday 1)
  final startOfWeek = now.subtract(Duration(days: now.weekday - 1));
  return DateTime(startOfWeek.year, startOfWeek.month, startOfWeek.day);
}

/// Formats a date into a short day name for charts.
String formatDateForSummary(DateTime dateTime) {
  // Use 'E' pattern (gives "Mon", "Tue", etc.) and forces language specific
  return (DateFormat(
    'E',
    AppSetup.of(navigatorKey.currentContext!).getLocale.toLanguageTag(),
  ).format(dateTime)).replaceAll('.', '').capitalize();
}

/// Utility function to format date as "dd-MM-yyyy"
String formatDate(DateTime dateTime) {
  // Uses 'dd-MM-yyyy' format and forces language specific for numeric date formats
  return DateFormat('yyyy-MM-dd').format(dateTime);
}

/// =======================================================================
/// 4. MOCK DATA (Development & Testing)
/// =======================================================================

/// Standardized mock response for Gemini Service testing.
const Map<String, dynamic> mockGeminiResponse = {
  'foodName': 'Barre Granola',
  'portionInGrams': 42.0,
  'calories': 190.0,
  'totalFat': 6.0,
  'saturatedFat': 1.0,
  'transFat': 0.0,
  'cholesterol': 0.0,
  'sodium': 140.0,
  'potassium': 95.0,
  'totalCarbohydrates': 29.0,
  'dietaryFiber': 2.0,
  'sugar': 11.0,
  'protein': 3.0,
};

List<NutritionalFactsEntry> getMockDatabaseEntries() {
  final now = DateTime.now();
  final today = getStartOfDayTimestamp(now);
  final yesterday = getStartOfDayTimestamp(
    now.subtract(const Duration(days: 1)),
  );

  return [
    NutritionalFactsEntry(
      timestamp: today + 32400000,
      imagePath: 'assets/dummy_breakfast.png',
      foodName: 'Omelette Breakfast',
      portionInGrams: 250,
      calories: 450,
      totalFat: 25,
      saturatedFat: 8,
      transFat: 0,
      cholesterol: 300,
      sodium: 300,
      potassium: 100,
      totalCarbohydrates: 5,
      dietaryFiber: 1,
      sugar: 3,
      protein: 40,
    ),
    NutritionalFactsEntry(
      timestamp: today + 46800000,
      imagePath: 'assets/dummy_lunch.png',
      foodName: 'Chicken Salad',
      portionInGrams: 400,
      calories: 600,
      totalFat: 30,
      saturatedFat: 5,
      transFat: 0,
      cholesterol: 120,
      sodium: 450,
      potassium: 500,
      totalCarbohydrates: 20,
      dietaryFiber: 5,
      sugar: 8,
      protein: 50,
    ),
    NutritionalFactsEntry(
      timestamp: yesterday + 28800000,
      imagePath: 'assets/dummy_bf_2.png',
      foodName: 'Yogurt & Granola',
      portionInGrams: 300,
      calories: 320,
      totalFat: 5,
      saturatedFat: 3,
      transFat: 0,
      cholesterol: 10,
      sodium: 150,
      potassium: 200,
      totalCarbohydrates: 35,
      dietaryFiber: 0,
      sugar: 30,
      protein: 30,
    ),
    NutritionalFactsEntry(
      timestamp: yesterday + 45000000,
      imagePath: 'assets/dummy_lunch_2.png',
      foodName: 'Pasta Bolognese',
      portionInGrams: 550,
      calories: 850,
      totalFat: 35,
      saturatedFat: 12,
      transFat: 0,
      cholesterol: 150,
      sodium: 800,
      potassium: 550,
      totalCarbohydrates: 90,
      dietaryFiber: 10,
      sugar: 5,
      protein: 30,
    ),
  ];
}

/// =======================================================================
/// 5. EXTENSIONS
/// =======================================================================

extension StringExtension on String {
  /// Capitalizes the first letter of the string.
  String capitalize() => '${this[0].toUpperCase()}${substring(1)}';
}

// =======================================================================
// General functions
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
  SnackBarAction? action,
}) {
  final snackbar = SnackBar(
    content: Text(
      message,
      textAlign: TextAlign.center,
      style: TextStyle(
        color: isError
            ? Colors.black
            : Theme.of(context).colorScheme.onPrimaryContainer,
      ),
    ),
    backgroundColor: isError
        ? Theme.of(context).colorScheme.error
        : Theme.of(context).colorScheme.primaryContainer,
    behavior: SnackBarBehavior.floating,
    // duration: Duration(milliseconds: duration),
    margin: const EdgeInsets.all(20),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
    action: action,
  );

  ScaffoldMessenger.of(context).showSnackBar(
    snackbar,
    snackBarAnimationStyle: const AnimationStyle(
      duration: Duration(
        milliseconds: 1000,
      ), // Override show animation duration
      reverseDuration: Duration(
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
          backgroundColor: Theme.of(context).colorScheme.primaryContainer,
          iconTheme: Theme.of(context).iconTheme,
          shadowColor: Theme.of(context).colorScheme.primaryContainer,
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
// HomeScreen & Initialization Helpers
// =======================================================================

/// Displays a Markdown-based dialog and waits for it to be dismissed.
Future<void> openDialog({
  required BuildContext context,
  required String title,
  required String content,
  String? buttonText, // NEW: Custom button label
}) async {
  // 1. Parse Markdown
  final children = MarkdownGenerator().buildWidgets(content);

  // 2. Determine Icon based on title (Visual helper)
  final icon = title.toLowerCase().contains('guide')
      ? const Icon(Icons.auto_stories_rounded, color: Colors.blue, size: 40)
      : const Icon(Icons.warning_rounded, color: Colors.orange, size: 40);

  // 3. Determine Button Text if not provided
  final actionLabel =
      buttonText ??
      (title.toLowerCase().contains('guide') ? 'Compris!' : 'Continuer');

  // 4. Show and AWAIT the dialog
  return showDialog(
    context: context,
    barrierDismissible: false, // Force user to click the button
    builder: (BuildContext context) {
      return AlertDialog(
        icon: icon,
        title: Center(
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 24.0, // Reduced slightly for better fit
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
        ),
        content: SizedBox(
          width: double.maxFinite,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: children,
            ),
          ),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              // SIMPLE: Just close the dialog.
              // The 'await openDialog(...)' in the calling screen will then complete.
              Navigator.of(context).pop();
            },
            child: Text(
              actionLabel,
              style: TextStyle(
                color: Theme.of(context).colorScheme.onPrimaryContainer,
              ),
            ),
          ),
        ],
      );
    },
  );
}
// Future<void> openDialog({
//   required BuildContext context,
//   required String title,
//   required String content,
//   String? warningContent,
//   String? key,
//   dynamic onDismiss,
// }) async {
//   // void openDialog(BuildContext context, String title, String text) {
//   // Utilisation de la fonction builder pour gérer le contenu long.
//   final children = MarkdownGenerator().buildWidgets(content);

//   return showDialog(
//     context: context,
//     builder: (BuildContext context) {
//       return AlertDialog(
//         icon: title.toLowerCase().contains('guide')
//             ? Icon(Icons.auto_stories_rounded, color: Colors.blue, size: 40)
//             : Icon(Icons.warning_rounded, color: Colors.orange, size: 40),
//         title: Center(
//           child: Text(
//             title,
//             textAlign: TextAlign.center,
//             style: TextStyle(
//               fontSize: 30.0, // Set your desired font size
//               fontWeight: FontWeight.bold,
//               color: Theme.of(context).colorScheme.onSurface,
//             ),
//           ),
//         ),
//         content: SizedBox(
//           child: SingleChildScrollView(
//             // REMPLACEMENT : Utilisation du widget Column pour contenir les widgets générés par MarkdownGenerator
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: children, // Les widgets générés par MarkdownWidget
//             ),
//           ),
//         ),
//         actions: <Widget>[
//           TextButton(
//             child: title.toLowerCase().contains('guide')
//                 ? Text('Compris!')
//                 : Text('Continuer'),
//             onPressed: () async {
//               try {
//                 if (onDismiss != null) {
//                   // Cas 1 : Dialogue Général ou Avertissement Légal (onDismiss est défini)
//                   // On exécute l'action de fermeture (navigate)
//                   if (context.mounted) {
//                     onDismiss(); // Exécute la fonction de fermeture (qui navigue vers HomeScreen)
//                     Navigator.of(context).pop(); // Ferme le dialogue
//                   }
//                 } else {
//                   if (key != null) {
//                     // Nous sommes en phase d'initialisation. On sauvegarde et on enchaîne.
//                     // await saveHasSeenGuide(key);
//                     await saveToPrefs(key, true);

//                     if (context.mounted) {
//                       Navigator.of(context).pop();

//                       openDialog(
//                         context: context,
//                         title: 'Avertissement légal',
//                         content: warningContent ?? '',
//                         onDismiss: () => navigate(
//                           context,
//                           const MainNavigator(),
//                           replace: true,
//                         ),
//                       );
//                     }
//                   } else {
//                     // Nous sommes sur l'HomeScreen (Menu > Guide). On ferme simplement.
//                     if (context.mounted) {
//                       Navigator.of(context).pop();
//                     }
//                   }
//                 }
//               } catch (e, stack) {
//                 // Gère l'erreur localement (si le contexte est encore valide)
//                 print("Erreur critique dans openDialog: $e");
//                 print(stack);
//                 if (context.mounted) {
//                   // Optionnel : Afficher un message d'erreur moins fatal à l'utilisateur
//                   showSnackBar(
//                     context,
//                     "Une erreur est survenue lors de la sauvegarde ou de la navigation.",
//                     true,
//                   );
//                 }
//               }
//             },
//           ),
//         ],
//       );
//     },
//   );
// }

// Future<void> saveHasSeenGuide(String key) async {
//   final prefs = await SharedPreferences.getInstance();
//   await prefs.setBool(key, true);
// }

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
Widget buildFormTextField({
  required TextEditingController controller,
  required String label,
  required TextInputType keyboardType,
  List<TextInputFormatter>? formatters,
  String? Function(String?)? validator,
}) {
  return Tooltip(
    message: label,
    child: Padding(
      padding: const EdgeInsets.only(bottom: 15.0),
      child: TextFormField(
        controller: controller,
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

Widget buildFormTextFieldWDropdown({
  required String label,
  required TextEditingController controller,
  required BuildContext context,
  required String dropdownInitialValue,
  required List<String> dropdownOptions,
  required Function(String?) onDropdownChanged,
  String? validationText,
}) {
  return Tooltip(
    message: label,
    child: Padding(
      padding: const EdgeInsets.only(bottom: 15.0),
      child: Row(
        children: [
          Expanded(
            child: Tooltip(
              message: label,
              child: TextFormField(
                controller: controller,
                decoration: InputDecoration(
                  labelText: label,
                  suffixIcon: buildUnitDropdown(
                    dropdownInitialValue,
                    context,
                    dropdownOptions,
                    onDropdownChanged,
                  ),
                ),
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                validator: (val) =>
                    val == null ||
                        double.tryParse(val.replaceAll(',', '.')) == null
                    ? validationText
                    : null,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'[\d.,]')),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

Widget buildUnitDropdown(
  String value,
  BuildContext context,
  List<String> items,
  Function(String?) onChanged,
) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 8),
    child: DropdownButton<String>(
      value: value,
      icon: const Icon(Icons.arrow_drop_down, color: Colors.grey),
      underline: Container(), // Remove default underline
      style: TextStyle(
        color: Theme.of(context).colorScheme.primary,
        fontWeight: FontWeight.bold,
      ),
      onChanged: onChanged,
      items: items.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(value: value, child: Text(value));
      }).toList(),
    ),
  );
}

Widget buildFormDropdown({
  required String label,
  dynamic initialValue,
  dynamic options,
  required Function(dynamic) onChanged,
}) {
  return Tooltip(
    message: label,
    child: Padding(
      padding: const EdgeInsets.only(bottom: 15.0),
      child: DropdownButtonFormField<dynamic>(
        decoration: InputDecoration(labelText: label),
        initialValue: initialValue,
        items: options,
        onChanged: onChanged,
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

  return '$subject (${Theme.of(context).platform.name})';
}

String? formatEmailBody(BuildContext context, feedback) {
  return '''Plateforme: ${Theme.of(context).platform.name}\n$feedback''';
  // return '''Version : 1.0.0\nPlateforme: ${Theme.of(context).platform.name}\n--- Message de l'utilisateur ---\n\n$feedback''';
}
