import 'package:flutter/material.dart';
import 'package:macro_vision/utils/global_key.dart';
import 'package:shared_preferences/shared_preferences.dart'; // Pour la persistance locale

// 1. Définition des modes de thème possibles pour la sélection utilisateur
enum ThemeModeOption { system, light, dark, custom }

// 2. Définition de la structure d'un thème personnalisé
class CustomTheme {
  final String name; // On utilise un ID technique au lieu du nom affiché
  final MaterialColor color;

  const CustomTheme(this.name, this.color);

  // 💡 NOUVEAU : Méthode pour obtenir le nom traduit SANS BuildContext
  // String get name {
  //   try {
  //     final l10n = globalL10n;
      
  //     return l10n.appCustomThemeOption(id);
  //     // // On mappe l'ID vers la clé ARB correspondante
  //     // return switch (id) {
  //     //   "mint" => l10n.themeColorMint,
  //     //   "ocean" => l10n.themeColorOcean,
  //     //   "passion" => l10n.themeColorPassion,
  //     //   "neon" => l10n.themeColorNeon,
  //     //   "platine" => l10n.themeColorPlatine,
  //     //   "merlot" => l10n.themeColorNeon,
  //     //   "citron" => l10n.themeColorNeon,
  //     //   "lime" => l10n.themeColorNeon,
  //     //   "paon" => l10n.themeColorNeon,
  //     //   "azur" => l10n.themeColorNeon,
  //     //   "bonbon" => l10n.themeColorNeon,
  //     //   "citrouille" => l10n.themeColorNeon,
  //     //   "lapis" => l10n.themeColorNeon,
  //     //   "ecarlate" => l10n.themeColorNeon,
  //     //   _ => id, // Fallback sur l'ID si pas de traduction
  //     // };
  //   } catch (e) {
  //     return id; // Si globalL10n n'est pas prêt, on affiche l'ID
  //   }
  // }
}

// Liste des thèmes personnalisés disponibles
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

// 3. Le Provider (gestionnaire d'état)
class ThemeProvider with ChangeNotifier {
  static const String themeModeKey = 'themeMode'; // Rendre public
  ThemeModeOption _themeModeOption = ThemeModeOption.system;
  CustomTheme _customTheme = customThemes.first;

  // Stocke le dernier mode de luminosité explicite choisi (Light, Dark, ou System)
  ThemeMode _baseThemeMode = ThemeMode.system;

  ThemeModeOption get themeModeOption => _themeModeOption;
  CustomTheme get customTheme => _customTheme;

  // Constructeur : Lance le chargement des préférences
  ThemeProvider() {
    loadPreferences();
  }

  // --- PERSISTANCE LOCALE ---

  Future<void> loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();

    // 1. Charger le mode de luminosité (Système, Clair, Sombre, Custom)
    final savedModeIndex = prefs.getInt(PrefKeys.themeModeOption);
    if (savedModeIndex != null &&
        savedModeIndex < ThemeModeOption.values.length) {
      _themeModeOption = ThemeModeOption.values[savedModeIndex];
      // Pour s'assurer que _baseThemeMode est initialisé si le mode n'est pas custom
      if (_themeModeOption == ThemeModeOption.light) {
        _baseThemeMode = ThemeMode.light;
      } else if (_themeModeOption == ThemeModeOption.dark) {
        _baseThemeMode = ThemeMode.dark;
      }
    }

    // 2. Charger le thème personnalisé (l'index dans la liste customThemes)
    final savedThemeIndex = prefs.getInt(PrefKeys.customThemeIndex);
    if (savedThemeIndex != null && savedThemeIndex < customThemes.length) {
      _customTheme = customThemes[savedThemeIndex];
    }

    notifyListeners();
  }

  Future<void> _saveCustomThemeIndex() async {
    final prefs = await SharedPreferences.getInstance();
    final index = customThemes.indexOf(_customTheme);
    await prefs.setInt(PrefKeys.customThemeIndex, index);
  }

  Future<void> _saveThemeModeIndex() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(PrefKeys.themeModeOption, _themeModeOption.index);
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
        // Si _baseThemeMode n'a jamais été défini (reste System), utilise System par défaut.
        return _baseThemeMode != ThemeMode.system
            ? _baseThemeMode
            : ThemeMode.system;
      case ThemeModeOption.system:
      default:
        return ThemeMode.system;
    }
  }

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

      _saveThemeModeIndex(); // Sauvegarde l'option de mode de thème

      notifyListeners();
    }
  }

  // MODIFIÉ : Passage au mode personnalisé sans changer la luminosité de base
  void setCustomTheme(CustomTheme newTheme) {
    if (_customTheme != newTheme) {
      _customTheme = newTheme;
      // Met simplement l'option utilisateur à CUSTOM pour que le getter themeMode lise _baseThemeMode
      _themeModeOption = ThemeModeOption.custom;
      _saveCustomThemeIndex(); // Sauvegarde l'index du thème personnalisé
      _saveThemeModeIndex(); // Sauvegarde l'option de mode de thème

      notifyListeners();
    }
  }
}
