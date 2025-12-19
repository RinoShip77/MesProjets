import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:macro_vision/config/l10n/app_localizations.dart';
import 'package:macro_vision/helpers/helpers.dart';
import 'package:macro_vision/main.dart';
import 'package:macro_vision/widgets/custom_app_bar.dart';
import 'package:provider/provider.dart';
import 'package:macro_vision/services/theme_provider.dart';
import 'package:macro_vision/utils/l10n_extension.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    // 1. Récupérer les locales supportées par l'app (définies dans MaterialApp)
    final List<Locale> supportedLocales = AppLocalizations.supportedLocales;

    // 2. Récupérer la locale actuellement utilisée
    final Locale currentLocale = Localizations.localeOf(context);

    // Petite fonction utilitaire pour l'affichage dans le dropdown
    String getLanguageLabel(Locale locale) {
      // Si tu as ajouté "languageName" dans tes fichiers ARB,
      // l'idéal serait d'afficher le nom de la langue.
      // Sinon, on affiche le code pays ou langue.
      if (locale.languageCode == 'fr') {
        return context.l10n.appLanguageName('fr');
      }
      if (locale.languageCode == 'en') {
        return context.l10n.appLanguageName('en');
      }
      return locale.languageCode.toUpperCase();
    }

    return Scaffold(
      appBar: CustomAppBar(title: context.l10n.settingsScreenTitle),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              context.l10n.settingsScreenSectionLbl('language'),
              style: Theme.of(context).textTheme.titleLarge,
            ),

            const Divider(),

            ListTile(
              title: Text(
                context.l10n.settingsScreenLanguageSelectLbl,
              ), // Nouvelle clé ARB : "languageSettingTitle"
              trailing: DropdownButton<Locale>(
                value:
                    currentLocale, // La valeur est maintenant directement un objet Locale
                onChanged: (Locale? newLocale) {
                  if (newLocale != null) {
                    // Appelle ta fonction pour changer la langue
                    AppSetup.of(context).setLocale(newLocale);
                  }
                },
                items: supportedLocales.map((Locale locale) {
                  return DropdownMenuItem<Locale>(
                    value: locale,
                    child: Text(
                      getLanguageLabel(locale),
                    ), // Fonction pour afficher le nom lisible
                  );
                }).toList(),
              ),
            ),

            const Divider(),

            Text(
              context.l10n.settingsScreenSectionLbl('luminosity'),
              style: Theme.of(context).textTheme.titleLarge,
            ),

            const Divider(),

            // Section 1: Mode Clair / Sombre / Système
            buildThemeOption(
              title: context.l10n.settingsScreenLuminosityOption('default'),
              target: ThemeModeOption.system,
              current: themeProvider.themeModeOption,
              onChanged: themeProvider.setThemeMode,
            ),

            buildThemeOption(
              title: context.l10n.settingsScreenLuminosityOption('light'),
              target: ThemeModeOption.light,
              current: themeProvider.themeModeOption,
              onChanged: themeProvider.setThemeMode,
            ),

            buildThemeOption(
              title: context.l10n.settingsScreenLuminosityOption('dark'),
              target: ThemeModeOption.dark,
              current: themeProvider.themeModeOption,
              onChanged: themeProvider.setThemeMode,
            ),

            const SizedBox(height: 30),

            Text(
              context.l10n.settingsScreenSectionLbl('color'),
              style: Theme.of(context).textTheme.titleLarge,
            ),

            const Divider(),

            // Section 2: Choix du thème personnalisé
            ...customThemes.map(
              (customTheme) => buildThemeOption(
                title: context.l10n.settingsScreenCustomThemeOption(customTheme.name),
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
