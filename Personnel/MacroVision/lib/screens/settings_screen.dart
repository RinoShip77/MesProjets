import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:macro_vision/services/theme_provider.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Réglages')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Luminosité de l\'application',
              style: Theme.of(context).textTheme.titleLarge,
            ),

            const Divider(),

            // Section 1: Mode Clair / Sombre / Système
            _buildThemeOption(
              context,
              title: 'Défaut du système',
              target: ThemeModeOption.system,
              current: themeProvider.themeModeOption,
              onChanged: themeProvider.setThemeMode,
            ),
            _buildThemeOption(
              context,
              title: 'Mode clair',
              target: ThemeModeOption.light,
              current: themeProvider.themeModeOption,
              onChanged: themeProvider.setThemeMode,
            ),
            _buildThemeOption(
              context,
              title: 'Mode sombre',
              target: ThemeModeOption.dark,
              current: themeProvider.themeModeOption,
              onChanged: themeProvider.setThemeMode,
            ),

            const SizedBox(height: 30),
            Text(
              'Couleurs personnalisées',
              style: Theme.of(context).textTheme.titleLarge,
            ),

            const Divider(),

            // Section 2: Choix du thème personnalisé
            ...customThemes.map(
              (customTheme) => _buildThemeOption(
                context,
                title: customTheme.name,
                target: customTheme,
                current: themeProvider.customTheme,
                onChanged: themeProvider.setCustomTheme,
              ),
            ),
          ],
        ),
      ),
    );
  }

// TODO: Envoyer cette fonction de un fichier "helpers.dart"
  // Widget utilitaire pour les options de mode de base
  Widget _buildThemeOption(
    BuildContext context, {
    required String title,
    required target,
    required current,
    required onChanged,
  }) {
    return RadioListTile<dynamic>(
      title: Text(title),
      value: target,
      groupValue: current,
      onChanged: (value) {
        if (value != null) {
          onChanged(value);
        }
      },
    );
  }
}