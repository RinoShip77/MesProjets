import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Pour obtenir l'info sur la plateforme
import 'package:macro_vision/widgets/custom_app_bar.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:macro_vision/helpers/helpers.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:macro_vision/utils/l10n_extension.dart';

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
          context.l10n.feedbackScreenNoRecipientEmailLbl,
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
          'body': _feedbackController.text.trim(),
        }),
      );

      // Lancement de l'application de messagerie
      try {
        await launchUrl(emailLaunchUri);

        if (mounted) {
          // Toast de succès (si la fonction est importée)
          showSnackBar(
            context,
            context.l10n.feedbackScreenOpeningEmailLbl,
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
            context.l10n.feedbackScreenNoEmailClientLbl,
            true,
            duration: 5000,
          );
        }

        setState(() {
          _emailApp = false;
        });
      }
    } catch (e) {
      if (mounted) {
        showSnackBar(context, context.l10n.feedbackScreenSendingError, true);
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
      appBar: CustomAppBar(title: context.l10n.feedbackScreenTitle),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                context.l10n.feedbackScreenEncouragingMessageLbl,
                style: const TextStyle(fontSize: 16),
              ),

              const SizedBox(height: 20),

              // Nom
              buildTextField(
                controller: _nameController,
                label: context.l10n.appUserNameInpLbl,
                keyboardType: TextInputType.name,
                formatters: null, // Pas de formatage spécifique pour le texte
              ),

              const SizedBox(height: 20),

              TextFormField(
                controller: _feedbackController,
                minLines: 5,
                maxLines: null,
                keyboardType: TextInputType.multiline,
                decoration: InputDecoration(
                  labelText: context.l10n.feedbackScreenCommentPaceholderLbl,
                  hintText: widget.message == null || widget.message!.isEmpty
                      ? context.l10n.feedbackScreenCommentHintLbl
                      : widget.message,
                  alignLabelWithHint: true,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return context.l10n.appWarningFormValidation('comment');
                  }

                  return null;
                },
              ),

              const SizedBox(height: 20),

              Tooltip(
                message: context.l10n.feedbackScreenSendTooltip,
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
                    context.l10n.feedbackScreenSendBtn(_isSending.toString()),
                    style: const TextStyle(fontSize: 16),
                  ),
                  onPressed: _isSending ? null : _submitFeedback,
                ),
              ),

              if (!_emailApp) ...[
                // Bouton de copie
                const SizedBox(height: 30),

                Tooltip(
                  message: context.l10n.feedbackScreenSendToClipboard,
                  child: OutlinedButton.icon(
                    icon: Icon(Icons.content_copy_rounded),
                    label: Text(
                      context.l10n.feedbackScreenSendToClipboard,
                      textAlign: TextAlign.center,
                    ),
                    onPressed: () async {
                      await Clipboard.setData(
                        ClipboardData(
                          text:
                              '${formatEmailSubject(context, _nameController.text.trim())} ${formatEmailBody(context, _feedbackController.text.trim())}',
                        ),
                      );

                      if (context.mounted) {
                        showSnackBar(
                          context,
                          context.l10n.feedbackScreenSendedToClipboard(
                            'comment',
                          ),
                          false,
                        );
                      }
                    },
                  ),
                ),
              ],

              if (dotenv.env['FEEDBACK_EMAIL'] != null) ...[
                const SizedBox(height: 10),

                TextButton.icon(
                  icon: !_emailApp
                      ? Icon(Icons.email_rounded)
                      : Icon(Icons.copy_rounded),
                  label: Text(dotenv.env['FEEDBACK_EMAIL']!),
                  onPressed: () {
                    Clipboard.setData(
                      ClipboardData(text: dotenv.env['FEEDBACK_EMAIL']!),
                    ).then((_) {
                      if (context.mounted) {
                        showSnackBar(
                          context,
                          context.l10n.feedbackScreenSendedToClipboard('email'),
                          false,
                        );
                      }
                    });
                  },
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
