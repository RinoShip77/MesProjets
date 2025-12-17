import 'package:flutter/material.dart';
import 'package:macro_vision/helpers/helpers.dart';
import 'package:macro_vision/main.dart';
import 'package:macro_vision/widgets/custom_app_bar.dart';
import 'package:provider/provider.dart';
import 'package:macro_vision/services/theme_provider.dart';
import 'package:macro_vision/helpers/l10n_extension.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  // Liste des options de langue disponibles
  final Map<String, Locale> availableLocales = const {
    'Français (Canada)': Locale('fr'),
    'English (Canada)': Locale('en'),
  };

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    // Accès à la locale courante du MaterialApp
    final currentLocale = Localizations.localeOf(context);

    // Fonction pour obtenir le nom affiché de la locale actuelle (pour le Dropdown)
    String getDropdownValue() {
      // Cherche si la locale actuelle correspond à une option
      for (var entry in availableLocales.entries) {
        if (entry.value == currentLocale) {
          return entry.key;
        }
      }
      // Solution de repli, retourne le nom de la première option
      return availableLocales.keys.first;
    }

    return Scaffold(
      appBar: CustomAppBar(title: context.l10n.settings, backButton: false),
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
            
            ListTile(
            title: Text(context.l10n.languageSettingTitle), // Nouvelle clé ARB : "languageSettingTitle"
            trailing: DropdownButton<String>(
              value: getDropdownValue(),
              onChanged: (String? newValue) {
                if (newValue != null) {
                  // 💡 APPEL DE LA FONCTION setLocale DANS AppSetup
                  AppSetup.of(context).setLocale(availableLocales[newValue]!);
                }
              },
              items: availableLocales.keys.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ),

            const Divider(),

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
