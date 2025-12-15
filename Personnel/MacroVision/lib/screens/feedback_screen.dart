import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Pour obtenir l'info sur la plateforme
import 'package:url_launcher/url_launcher.dart';
import 'package:macro_vision/helpers/helpers.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

// Import de la fonction Toast si vous l'avez centralisée
// import 'package:macro_vision/helpers/helpers.dart';

class FeedbackScreen extends StatefulWidget {
  final String? message;

  const FeedbackScreen({super.key, this.message});

  @override
  State<FeedbackScreen> createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  final TextEditingController _feedbackController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isSending = false;
  bool _emailApp = true;

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

    // 1. Récupération de l'email depuis .env
    final String recipientEmail = dotenv.env['FEEDBACK_EMAIL'] ?? '';

    if (recipientEmail.isEmpty) {
      if (mounted) {
        showSnackBar(
          context,
          'L\'adresse e-mail de feedback est manquante.',
          true,
          duration: 5000,
        );
      }
      setState(() {
        _isSending = false;
        _emailApp = false;
      });
      return;
    }

    // final String feedbackMessage = _feedbackController.text.trim();

    // --- NOUVELLE LOGIQUE D'ENVOI PAR EMAIL ---
    try {
      // Encodage des chaînes pour l'URL
      final Uri emailLaunchUri = Uri(
        scheme: 'mailto',
        path: recipientEmail,
        query: encodeQueryParameters(<String, String>{
          'subject': ?formatEmailSubject(context, _nameController.text.trim()),
          // Corps de l'e-mail avec le message du testeur et les informations d'aide
          'body': ?formatEmailBody(context, _feedbackController.text.trim()),
        }),
      );

      // Lancement de l'application de messagerie
      // if (await canLaunchUrl(emailLaunchUri)) {
      try {
        await launchUrl(emailLaunchUri);

        if (mounted) {
          // Toast de succès (si la fonction est importée)
          showSnackBar(
            context,
            'Ouverture de l\'application de messagerie.',
            false,
          );
        }

        _feedbackController.clear(); // Vider le champ après l'ouverture
      } catch (e) {
        // } else {
        if (mounted) {
          // Le cas où l'appareil n'a pas de client email configuré
          showSnackBar(
            context,
            'Impossible d\'ouvrir l\'application d\'e-mail.',
            true,
            duration: 5000,
          );
        }

        setState(() {
          _emailApp = false;
        });
        // }
      }
    } catch (e) {
      if (mounted) {
        showSnackBar(context, 'Erreur lors de l\'envoi du feedback : $e', true);
      }
    } finally {
      setState(() {
        _isSending = false;
      });
    }
  }

  // Fonction utilitaire pour encoder les paramètres d'URL (à ajouter dans helpers.dart si non présent)
  // Mieux : la laisser ici si c'est la seule fois qu'elle est utilisée.
  String? encodeQueryParameters(Map<String, String> params) {
    return params.entries
        .map(
          (MapEntry<String, String> e) =>
              '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}',
        )
        .join('&');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Vos Commentaires')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                "J'apprécie vos retours ! Aidez-moi à améliorer MacroVision.",
                style: TextStyle(fontSize: 16),
              ),

              const SizedBox(height: 20),

              // Nom
              buildTextField(
                controller: _nameController,
                label: 'Nom',
                keyboardType: TextInputType.name,
                formatters: null, // Pas de formatage spécifique pour le texte
              ),

              const SizedBox(height: 20),

              TextFormField(
                controller: _feedbackController,
                maxLines: 8,
                keyboardType: TextInputType.multiline,
                decoration: InputDecoration(
                  labelText: widget.message == null || widget.message!.isEmpty
                      ? 'Votre message ...'
                      : widget.message,
                  hintText:
                      'Décrivez votre expérience, signalez un bug ou proposez une idée...',
                  alignLabelWithHint: true,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez saisir votre commentaire.';
                  }

                  return null;
                },
              ),

              const SizedBox(height: 20),

              Tooltip(
                message: 'Envoyer la rétroaction.',
                child: ElevatedButton.icon(
                  icon: _isSending
                      ? SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 3,
                            color: Theme.of(context).colorScheme.onPrimary,
                          ),
                        )
                      : const Icon(Icons.send_rounded),
                  label: Text(
                    _isSending ? 'Envoi en cours...' : 'Envoyer la rétroaction',
                    style: const TextStyle(fontSize: 16),
                  ),
                  onPressed: _isSending ? null : _submitFeedback,
                ),
              ),

              if (!_emailApp && dotenv.env['FEEDBACK_EMAIL'] != null) ...[
                const SizedBox(height: 20),
                Text(
                  'Ou copiez l\'adresse e-mail ci-dessous pour l\'utiliser manuellement :',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                const SizedBox(height: 10),
                // Bouton de copie
                OutlinedButton.icon(
                  icon: const Icon(Icons.copy_rounded),
                  label: Text(dotenv.env['FEEDBACK_EMAIL']!),
                  onPressed: () {
                    Clipboard.setData(
                      ClipboardData(text: dotenv.env['FEEDBACK_EMAIL']!),
                    ).then((_) {
                      if (mounted) {
                        showSnackBar(context, 'Adresse e-mail copiée !', false);
                      }
                    });
                  },
                ),
              ],

              // if (!_emailApp) ...[
              //   const SizedBox(height: 30),

              //   Tooltip(
              //     message: 'Envoyer mon message vers le presse-papiers.',
              //     child: OutlinedButton.icon(
              //       icon: const Icon(Icons.assignment_outlined),
              //       label: const Text(
              //         'Envoyer mon message vers le presse-papiers',
              //         textAlign: TextAlign.center,
              //       ),
              //       onPressed: () async {
              //         await Clipboard.setData(
              //           ClipboardData(
              //             text:
              //                 formatFeedback(
              //                   context,
              //                   _feedbackController.text.trim(),
              //                 ) ??
              //                 '',
              //           ),
              //         );

              //         if (mounted) {
              //           showSnackBar(
              //             context,
              //             'Text envoyé dans le presse-papiers.',
              //             false,
              //           );
              //         }
              //       },
              //     ),
              //   ),
              // ],

              // if (dotenv.env['FEEDBACK_EMAIL'] != null) ...[
              //   const SizedBox(height: 10),

              //   Text(
              //     dotenv.env['FEEDBACK_EMAIL']!,
              //     textAlign: TextAlign.center,
              //   ),
              // ],
            ],
          ),
        ),
      ),
    );
  }
}
