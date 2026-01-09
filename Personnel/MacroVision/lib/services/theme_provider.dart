import 'package:flutter/material.dart';
import 'package:macro_vision/helpers/helpers.dart'; //
import 'package:shared_preferences/shared_preferences.dart';

// ==============================================================================
// CONFIGURATION & MODELS
// ==============================================================================

/// Defines the brightness modes supported by the application.
enum ThemeModeOption { system, light, dark }

/// Represents a user-selectable accent color theme.
class CustomTheme {
  final String name; // The unique name of the theme
  final MaterialColor color; // The actual color palette

  const CustomTheme(this.name, this.color);
}

/// List of all available custom colors.
const List<CustomTheme> customThemes = [
  CustomTheme('amber', Colors.orange),
  CustomTheme('amethyst', Colors.purple),
  CustomTheme('beryl', Colors.teal),
  CustomTheme('bubblegum', Colors.pink),
  CustomTheme('crimson', Colors.red),
  CustomTheme('emerald', Colors.green),
  CustomTheme('espresso', Colors.brown),
  CustomTheme('fern', Colors.lightGreen),
  CustomTheme('graphite', Colors.blueGrey),
  CustomTheme('honey', Colors.amber),
  CustomTheme('orchid', Colors.deepPurple),
  CustomTheme('sapphire', Colors.blue),
  CustomTheme('sky', Colors.lightBlue),
  CustomTheme('slate', Colors.grey),
  CustomTheme('solar', Colors.yellow),
  CustomTheme('turquoise', Colors.cyan),
  CustomTheme('ultramarine', Colors.indigo),
  CustomTheme('vermilion', Colors.deepOrange),
  CustomTheme('volt', Colors.lime),
];

/// Keys used for SharedPreferences persistence.
class _PrefKeys {
  static const String themeMode = 'theme_mode_index';
  static const String customThemeIndex = 'custom_theme_index';
}

// ==============================================================================
// THEME PROVIDER
// ==============================================================================

/// Manages the application's theme state and persistence.
class ThemeProvider with ChangeNotifier {
  // --- State Variables ---
  ThemeModeOption _themeModeOption = ThemeModeOption.system;
  CustomTheme _customTheme = customThemes.first;

  // --- Getters ---
  ThemeModeOption get themeModeOption => _themeModeOption;
  CustomTheme get customTheme => _customTheme;

  /// Converts the internal [ThemeModeOption] to Flutter's native [ThemeMode].
  ThemeMode get themeMode {
    return switch (_themeModeOption) {
      ThemeModeOption.light => ThemeMode.light,
      ThemeModeOption.dark => ThemeMode.dark,
      ThemeModeOption.system => ThemeMode.system,
    };
  }

  // --- Constructor ---
  ThemeProvider() {
    _loadPreferences();
  }

  // --- Actions ---

  /// Updates the brightness mode (System, Light, Dark).
  /// This does NOT affect the selected custom color.
  void setThemeMode(ThemeModeOption newMode) {
    if (_themeModeOption == newMode) return;

    _themeModeOption = newMode;
    // Persist immediately using helper
    saveToPrefs(_PrefKeys.themeMode, newMode.index);
    notifyListeners();
  }

  /// Updates the accent color theme.
  /// This does NOT affect the selected brightness mode.
  void setCustomTheme(CustomTheme newTheme) {
    if (_customTheme == newTheme) return;

    _customTheme = newTheme;
    // Persist immediately using helper
    saveToPrefs(_PrefKeys.customThemeIndex, customThemes.indexOf(newTheme)); //
    notifyListeners();
  }

  // --- Internal Logic ---

  /// Loads saved preferences on startup.
  Future<void> _loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();

    // 1. Load Brightness Mode
    final modeIndex = prefs.getInt(_PrefKeys.themeMode);
    if (modeIndex != null && modeIndex < ThemeModeOption.values.length) {
      _themeModeOption = ThemeModeOption.values[modeIndex];
    }

    // 2. Load Accent Color
    final themeIndex = prefs.getInt(_PrefKeys.customThemeIndex);
    if (themeIndex != null && themeIndex < customThemes.length) {
      _customTheme = customThemes[themeIndex];
    }

    notifyListeners();
  }
}
