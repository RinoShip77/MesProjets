import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:macro_vision/models/nutritional_facts.dart';
import 'package:macro_vision/services/theme_provider.dart'; // Pour le Consumer

class ResultScreen extends StatefulWidget {
  final NutritionalFacts facts;
  final String imagePath; // Chemin de l'image pour l'affichage

  const ResultScreen({super.key, required this.facts, required this.imagePath});

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  // true = affiche Kilojoules (kJ)
  // false = affiche Kilocalories (kcal)
  bool _useKilojoules = false;

  // Taux de conversion : 1 kcal ≈ 4.184 kJ
  static const double _kJConversionFactor = 4.184;

  // Fonction pour formater les nombres au format français (point -> virgule)
  String _formatNumber(double value, {int fractionDigits = 1}) {
    // Formate la valeur avec la précision souhaitée (ex: "12.3")
    String formatted = value.toStringAsFixed(fractionDigits);
    // Remplace le point décimal par une virgule
    return formatted.replaceAll('.', ',');
  }

  // Widget utilitaire pour afficher une ligne principale
  Widget _buildFactRow(String label, double value, String unit) {
    // Utilise 0 chiffre après la virgule pour les mg (Cholestérol, Sodium, Potassium)
    final int fractionDigits = unit == 'mg' ? 0 : 1;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          Text(
            '${_formatNumber(value, fractionDigits: fractionDigits)} $unit',
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
        ],
      ),
    );
  }

  // Widget utilitaire pour afficher une sous-ligne
  Widget _buildSubFactRow(String label, double value, String unit) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, top: 4.0, bottom: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontSize: 14)),
          Text(
            '${_formatNumber(value)} $unit', // Par défaut à 1 décimale
            style: const TextStyle(fontSize: 14),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Le Consumer est essentiel pour forcer la reconstruction du widget lorsque le thème change
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        // --- Logique de bascule pour l'énergie ---
        final double caloriesInKcal = widget.facts.calories;

        final String energyUnit;
        final double energyValue;
        String switchLabel;

        if (_useKilojoules) {
          // Affichage en Kilojoules (kJ)
          energyUnit = 'kJ';
          energyValue = caloriesInKcal * _kJConversionFactor;
          switchLabel = 'Afficher en kcal/cal';
        } else {
          // Affichage en Kilocalories (kcal)
          energyUnit = 'cal';
          energyValue = caloriesInKcal;
          switchLabel = 'Afficher en kJ';
        }

        return Scaffold(
          appBar: AppBar(
            title: Text(widget.facts.foodName),
            // Utilisation de la couleur primaire dynamique du thème
            backgroundColor: Theme.of(context).colorScheme.primary,
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // --- AFFICHAGE DE L'IMAGE CAPTURÉE ---
                ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: Image.file(
                    File(widget.imagePath),
                    height: 200,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 16),

                // --- SWITCH POUR SÉLECTIONNER L'UNITÉ ---
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      switchLabel, style: TextStyle(fontSize: 14)),
                    Switch(
                      value: _useKilojoules,
                      onChanged: (bool newValue) {
                        setState(() {
                          _useKilojoules = newValue;
                        });
                      },
                      activeThumbColor: Theme.of(
                        context,
                      ).colorScheme.primary.withOpacity(0.5),
                    ),
                  ],
                ),
                const SizedBox(height: 10),

                // --- Carte des Faits Nutritifs ---
                Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // --- Titre ---
                        Text(
                          'Analyse Nutritionnelle',
                          style: Theme.of(context).textTheme.headlineSmall
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        const Divider(),

                        // Affichage de l'Énergie avec la valeur et l'unité dynamique
                        _buildFactRow('Énergie', energyValue, energyUnit),
                        // Séparateur avec couleur primaire éclaircie via l'opacité
                        Divider(
                          height: 30,
                          thickness: 2,
                          color: Theme.of(
                            context,
                          ).colorScheme.primary.withOpacity(0.5),
                        ),

                        // --- Détails des Macronutriments ---
                        Text(
                          'Macronutriments',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        _buildFactRow(
                          'Matières grasses totales',
                          widget.facts.totalFat,
                          'g',
                        ),
                        _buildSubFactRow(
                          'Graisses saturées',
                          widget.facts.saturatedFat,
                          'g',
                        ),
                        _buildSubFactRow(
                          'Graisses trans',
                          widget.facts.transFat,
                          'g',
                        ),

                        _buildFactRow(
                          'Cholestérol',
                          widget.facts.cholesterol,
                          'mg',
                        ),
                        _buildFactRow('Sodium', widget.facts.sodium, 'mg'),
                        _buildFactRow(
                          'Potassium',
                          widget.facts.potassium,
                          'mg',
                        ),

                        _buildFactRow(
                          'Glucides totaux',
                          widget.facts.totalCarbohydrates,
                          'g',
                        ),
                        _buildSubFactRow(
                          'Fibres alimentaires',
                          widget.facts.dietaryFiber,
                          'g',
                        ),
                        _buildSubFactRow('Sucres', widget.facts.sugar, 'g'),
                        _buildFactRow('Protéines', widget.facts.protein, 'g'),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // --- BOUTON D'ACTION (Nouvelle analyse) ---
                Center(
                  child: TextButton.icon(
                    // Utiliser la couleur primaire dynamique pour le texte et l'icône
                    icon: Icon(
                      Icons.camera_alt,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    label: Text(
                      'Analyser une nouvelle photo',
                      style: TextStyle(
                        fontSize: 18,
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onPressed: () {
                      // Revenir à l'écran précédent
                      Navigator.of(context).pop();
                    },
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        );
      },
    );
  }
}
