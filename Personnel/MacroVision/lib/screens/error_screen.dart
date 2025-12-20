import 'package:flutter/material.dart';
// Pour kDebugMode
import 'package:macro_vision/screens/feedback_screen.dart';
import 'package:macro_vision/screens/home_screen.dart';
import 'package:macro_vision/widgets/custom_app_bar.dart'; // Pour pouvoir relancer MacroVisionApp
import 'package:macro_vision/utils/l10n_extension.dart';

// =========================================================================
// WIDGET D'ERREUR CRITIQUE (ErrorScreen)
// =========================================================================

class ErrorScreen extends StatelessWidget {
  final String message;
  final String? details;

  const ErrorScreen({super.key, required this.message, this.details});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: context.l10n.errorScreenTitle,
        foreground: Theme.of(context).colorScheme.onError,
        background: Theme.of(context).colorScheme.error,
      ),
      // Utilise la couleur d'erreur du thème actuel
      backgroundColor: Theme.of(context).colorScheme.errorContainer,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.error_outline,
                size: 80,
                color: Theme.of(context).colorScheme.error,
              ),

              const SizedBox(height: 20),

              Text(
                message,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  color: Theme.of(context).colorScheme.error,
                  fontWeight: FontWeight.bold,
                ),
              ),

              if (details != null) ...[
                const SizedBox(height: 20),
                Text(
                  context.l10n.errorScreenDetailsLbl,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onErrorContainer,
                  ),
                ),
                Text(
                  details!,
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontSize: 14,
                    color: Theme.of(context).colorScheme.onErrorContainer,
                  ),
                ),
              ],

              const SizedBox(height: 40),

              // Bouton pour soumettre un commentaire
              ElevatedButton.icon(
                icon: Icon(Icons.feedback_rounded, color: Theme.of(context).colorScheme.error),
                label: Text(context.l10n.errorScreenGoToBtn('comment'),
                  style: TextStyle(color: Theme.of(context).colorScheme.error),),
                onPressed: () {
                  // Relance l'application en naviguant vers la racine
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) =>
                          FeedbackScreen(message: '$message :\n$details'),
                    ),
                  );
                },
              ),

              ElevatedButton.icon(
                icon: Icon(
                  Icons.restart_alt_rounded,
                  color: Theme.of(context).colorScheme.error,
                ),
                label: Text(
                  context.l10n.errorScreenGoToBtn('home'),
                  style: TextStyle(color: Theme.of(context).colorScheme.error),
                ),
                onPressed: () {
                  // Relance l'application en naviguant vers la racine
                  Navigator.of(
                    context,
                  ).push(MaterialPageRoute(builder: (context) => HomeScreen()));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
