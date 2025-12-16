import 'dart:io';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Nécessite l'importation du package 'intl'
import 'package:macro_vision/helpers/helpers.dart';
import 'package:macro_vision/models/nutritional_facts_entry.dart';
import 'package:macro_vision/services/database_service.dart';
import 'package:macro_vision/screens/result_screen.dart';
import 'package:macro_vision/widgets/analysis_list.dart';
import 'package:macro_vision/widgets/custom_app_bar.dart'; // Pour réutiliser l'écran de résultat

// N'oubliez pas d'ajouter 'intl' dans pubspec.yaml si ce n'est pas déjà fait!

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  late Future<List<NutritionalFactsEntry>> _historyFuture;

  @override
  void initState() {
    super.initState();
    _historyFuture = DatabaseService().getHistory();
  }

  // TODO: Envoyer cette fonction de un fichier "helpers.dart"
  // Recharge la liste après une suppression ou une mise à jour
  void _refresh() {
    setState(() {
      _historyFuture = DatabaseService().getHistory();
    });

    if (mounted) {
      showSnackBar(context, 'Historique mis à jour.', false);
    }
  }

  // 💡 NOUVELLE MÉTHODE : Handler pour la suppression
  Future<void> _handleDismissed(NutritionalFactsEntry entry) async {
    final date = DateTime.fromMillisecondsSinceEpoch(entry.timestamp);

    // Logique de suppression de l'entrée et du fichier
    if (entry.id != null) {
      await DatabaseService().deleteEntry(entry.id!);
      try {
        await File(entry.imagePath).delete();
      } catch (e) {
        if (mounted) {
          showSnackBar(
            context,
            'Erreur de suppression du fichier local.',
            true,
          );
        }
      }
      _refresh(); // Rafraîchir l'interface
    }

    if (mounted) {
      showSnackBar(
        context,
        'L\'entrée du ${formatDate(date)} a été supprimée de l\'historique.',
        false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Historique des analyses',
        // Ajoutez un bouton de rafraîchissement si nécessaire
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh_outlined),
            onPressed: _refresh,
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsetsGeometry.only(top: 10),
        child: AnalysisList(
          // 💡 UTILISATION DU WIDGET UNIVERSEL
          historyFuture: _historyFuture, // Le Future de l'historique complet
          compactMode: false, // Mode normal
          onDismissed:
              _handleDismissed, // Passe le callback pour la suppression
        ),
      ),
    );
  }
}
