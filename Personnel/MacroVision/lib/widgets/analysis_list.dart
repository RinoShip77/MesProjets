// Fichier : lib/widgets/analysis_list.dart

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:macro_vision/models/nutritional_facts_entry.dart';
import 'package:macro_vision/screens/history_screen.dart';
import 'package:macro_vision/screens/result_screen.dart';
import 'package:macro_vision/helpers/helpers.dart'; // Pour formatDate

class AnalysisList extends StatelessWidget {
  final Future<List<NutritionalFactsEntry>> historyFuture;
  final bool
  compactMode; // Si true, active la limite de hauteur et le scroll interne
  final double maxHeight; // Hauteur max pour le mode compact
  final Function(NutritionalFactsEntry)?
  onDismissed; // Gestion de la suppression (pour HistoryScreen)

  const AnalysisList({
    required this.historyFuture,
    this.compactMode = false,
    this.maxHeight = double.infinity,
    this.onDismissed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<NutritionalFactsEntry>>(
      future: historyFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return const Center(
            child: Text('Erreur de chargement des analyses.'),
          );
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          final message = compactMode
              ? 'Aucune analyse effectuée aujourd\'hui.'
              : 'Aucun historique d\'analyse trouvé.';

          return Center(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Text(
                message,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
          );
        }

        final history = snapshot.data!;

        // La ListView interne qui gère l'affichage des tuiles
        Widget listView = ListView.builder(
          // Important pour le mode compact dans un conteneur de hauteur fixe
          shrinkWrap: compactMode,
          // Désactive le scroll si la liste est intégrée dans un SingleChildScrollView (HomeScreen)
          physics: compactMode
              ? const NeverScrollableScrollPhysics()
              : const BouncingScrollPhysics(),
          itemCount: history.length,
          itemBuilder: (context, index) {
            final entry = history[index];
            final tile = _buildAnalysisTile(context, entry, compactMode);

            if (compactMode || onDismissed == null) {
              // Mode compact (HomeScreen) ou simple tuile
              return tile;
            } else {
              // Mode historique complet (HistoryScreen) avec suppression par glissement
              return Dismissible(
                key: Key(entry.id.toString()),
                direction: DismissDirection.horizontal,
                background: _buildDismissBackground(),
                onDismissed: (direction) =>
                    onDismissed!.call(entry), // Appel du callback
                child: tile,
              );
            }
          },
        );

        // Envelopper la liste pour le mode compact afin de définir la hauteur de défilement
        if (compactMode) {
          // Si compact, on contraint la hauteur à maxHeight pour l'aperçu scrollable.
          return Card(
            margin: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 10.0,
            ),
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
                    snapshot.data!.isNotEmpty
                        ? "Dernières analyses (${snapshot.data!.length})"
                        : "Analyses d'aujourd'hui",
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ),

                const Divider(height: 16),

                // --- Contenu des résultats ou message vide ---
                if (snapshot.data!.isNotEmpty)
                  // 💡 NOUVEAU BLOC : Conteneur défilable pour l'historique d'aujourd'hui
                  SizedBox(
                    // Limite la hauteur de l'aperçu à 2 éléments maximum
                    // Ajustez cette valeur si la hauteur des éléments est différente.
                    height: 40 * snapshot.data!.take(2).length.toDouble(),
                    child: ListView.builder(
                      shrinkWrap:
                          true, // IMPORTANT : pour ne prendre que l'espace nécessaire
                      physics:
                          const BouncingScrollPhysics(), // Rend le défilement agréable
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        final entry = snapshot.data![index];
                        return _buildAnalysisTile(context, entry, true);
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
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),

                // --- Bouton "Voir tout" ---
                if (snapshot.data!.length > 1)
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton.icon(
                      icon: const Icon(
                        Icons.arrow_forward_ios_rounded,
                        size: 16,
                      ),
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

        }

        return listView;
      },
    );
  }

  // Fonction pour construire une seule tuile (basée sur l'InkWell corrigé)
  Widget _buildAnalysisTile(
    BuildContext context,
    NutritionalFactsEntry entry,
    bool isCompact,
  ) {
    final date = DateTime.fromMillisecondsSinceEpoch(entry.timestamp);
    final formattedTime = DateFormat.Hm().format(date);
    final theme = Theme.of(context);

    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => ResultScreen(
              initialFacts: entry,
              imagePath: entry.imagePath,
              origin: runtimeType.toString(),
            ),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Row(
          children: [
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
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    entry.foodName,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.bodyLarge,
                  ),
                  Text(
                    isCompact
                        ? '${entry.calories.toStringAsFixed(0)} cal à $formattedTime'
                        : 'Cal: ${entry.calories.toStringAsFixed(1)} | ${formatDate(date)} $formattedTime', // Réutilise formatDate
                    style: theme.textTheme.bodySmall,
                  ),
                ],
              ),
            ),
            const Icon(Icons.chevron_right_rounded, size: 20),
          ],
        ),
      ),
    );
  }

  // Fond pour la suppression (réutilisé)
  Widget _buildDismissBackground() {
    return Container(
      color: Colors.red,
      alignment: Alignment.centerRight,
      padding: const EdgeInsets.only(left: 20.0, right: 20.0),
      child: const Row(
        children: [
          Icon(Icons.delete_rounded, color: Colors.white),
          Spacer(),
          Icon(Icons.delete_rounded, color: Colors.white),
        ],
      ),
    );
  }
}
