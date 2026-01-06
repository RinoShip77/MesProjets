import 'package:flutter/material.dart';
import 'package:macro_vision/helpers/helpers.dart';
import 'package:macro_vision/utils/l10n_extension.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Color? foreground;
  final Color? background;
  final List<Widget>? actions;
  final bool backButton;

  // Hauteur standard d'une AppBar Material
  @override
  final Size preferredSize;

  const CustomAppBar({
    required this.title,
    this.foreground,
    this.background,
    this.actions,
    this.backButton = false,
    super.key,
  }) : preferredSize = const Size.fromHeight(
         kToolbarHeight,
       ); // kToolbarHeight est 56.0

  // =========================================================================
  // LOGIQUE DE L'AVERTISSEMENT LÉGALE
  // =========================================================================
  Future<String> _getWarningText(BuildContext context) async {
    try {
      return await DefaultAssetBundle.of(
        context,
      ).loadString('assets/legal_warning.md', cache: false);
    } catch (e) {
      if (context.mounted) {
        showSnackBar(
          context,
          context.l10n.appErrorReadFile('legalWarning'),
          true,
        );
      }

      return context.l10n.appErrorLoadingAssets;
    }
  }

  // =========================================================================
  // LOGIQUE DU GUIDE UTILISATEUR
  // =========================================================================
  Future<String> _getGuideText(BuildContext context) async {
    try {
      return await DefaultAssetBundle.of(
        context,
      ).loadString('assets/user_guide.md', cache: false);
    } catch (e) {
      if (context.mounted) {
        showSnackBar(context, context.l10n.appErrorReadFile('userGuide'), true);
      }

      return context.l10n.appErrorLoadingAssets;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      centerTitle: true,
      actions: [
        ...?actions,
        // Guide
        IconButton(
          icon: const Icon(Icons.warning_amber_rounded),
          tooltip: context.l10n.appDialogTitle('legalWarning'),
          onPressed: () async {
            try {
              // 1. Charger le texte du guide de manière sûre
              final String content = await _getWarningText(context);

              // 2. Ouvrir le dialogue UNIQUEMENT si le contenu a été chargé
              if (context.mounted) {
                await openDialog(
                  context: context,
                  title: context.l10n.appDialogTitle('legalWarning'),
                  content: content, // Utilisez le contenu chargé
                );
              }
            } catch (e) {
              // 3. En cas d'erreur de chargement ou d'ouverture du dialogue :
              // Afficher une simple Snackbar à l'utilisateur au lieu de crasher
              if (context.mounted) {
                // Assurez-vous que showSnackBar est importé de helpers.dart
                showSnackBar(context, context.l10n.appErrorLoadingAssets, true);
              }
            }
          },
        ),
        IconButton(
          icon: const Icon(Icons.info_outline_rounded),
          tooltip: context.l10n.appDialogTitle('userGuide'),
          onPressed: () async {
            try {
              // 1. Charger le texte du guide de manière sûre
              final String content = await _getGuideText(context);

              // 2. Ouvrir le dialogue UNIQUEMENT si le contenu a été chargé
              if (context.mounted) {
                await openDialog(
                  context: context,
                  title: context.l10n.appDialogTitle('userGuide'),
                  content: content, // Utilisez le contenu chargé
                );
              }
            } catch (e) {
              // 3. En cas d'erreur de chargement ou d'ouverture du dialogue :
              // Afficher une simple Snackbar à l'utilisateur au lieu de crasher
              if (context.mounted) {
                // Assurez-vous que showSnackBar est importé de helpers.dart
                showSnackBar(context, context.l10n.appErrorLoadingAssets, true);
              }
            }
          },
        ),
      ],
      foregroundColor: foreground,
      backgroundColor: background,
      automaticallyImplyLeading: backButton,
    );
  }
}



    // return universalScaffold(
    //   // appBar: AppBar(title: const Text('Réglages')),
    //   context: context,
    //   title: 'Réglages',
    //   body: Stack(
    //     children: <Widget>[
    //       SingleChildScrollView(
    //         padding: const EdgeInsets.all(20.0),
    //         child: Column(
    //           crossAxisAlignment: CrossAxisAlignment.start,
    //           children: [
    //             Text(
    //               'Luminosité de l\'application',
    //               style: Theme.of(context).textTheme.titleLarge,
    //             ),

    //             const Divider(),

    //             // Section 1: Mode Clair / Sombre / Système
    //             buildThemeOption(
    //               title: 'Défaut du système',
    //               target: ThemeModeOption.system,
    //               current: themeProvider.themeModeOption,
    //               onChanged: themeProvider.setThemeMode,
    //             ),

    //             buildThemeOption(
    //               title: 'Mode clair',
    //               target: ThemeModeOption.light,
    //               current: themeProvider.themeModeOption,
    //               onChanged: themeProvider.setThemeMode,
    //             ),

    //             buildThemeOption(
    //               title: 'Mode sombre',
    //               target: ThemeModeOption.dark,
    //               current: themeProvider.themeModeOption,
    //               onChanged: themeProvider.setThemeMode,
    //             ),

    //             const SizedBox(height: 30),

    //             Text(
    //               'Couleurs personnalisées',
    //               style: Theme.of(context).textTheme.titleLarge,
    //             ),

    //             const Divider(),

    //             // Section 2: Choix du thème personnalisé
    //             ...customThemes.map(
    //               (customTheme) => buildThemeOption(
    //                 title: customTheme.name,
    //                 target: customTheme,
    //                 current: themeProvider.customTheme,
    //                 onChanged: themeProvider.setCustomTheme,
    //               ),
    //             ),
    //           ],
    //         ),
    //       ),
    //     ],
    //   ),
    // );