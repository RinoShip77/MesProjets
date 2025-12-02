import 'package:flutter/material.dart';

// 1. Définition des modes de thème possibles pour la sélection utilisateur
enum ThemeModeOption { system, light, dark, custom }

// 2. Définition de la structure d'un thème personnalisé
class CustomTheme {
  final String name;
  final MaterialColor color;
  
  const CustomTheme(this.name, this.color);
}

// Liste des thèmes personnalisés disponibles
const List<CustomTheme> customThemes = [
  CustomTheme("Classique Vert", Colors.green),
  CustomTheme("Océan Bleu", Colors.blue),
  CustomTheme("Passion Rouge", Colors.red),
  CustomTheme("Élégance Violette", Colors.purple),
];


// 3. Le Provider (gestionnaire d'état)
class ThemeProvider with ChangeNotifier {
  ThemeModeOption _themeModeOption = ThemeModeOption.system;
  CustomTheme _customTheme = customThemes.first;
  
  // Stocke le dernier mode de luminosité explicite choisi (Light, Dark, ou System)
  ThemeMode _baseThemeMode = ThemeMode.system; 

  ThemeModeOption get themeModeOption => _themeModeOption;
  CustomTheme get customTheme => _customTheme;

  // MODIFIÉ : Met à jour à la fois l'option utilisateur et le mode de luminosité de base
  void setThemeMode(ThemeModeOption newMode) {
    if (_themeModeOption != newMode) {
      _themeModeOption = newMode;
      
      // Met à jour le mode de base pour qu'il soit utilisé par le mode Custom
      if (newMode == ThemeModeOption.light) {
        _baseThemeMode = ThemeMode.light;
      } else if (newMode == ThemeModeOption.dark) {
        _baseThemeMode = ThemeMode.dark;
      } else if (newMode == ThemeModeOption.system) {
        _baseThemeMode = ThemeMode.system;
      }

      notifyListeners();
    }
  }
  
  // MODIFIÉ : Obtient le mode de thème réel pour l'application Flutter
  ThemeMode get themeMode {
    switch (_themeModeOption) {
      case ThemeModeOption.light:
        return ThemeMode.light;
      case ThemeModeOption.dark:
        return ThemeMode.dark;
      case ThemeModeOption.custom:
        // Si CUSTOM, utilise le dernier mode de luminosité défini. 
        // Si _baseThemeMode n'a jamais été défini (reste System), utilise Light par défaut.
        return _baseThemeMode != ThemeMode.system ? _baseThemeMode : ThemeMode.light; 
      case ThemeModeOption.system:
      default:
        return ThemeMode.system;
    }
  }
  
  // MODIFIÉ : Passage au mode personnalisé sans changer la luminosité de base
  void setCustomTheme(CustomTheme newTheme) {
    if (_customTheme != newTheme) {
      _customTheme = newTheme;
      // Met simplement l'option utilisateur à CUSTOM pour que le getter themeMode lise _baseThemeMode
      _themeModeOption = ThemeModeOption.custom;
      notifyListeners(); 
    }
  }
}