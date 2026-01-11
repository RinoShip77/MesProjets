import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:path/path.dart';

// =========================================================================
// CONSTANTES DE COULEURS ACCESSIBLES GLOBALEMENT
// =========================================================================

// Couleur primaire par défaut si le mode 'Custom' n'est pas sélectionné
const MaterialColor appPrimaryColor = Colors.purple;

// =========================================================================
// FONCTION DE BASE POUR CRÉER LES THÈMES
// =========================================================================

ThemeData _buildThemeData({
  required Brightness brightness,
  required MaterialColor seedColor, // Accepte la MaterialColor custom
}) {
  // 1. Générer un ColorScheme cohérent à partir de la couleur passée
  final ColorScheme colorScheme = ColorScheme.fromSeed(
    seedColor: seedColor,
    brightness: brightness,
  );

  return ThemeData(
    useMaterial3: true,
    brightness: brightness,
    colorScheme: colorScheme,
    // Couleur de fond par défaut (Scaffold)
    scaffoldBackgroundColor: brightness == Brightness.light
        ? Colors.white
        : colorScheme.surface,
    textTheme: GoogleFonts.ubuntuTextTheme()
        .apply(bodyColor: colorScheme.onSurface)
        .copyWith(
          headlineLarge: GoogleFonts.tomorrow(),
          headlineMedium: GoogleFonts.oswald(),
        ),

    // --- Personnalisation générale pour l'application entière ---
    appBarTheme: AppBarTheme(
      titleTextStyle: TextStyle(
        fontSize: 30,
        fontFamily: GoogleFonts.spaceGrotesk().fontFamily,
        fontWeight: FontWeight.bold,
        color: colorScheme.onPrimary,
      ),
      actionsPadding: const EdgeInsets.all(5),
      backgroundColor: colorScheme.primary,
      centerTitle: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          // Apply a 30-pixel radius to both bottom corners
          bottom: Radius.circular(20),
        ),
      ),
    ),

    iconButtonTheme: IconButtonThemeData(
      style: IconButton.styleFrom(foregroundColor: colorScheme.onPrimary),
    ),

    dividerTheme: DividerThemeData(
      space: 40,
      color: colorScheme.primary.withAlpha(50),
      thickness: 2,
    ),

    snackBarTheme: SnackBarThemeData(
      backgroundColor: colorScheme.primary,
      contentTextStyle: TextStyle(color: colorScheme.onPrimary),
      actionTextColor: colorScheme.secondaryContainer,
    ),

    // --- HomeScreen ---
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
        textStyle: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20,
          fontFamily: GoogleFonts.tomorrow().fontFamily,
        ),
        backgroundColor: colorScheme.inversePrimary.withAlpha(70),
        foregroundColor: colorScheme.inverseSurface,
        side: BorderSide(color: colorScheme.primary, width: 2),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      ),
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
        textStyle: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20,
          fontFamily: GoogleFonts.tomorrow().fontFamily,
        ),
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      ),
    ),

    // --- UserScreen ---
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: colorScheme.primary),
      ),
      suffixIconColor: colorScheme.primary,
    ),

    switchTheme: SwitchThemeData(
      thumbColor: WidgetStateProperty.all(colorScheme.primary),
      trackColor: WidgetStateProperty.all(colorScheme.primary.withAlpha(90)),
      trackOutlineColor: WidgetStateProperty.all(colorScheme.primary),
    ),

    // --- DashboardScreen ---
    progressIndicatorTheme: ProgressIndicatorThemeData(
      color: colorScheme.primary,
      linearMinHeight: 10,
      borderRadius: BorderRadius.circular(10),
    ),

    cardTheme: CardThemeData(
      elevation: 2,
      shadowColor: colorScheme.primary,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
    ),

    toggleButtonsTheme: ToggleButtonsThemeData(
      fillColor: colorScheme.primary.withAlpha(250),
      selectedColor: colorScheme.onPrimary,
      borderRadius: BorderRadius.circular(10),
      textStyle: TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: 15,
        fontFamily: GoogleFonts.tomorrow().fontFamily,
      ),
    ),

    // --- CameraScreen ---
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: colorScheme.primary,
      foregroundColor: colorScheme.onPrimary,
      shape: const CircleBorder(),
      elevation: 15,
    ),

    dialogTheme: DialogThemeData(
      alignment: AlignmentGeometry.center,
      titleTextStyle: TextStyle(fontFamily: GoogleFonts.tomorrow().fontFamily),
    ),
  );
}

// =========================================================================
// THÈMES GLOBAUX (Exposés)
// =========================================================================

// Thème CLAIR (utilise la couleur seed passée)
ThemeData getLightTheme(MaterialColor seedColor) {
  return _buildThemeData(brightness: Brightness.light, seedColor: seedColor);
}

// Thème SOMBRE (utilise la couleur seed passée)
ThemeData getDarkTheme(MaterialColor seedColor) {
  return _buildThemeData(brightness: Brightness.dark, seedColor: seedColor);
}
