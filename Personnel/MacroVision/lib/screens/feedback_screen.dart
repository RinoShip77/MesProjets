import 'package:flutter/material.dart';
import 'package:macro_vision/main.dart';

// Import de la fonction Toast si vous l'avez centralisée
// import 'package:macro_vision/helpers/helpers.dart'; 

class FeedbackScreen extends StatefulWidget {
  const FeedbackScreen({super.key});

  @override
  State<FeedbackScreen> createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  final TextEditingController _feedbackController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isSending = false;

  @override
  void dispose() {
    _feedbackController.dispose();
    super.dispose();
  }

  // Logique de soumission (À PERSONNALISER)
  Future<void> _submitFeedback() async {
    if (!_formKey.currentState!.validate()) {
      return; // Validation échouée
    }

    setState(() {
      _isSending = true;
    });

    final String feedbackMessage = _feedbackController.text.trim();
    
    // ==========================================================
    // 💡 LOGIQUE D'ENVOI (Exemple : Intégration d'un service)
    // ==========================================================
    try {
      // 1. Envoyer le message via une API, un service d'email, ou une base de données.
      // Par exemple : await FeedbackService().send(feedbackMessage);
      
      // Simulation d'une attente d'envoi
      await Future.delayed(const Duration(seconds: 2));

      // 2. Afficher la confirmation
      if (mounted) {
        // Utilisation du Toast si vous avez centralisé la fonction
        // showAppToast('Merci pour votre feedback !', isError: false);
        
        // Utilisation d'une SnackBar simple si le Toast n'est pas utilisé partout
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Merci pour votre feedback !')),
        );
        
        // 3. Fermer l'écran
        Navigator.of(context).pop();
      }

    } catch (e) {
      debugPrint("Erreur lors de l'envoi du feedback: $e");
      if (mounted) {
         // showAppToast('Échec de l\'envoi. Veuillez réessayer.', isError: true);
         ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Échec de l\'envoi. Veuillez réessayer.')),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isSending = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Vos Commentaires'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                "Nous apprécions vos retours ! Aidez-nous à améliorer MacroVision.",
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
              const SizedBox(height: 20),

              TextFormField(
                controller: _feedbackController,
                maxLines: 8,
                decoration: InputDecoration(
                  labelText: 'Votre message',
                  hintText: 'Décrivez votre expérience, signalez un bug ou proposez une idée...',
                  alignLabelWithHint: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Veuillez saisir votre commentaire.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 30),

              ElevatedButton.icon(
                icon: _isSending 
                    ? const SizedBox(
                        width: 20, 
                        height: 20, 
                        child: CircularProgressIndicator(strokeWidth: 3, color: Colors.white)
                      )
                    : const Icon(Icons.send),
                label: Text(
                  _isSending ? 'Envoi en cours...' : 'Envoyer le Feedback',
                  style: const TextStyle(fontSize: 16),
                ),
                onPressed: _isSending ? null : _submitFeedback,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),

              const SizedBox(height: 40),
              
              // Bouton pour relancer l'application
              ElevatedButton.icon(
                icon: const Icon(Icons.refresh_rounded),
                label: const Text('Relancer l\'application'),
                onPressed: () {
                  // Relance l'application en naviguant vers la racine
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                      builder: (context) => const MacroVisionApp(),
                    ),
                    (Route<dynamic> route) => false,
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