import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:macro_vision/services/theme_provider.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Réglages de l\'Application'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Thèmes & Apparence',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const Divider(),

            // Section 1: Mode Clair / Sombre / Système
            _buildThemeOption(
              context,
              title: 'Défaut du système',
              mode: ThemeModeOption.system,
              currentMode: themeProvider.themeModeOption,
              onChanged: themeProvider.setThemeMode,
            ),
            _buildThemeOption(
              context,
              title: 'Clair (Light)',
              mode: ThemeModeOption.light,
              currentMode: themeProvider.themeModeOption,
              onChanged: themeProvider.setThemeMode,
            ),
            _buildThemeOption(
              context,
              title: 'Sombre (Dark)',
              mode: ThemeModeOption.dark,
              currentMode: themeProvider.themeModeOption,
              onChanged: themeProvider.setThemeMode,
            ),

            const SizedBox(height: 30),
            Text(
              'Thèmes Personnalisés',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const Divider(),
            
            // Section 2: Choix du thème personnalisé
            ...customThemes.map((theme) => 
              _buildCustomThemeOption(
                context,
                theme: theme,
                currentTheme: themeProvider.customTheme,
                onChanged: themeProvider.setCustomTheme,
              )
            ),
          ],
        ),
      ),
    );
  }
  
  // Widget utilitaire pour les options de mode de base
  Widget _buildThemeOption(
    BuildContext context, {
    required String title,
    required ThemeModeOption mode,
    required ThemeModeOption currentMode,
    required Function(ThemeModeOption) onChanged,
  }) {
    return RadioListTile<ThemeModeOption>(
      title: Text(title),
      value: mode,
      groupValue: currentMode,
      onChanged: (ThemeModeOption? value) {
        if (value != null) {
          onChanged(value);
        }
      },
      activeColor: Theme.of(context).colorScheme.primary,
    );
  }

  // Widget utilitaire pour les options de thèmes personnalisés
  Widget _buildCustomThemeOption(
    BuildContext context, {
    required CustomTheme theme,
    required CustomTheme currentTheme,
    required Function(CustomTheme) onChanged,
  }) {
    return RadioListTile<CustomTheme>(
      title: Text(theme.name),
      secondary: Container(
        width: 24,
        height: 24,
        decoration: BoxDecoration(
          color: theme.color,
          shape: BoxShape.circle,
        ),
      ),
      value: theme,
      groupValue: currentTheme,
      onChanged: (CustomTheme? value) {
        if (value != null) {
          onChanged(value);
        }
      },
      activeColor: Theme.of(context).colorScheme.primary,
    );
  }
}