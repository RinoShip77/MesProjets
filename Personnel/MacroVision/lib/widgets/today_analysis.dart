// Fichier : lib/widgets/today_analysis_card.dart

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:macro_vision/helpers/helpers.dart'; // Pour formatDate si vous l'utilisez
import 'package:macro_vision/models/nutritional_facts_entry.dart';
import 'package:macro_vision/services/database_service.dart';
import 'package:macro_vision/screens/result_screen.dart';
import 'package:macro_vision/screens/history_screen.dart'; // Pour navigation vers l'historique complet

class TodayAnalysis extends StatefulWidget {
  const TodayAnalysis({super.key});

  @override
  State<TodayAnalysis> createState() => _TodayAnalysisState();
}

class _TodayAnalysisState extends State<TodayAnalysis> {
  late Future<List<NutritionalFactsEntry>> _todayHistoryFuture;

  @override
  void initState() {
    super.initState();
    _loadTodayHistory();
  }

  // Fonction pour charger et filtrer l'historique
  void _loadTodayHistory() {
    // 1. Récupérer l'historique complet
    final allHistoryFuture = DatabaseService().getHistory();

    // 2. Filtrer les résultats pour 'aujourd'hui'
    _todayHistoryFuture = allHistoryFuture.then((allHistory) {
      final now = DateTime.now();

      return allHistory.where((entry) {
        final entryDate = DateTime.fromMillisecondsSinceEpoch(entry.timestamp);
        return entryDate.year == now.year &&
            entryDate.month == now.month &&
            entryDate.day == now.day;
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return FutureBuilder<List<NutritionalFactsEntry>>(
      future: _todayHistoryFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        final todayResults = snapshot.data ?? [];
        final hasResults = todayResults.isNotEmpty;

        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // --- En-tête de la carte ---
              Padding(
                padding: const EdgeInsets.only(
                  top: 16.0,
                  left: 16.0,
                  right: 16.0,
                ),
                child: Text(
                  hasResults
                      ? "Dernières analyses (${todayResults.length})"
                      : "Analyses d'aujourd'hui",
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.primary,
                  ),
                ),
              ),

              const Divider(height: 16),

              // --- Contenu des résultats ou message vide ---
              if (hasResults)
                // 💡 NOUVEAU BLOC : Conteneur défilable pour l'historique d'aujourd'hui
                SizedBox(
                  // Limite la hauteur de l'aperçu à 2 éléments maximum
                  // Ajustez cette valeur si la hauteur des éléments est différente.
                  height: 40 * todayResults.take(2).length.toDouble(),
                  child: ListView.builder(
                    shrinkWrap:
                        true, // IMPORTANT : pour ne prendre que l'espace nécessaire
                    physics:
                        const BouncingScrollPhysics(), // Rend le défilement agréable
                    itemCount: todayResults.length,
                    itemBuilder: (context, index) {
                      final entry = todayResults[index];
                      return _buildAnalysisTile(context, entry);
                    },
                  ),
                )
              else
                Container(
                  padding: const EdgeInsets.only(
                    bottom: 16.0,
                    left: 16.0,
                    right: 16.0,
                  ),
                  child: Text(
                    "Aucune analyse effectuée aujourd'hui.",
                    style: theme.textTheme.bodyMedium?.copyWith(
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),

              // --- Bouton "Voir tout" ---
              if (todayResults.length > 1)
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton.icon(
                    icon: const Icon(Icons.arrow_forward_ios_rounded, size: 16),
                    label: const Text("Voir l'historique complet"),
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const HistoryScreen(),
                        ),
                      );
                    },
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  // Widget compact pour afficher une seule entrée
  Widget _buildAnalysisTile(BuildContext context, NutritionalFactsEntry entry) {
    final date = DateTime.fromMillisecondsSinceEpoch(entry.timestamp);
    final formattedTime = DateFormat.Hm().format(date); // Juste l'heure
    final theme = Theme.of(context);

    return InkWell(
      // Le Padding contrôle l'espacement vertical et horizontal
      child: Padding(
        // 💡 CONTRÔLE TOTAL DU PADDING :
        // Réduisez la valeur verticale au strict minimum (ex: 8.0)
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Row(
          children: [
            // 1. Image (Leading)
            SizedBox(
              width: 40,
              height: 40,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: entry.imagePath.isNotEmpty
                    ? Image.file(File(entry.imagePath), fit: BoxFit.cover)
                    : Icon(
                        Icons.image_not_supported,
                        size: 40,
                        color: theme.colorScheme.onSurface.withOpacity(0.6),
                      ),
              ),
            ),

            const SizedBox(
              width: 12,
            ), // Espace entre l'image et le texte (Leading/Title)
            // 2. Texte (Titre et Sous-titre)
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    entry.foodName,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.bodyLarge, // Style plus précis
                  ),
                  Text(
                    '${entry.calories.toStringAsFixed(0)} cal à $formattedTime',
                    style: theme.textTheme.bodySmall,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
