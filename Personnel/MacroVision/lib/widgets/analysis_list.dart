// Fichier : lib/widgets/analysis_list.dart

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:macro_vision/main.dart';
import 'package:macro_vision/models/nutritional_facts_entry.dart';
import 'package:macro_vision/screens/history_screen.dart';
import 'package:macro_vision/screens/result_screen.dart';
import 'package:macro_vision/helpers/helpers.dart'; // Pour formatDate
import 'package:macro_vision/utils/l10n_extension.dart';

class AnalysisList extends StatelessWidget {
  final Future<List<NutritionalFactsEntry>> historyFuture;
  final bool compactMode;
  final double maxHeight;
  final Function(NutritionalFactsEntry)? onDismissed;
  final bool disableScroll;

  const AnalysisList({
    required this.historyFuture,
    this.compactMode = false,
    this.maxHeight = double.infinity,
    this.onDismissed,
    this.disableScroll = false,
    super.key,
  });

  // Fond pour la suppression (réutilisé)
  Widget _buildDismissBackground(BuildContext context) {
    return Container(
      color: Theme.brightnessOf(context) == Brightness.light
                    ? Theme.of(context).colorScheme.error
                    : Theme.of(context).colorScheme.errorContainer,
      alignment: Alignment.centerRight,
      padding: const EdgeInsets.only(left: 20.0, right: 20.0),
      child: Row(
        children: [
          Icon(
            Icons.delete_rounded,
            color: Theme.brightnessOf(context) == Brightness.light
                ? Theme.of(context).colorScheme.onError
                : Theme.of(context).colorScheme.onErrorContainer,
          ),
          const Spacer(),
          Icon(
            Icons.delete_rounded,
            color: Theme.brightnessOf(context) == Brightness.light
                    ? Theme.of(context).colorScheme.onError
                    : Theme.of(context).colorScheme.onErrorContainer,
          ),
        ],
      ),
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
                child: File(entry.imagePath).existsSync()
                    ? Image.file(File(entry.imagePath), fit: BoxFit.cover)
                    : Icon(
                        Icons.fastfood_outlined,
                        size: 40,
                        color: Theme.of(context).colorScheme.error,
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
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),

                  Text(
                    isCompact
                        ? context.l10n.statsCalorie(entry.calories.round())
                        : '${context.l10n.statsCalorie(entry.calories.round())} | ${formatDate(date)} $formattedTime', // Réutilise formatDate
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

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<NutritionalFactsEntry>>(
      future: historyFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text(context.l10n.appErrorLoadingContent));
        } else if ((!snapshot.hasData || snapshot.data!.isEmpty) &&
            !compactMode) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Text(
                context.l10n.appWarningEmptyData,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
          );
        }

        final history = snapshot.data!;

        // La ListView interne qui gère l'affichage des tuiles
        final Widget listView = ListView.builder(
          // 3. UPDATED LOGIC: ShrinkWrap if compact OR disabled scroll
          shrinkWrap: compactMode || disableScroll,
          // 4. UPDATED LOGIC: NeverScroll if compact OR disabled scroll
          physics: (compactMode || disableScroll)
              ? const NeverScrollableScrollPhysics()
              : const BouncingScrollPhysics(),
          itemCount: history.length,
          itemBuilder: (context, index) {
            final entry = history[index];
            final tile = _buildAnalysisTile(context, entry, false);

            if (compactMode || onDismissed == null) {
              // Mode compact (HomeScreen) ou simple tuile
              return tile;
            } else {
              // Mode historique complet (HistoryScreen) avec suppression par glissement
              return Dismissible(
                key: Key(entry.id.toString()),
                direction: DismissDirection.horizontal,
                background: _buildDismissBackground(context),
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
            // margin: const EdgeInsets.symmetric(
            //   horizontal: 16.0,
            //   vertical: 10.0,
            // ),
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
                    context.l10n.homeScreenDailyAnalisisLbl(
                      snapshot.data!.length,
                    ),
                    // snapshot.data!.isNotEmpty
                    //     ? '${context.l10n.titleDailySummary} (${snapshot.data!.length})'
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ),

                // --- Contenu des résultats ou message vide ---
                if (snapshot.data!.isNotEmpty)
                  // 💡 NOUVEAU BLOC : Conteneur défilable pour l'historique d'aujourd'hui
                  SizedBox(
                    // Limite la hauteur de l'aperçu à 2 éléments maximum
                    // Ajustez cette valeur si la hauteur des éléments est différente.
                    height: snapshot.data!.isNotEmpty
                        ? 75
                        : 1 * snapshot.data!.take(2).length.toDouble(),
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
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Text(
                      context.l10n.appWarningEmptyData,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),

                // --- Bouton "Voir tout" ---
                if (snapshot.data!.isNotEmpty)
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton.icon(
                      icon: const Icon(
                        Icons.arrow_forward_ios_rounded,
                        size: 16,
                      ),
                      label: Text(context.l10n.appSeeHistoryBtn),
                      onPressed: () => navigate(context, HistoryScreen()),
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
}
