// Fichier : lib/widgets/custom_app_bar.dart

import 'package:flutter/material.dart';
import 'package:macro_vision/helpers/helpers.dart';
import 'package:macro_vision/screens/feedback_screen.dart';

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
    this.backButton = true,
    super.key,
  }) : preferredSize = const Size.fromHeight(
         kToolbarHeight,
       ); // kToolbarHeight est 56.0

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
        showSnackBar(
          context,
          'Erreur: Impossible de lire le guide utilisateur.',
          true,
        );
      }

      return 'Erreur lors du chargement des instructions.';
    }
  }

  @override
  Widget build(BuildContext context) {
    // Widget? leading;

    // if (!home) {
    //   leading = MenuAnchor(
    //     // Define the list of actions for the dropdown menu
    //     menuChildren: [
    //       MenuItemButton(
    //         leadingIcon: const Icon(Icons.feedback_rounded),
    //         child: const Text('Commentaire'),
    //         onPressed: () async {
    //           // 💡 Le rendre ASYNC pour un meilleur contrôle
    //           try {
    //             // Supposons que _navigateAndRefresh est une fonction normale (non async)
    //             // Si elle est async, utilisez await.
    //             navigate(context, const FeedbackScreen());
    //           } catch (e, stack) {
    //             print(
    //               "Erreur lors de l'ouverture de l'écran de commentaires : $e",
    //             );
    //             print(stack);

    //             // Afficher une Snackbar pour informer l'utilisateur sans crasher
    //             if (context.mounted) {
    //               showSnackBar(
    //                 context,
    //                 "Impossible d'ouvrir l'écran de commentaires.",
    //                 true,
    //               );
    //             }
    //           }
    //         },
    //         // onPressed: () => _navigateAndRefresh(context, FeedbackScreen()),
    //       ),
    //       MenuItemButton(
    //         leadingIcon: const Icon(Icons.info_outline_rounded),
    //         child: const Text('Guide'),
    //         onPressed: () async {
    //           try {
    //             // 1. Charger le texte du guide de manière sûre
    //             final String guideContent = await _getGuideText(context);

    //             // 2. Ouvrir le dialogue UNIQUEMENT si le contenu a été chargé
    //             if (context.mounted) {
    //               await openDialog(
    //                 context: context,
    //                 title: 'Guide d\'utilisation',
    //                 content: guideContent, // Utilisez le contenu chargé
    //               );
    //             }
    //           } catch (e, stack) {
    //             // 3. En cas d'erreur de chargement ou d'ouverture du dialogue :
    //             print("Erreur lors de l'ouverture du dialogue Guide : $e");
    //             print(stack);

    //             // Afficher une simple Snackbar à l'utilisateur au lieu de crasher
    //             if (context.mounted) {
    //               // Assurez-vous que showSnackBar est importé de helpers.dart
    //               showSnackBar(
    //                 context,
    //                 "Erreur: Impossible de charger le guide d'utilisation.",
    //                 true,
    //               );
    //             }
    //           }
    //         },
    //       ),
    //     ],
    //     // Define the actual button widget that the user taps
    //     builder:
    //         (BuildContext context, MenuController controller, Widget? child) {
    //           return IconButton(
    //             onPressed: () {
    //               // Toggle the menu visibility when the button is pressed
    //               if (controller.isOpen) {
    //                 controller.close();
    //               } else {
    //                 controller.open();
    //               }
    //             },
    //             icon: const Icon(Icons.menu_rounded), // The "menu" button icon
    //             tooltip: 'Ouvrir le menu',
    //           );
    //         },
    //   );
    // }

    return AppBar(
      title: Text(title),
      centerTitle: true,
      actions: [
        ...?actions,
        // Guide
        IconButton(
          icon: const Icon(Icons.info_outline_rounded),
          tooltip: 'Guide utilisateur',
          onPressed: () async {
              try {
                // 1. Charger le texte du guide de manière sûre
                final String guideContent = await _getGuideText(context);

                // 2. Ouvrir le dialogue UNIQUEMENT si le contenu a été chargé
                if (context.mounted) {
                  await openDialog(
                    context: context,
                    title: 'Guide d\'utilisation',
                    content: guideContent, // Utilisez le contenu chargé
                  );
                }
              } catch (e, stack) {
                // 3. En cas d'erreur de chargement ou d'ouverture du dialogue :
                print("Erreur lors de l'ouverture du dialogue Guide : $e");
                print(stack);

                // Afficher une simple Snackbar à l'utilisateur au lieu de crasher
                if (context.mounted) {
                  // Assurez-vous que showSnackBar est importé de helpers.dart
                  showSnackBar(
                    context,
                    "Erreur: Impossible de charger le guide d'utilisation.",
                    true,
                  );
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