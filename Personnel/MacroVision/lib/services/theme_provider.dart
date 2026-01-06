import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum ThemeModeOption { system, light, dark, custom }

class CustomTheme {
  final String name;
  final MaterialColor color;
  const CustomTheme(this.name, this.color);
}

// Configuration Constants
const List<CustomTheme> customThemes = [
  CustomTheme("mint", Colors.green),
  CustomTheme("ocean", Colors.blue),
  CustomTheme("passion", Colors.red),
  CustomTheme("neon", Colors.purple),
  CustomTheme("platinum", Colors.grey),
  CustomTheme("merlot", Colors.brown),
  CustomTheme("lemon", Colors.yellow),
  CustomTheme("lime", Colors.lime),
  CustomTheme("peacock", Colors.cyan),
  CustomTheme("azure", Colors.teal),
  CustomTheme("candy", Colors.pink),
  CustomTheme("pumpkin", Colors.orange),
  CustomTheme("lapis", Colors.indigo),
  CustomTheme("scarlet", Colors.deepOrange),
];

class PrefKeys {
  static const String themeModeOption = 'themeModeOption';
  static const String customThemeIndex = 'customThemeIndex';
}

class ThemeProvider with ChangeNotifier {
  // State
  ThemeModeOption _themeModeOption = ThemeModeOption.system;
  CustomTheme _customTheme = customThemes.first;
  ThemeMode _baseThemeMode = ThemeMode.system;

  // Getters
  ThemeModeOption get themeModeOption => _themeModeOption;
  CustomTheme get customTheme => _customTheme;

  ThemeProvider() {
    loadPreferences();
  }

  // --- Logic ---

  /// Determines the actual Flutter ThemeMode based on the selected option
  ThemeMode get themeMode {
    return switch (_themeModeOption) {
      ThemeModeOption.light => ThemeMode.light,
      ThemeModeOption.dark => ThemeMode.dark,
      ThemeModeOption.custom =>
        _baseThemeMode != ThemeMode.system ? _baseThemeMode : ThemeMode.system,
      _ => ThemeMode.system,
    };
  }

  Future<void> loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();

    // Load Mode
    final savedModeIndex = prefs.getInt(PrefKeys.themeModeOption);
    if (savedModeIndex != null &&
        savedModeIndex < ThemeModeOption.values.length) {
      _themeModeOption = ThemeModeOption.values[savedModeIndex];
      _updateBaseThemeMode(_themeModeOption);
    }

    // Load Custom Theme Color
    final savedThemeIndex = prefs.getInt(PrefKeys.customThemeIndex);
    if (savedThemeIndex != null && savedThemeIndex < customThemes.length) {
      _customTheme = customThemes[savedThemeIndex];
    }

    notifyListeners();
  }

  void setThemeMode(ThemeModeOption newMode) {
    if (_themeModeOption == newMode) return;

    _themeModeOption = newMode;
    _updateBaseThemeMode(newMode);
    
    // Save only the mode
    _saveToPrefs(key: PrefKeys.themeModeOption, value: _themeModeOption.index);
    notifyListeners();
  }

  void setCustomTheme(CustomTheme newTheme) {
    if (_customTheme == newTheme) return;

    _customTheme = newTheme;
    
    // Automatically switch to custom mode if we pick a color
    if (_themeModeOption != ThemeModeOption.custom) {
      _themeModeOption = ThemeModeOption.custom;
      _saveToPrefs(key: PrefKeys.themeModeOption, value: _themeModeOption.index);
    }

    _saveToPrefs(key: PrefKeys.customThemeIndex, value: customThemes.indexOf(_customTheme));
    notifyListeners();
  }

  // --- Helpers ---

  void _updateBaseThemeMode(ThemeModeOption mode) {
    if (mode == ThemeModeOption.light) {
      _baseThemeMode = ThemeMode.light;
    } else if (mode == ThemeModeOption.dark) {
      _baseThemeMode = ThemeMode.dark;
    } else if (mode == ThemeModeOption.system) {
      _baseThemeMode = ThemeMode.system;
    }
    // If Custom, we keep the previous base mode
  }

  Future<void> _saveToPrefs({required String key, required int value}) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(key, value);
  }
}
