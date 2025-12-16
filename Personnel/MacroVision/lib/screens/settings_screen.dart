import 'package:flutter/material.dart';
import 'package:macro_vision/helpers/helpers.dart';
import 'package:macro_vision/widgets/custom_app_bar.dart';
import 'package:provider/provider.dart';
import 'package:macro_vision/services/theme_provider.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: CustomAppBar(title: 'Réglages'),
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
            buildThemeOption(
              title: 'Défaut du système',
              target: ThemeModeOption.system,
              current: themeProvider.themeModeOption,
              onChanged: themeProvider.setThemeMode,
            ),

            buildThemeOption(
              title: 'Mode clair',
              target: ThemeModeOption.light,
              current: themeProvider.themeModeOption,
              onChanged: themeProvider.setThemeMode,
            ),

            buildThemeOption(
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
              (customTheme) => buildThemeOption(
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
}
