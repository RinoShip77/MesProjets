import 'package:flutter/material.dart';
// Pour kDebugMode
import 'package:macro_vision/screens/feedback_screen.dart';
import 'package:macro_vision/screens/home_screen.dart';
import 'package:macro_vision/widgets/custom_app_bar.dart'; // Pour pouvoir relancer MacroVisionApp

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
        title: 'Erreur critique',
        foreground: Colors.white,
        background: Colors.red.shade700,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 80, color: Colors.red),

              const SizedBox(height: 20),

              Text(
                message,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                ),
              ),

              if (details != null) ...[
                const SizedBox(height: 20),
                const Text(
                  "Détails (visible en mode Débogage) :",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
                Text(
                  details!,
                  textAlign: TextAlign.start,
                  style: const TextStyle(fontSize: 14, color: Colors.grey),
                ),
              ],

              const SizedBox(height: 40),
              
              // Bouton pour soumettre un commentaire
              ElevatedButton.icon(
                icon: const Icon(Icons.feedback_rounded),
                label: const Text('Soumettre un commentaire'),
                onPressed: () {
                  // Relance l'application en naviguant vers la racine
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => FeedbackScreen(message: '$message :\n$details'),
                    ),
                  );
                },
              ),
              
              ElevatedButton.icon(
                icon: const Icon(Icons.restart_alt_rounded),
                label: const Text('Revenir à l\'accueil'),
                onPressed: () {
                  // Relance l'application en naviguant vers la racine
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => HomeScreen(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
