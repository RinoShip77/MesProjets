// lib/screens/history_screen.dart

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Nécessite l'importation du package 'intl'
import 'package:macro_vision/models/nutritional_facts_entry.dart';
import 'package:macro_vision/services/database_service.dart';
import 'package:macro_vision/screens/result_screen.dart'; // Pour réutiliser l'écran de résultat

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
  
  // Recharge la liste après une suppression ou une mise à jour
  void _refreshHistory() {
    setState(() {
      _historyFuture = DatabaseService().getHistory();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Historique des Analyses'),
        // Ajoutez un bouton de rafraîchissement si nécessaire
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _refreshHistory,
          ),
        ],
      ),
      body: FutureBuilder<List<NutritionalFactsEntry>>(
        future: _historyFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Erreur de chargement : ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Aucun historique d\'analyse trouvé.'));
          } else {
            final history = snapshot.data!;
            return ListView.builder(
              itemCount: history.length,
              itemBuilder: (context, index) {
                final entry = history[index];
                return _buildHistoryTile(context, entry);
              },
            );
          }
        },
      ),
    );
  }

  Widget _buildHistoryTile(BuildContext context, NutritionalFactsEntry entry) {
    // Formatte la date
    final date = DateTime.fromMillisecondsSinceEpoch(entry.timestamp);
    final formattedDate = DateFormat('dd/MM/yyyy HH:mm').format(date);
    
    return Dismissible(
      key: Key(entry.id.toString()), // Clé unique pour la suppression par glissement
      direction: DismissDirection.endToStart,
      background: Container(
        color: Colors.red,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20.0),
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      onDismissed: (direction) async {
        // Suppression de l'entrée dans la BDD et de la photo locale
        if (entry.id != null) {
          await DatabaseService().deleteEntry(entry.id!);
          // Optionnel : Supprimer le fichier image local
          try {
            await File(entry.imagePath).delete();
          } catch (_) {}
          
          _refreshHistory(); // Rafraîchir l'interface
        }
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('${entry.foodName} supprimé de l\'historique.')),
        );
      },
      child: ListTile(
        leading: SizedBox(
          width: 56,
          height: 56,
          child: entry.imagePath.isNotEmpty
              ? Image.file(File(entry.imagePath), fit: BoxFit.cover)
              : const Icon(Icons.image_not_supported),
        ),
        title: Text(entry.foodName),
        subtitle: Text('Cal: ${entry.calories.toStringAsFixed(1)} | $formattedDate'),
        trailing: const Icon(Icons.chevron_right),
        onTap: () {
          // Naviguer vers l'écran de détail (ResultScreen)
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => ResultScreen(
                facts: entry, // L'entrée est un type NutritionalFacts
                imagePath: entry.imagePath,
              ),
            ),
          ).then((_) => _refreshHistory()); // Rafraîchir si on revient
        },
      ),
    );
  }
}