// lib/screens/result_screen.dart

import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:macro_vision/models/nutritional_facts.dart';
import 'package:macro_vision/services/theme_provider.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:macro_vision/models/user_profile.dart'; // Import pour UserProfile

class ResultScreen extends StatefulWidget {
  final NutritionalFacts initialFacts;
  final String imagePath;

  const ResultScreen({
    super.key,
    required this.initialFacts,
    required this.imagePath,
  });

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  late NutritionalFacts _currentFacts;
  final TextEditingController _weightController = TextEditingController();

  // true = affiche Kilojoules (kJ)
  // false = affiche Kilocalories (kcal)
  bool _useKilojoules = false;

  // NOUVEAU: Préférence d'unité chargée (g ou oz pour la portion)
  bool _isMetric = true;

  // Taux de conversion : 1 kcal ≈ 4.184 kJ
  static const double _kJConversionFactor = 4.184;
  // NOUVEAU: Constante de conversion: 1 gramme ≈ 0.035274 once (oz)
  static const double _gToOz = 0.035274;

  @override
  void initState() {
    super.initState();
    _currentFacts = widget.initialFacts;
    _loadUnitPreference(); // Chargement de la préférence d'unité
  }

  // NOUVEAU: Chargement de la préférence d'unité
  Future<void> _loadUnitPreference() async {
    final prefs = await SharedPreferences.getInstance();
    final userJson = prefs.getString('userProfile');

    if (userJson != null) {
      final profile = UserProfile.fromJson(jsonDecode(userJson));
      setState(() {
        _isMetric = profile.isMetric;
      });
    }

    // Pré-remplir avec l'estimation initiale de l'IA (après conversion)
    _weightController.text = _getDisplayPortion(
      _currentFacts.portionInGrams,
    ).toStringAsFixed(0);
  }

  // NOUVEAU: Conversion du poids (g) pour l'affichage (oz)
  double _getDisplayPortion(double grams) {
    if (_isMetric) {
      return grams; // Afficher en grammes
    } else {
      return grams * _gToOz; // Afficher en onces (oz)
    }
  }

  // Fonction pour l'ajustement (Prompt 2.1)
  void _refineAnalysis() {
    // Remplacer la virgule par un point pour le parsing
    final double? displayWeight = double.tryParse(
      _weightController.text.replaceAll(',', '.'),
    );

    if (displayWeight != null && displayWeight > 0) {
      // 1. Conversion de la valeur saisie (Impérial/oz) vers le STOCKAGE (Métrique/g)
      double newWeightInGrams;
      if (!_isMetric) {
        // Conversion onces (oz) -> grammes (g)
        newWeightInGrams = displayWeight / _gToOz;
      } else {
        newWeightInGrams = displayWeight; // Reste en grammes
      }

      // 2. Application de la mise à l'échelle sur le modèle (qui utilise des grammes)
      final updatedFacts = widget.initialFacts.copyWithRefinedWeight(
        newWeightInGrams,
      );

      setState(() {
        _currentFacts = updatedFacts;
        // 3. Mettre à jour le contrôleur avec la valeur affichée (g ou oz)
        _weightController.text = _getDisplayPortion(
          updatedFacts.portionInGrams,
        ).toStringAsFixed(0);
      });

      final String portionUnit = _isMetric ? 'g' : 'oz';

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Analyse ajustée pour ${_weightController.text}$portionUnit.',
          ),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Veuillez entrer un poids valide.')),
      );
    }
  }

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
            style: Theme.of(context,).textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            '${_formatNumber(value, fractionDigits: fractionDigits)} $unit',
            style: Theme.of(context,).textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  // Widget utilitaire pour afficher une sous-ligne
  Widget _buildSubFactRow(String label, double value, String unit) {
    final int fractionDigits = unit == 'mg' ? 0 : 1;

    return Padding(
      padding: const EdgeInsets.only(left: 16.0, top: 4.0, bottom: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: Theme.of(context,).textTheme.labelLarge,
          ),
          Text(
            '${_formatNumber(value, fractionDigits: fractionDigits)} $unit',
            style: Theme.of(context,).textTheme.labelLarge,
          ),
        ],
      ),
    );
  }

  // Bouton pour sauvegarder et revenir (Prompt 2.1)
  void _saveAndReturn() {
    // Renvoie les faits ajustés (ou non ajustés) à l'écran précédent.
    Navigator.of(context).pop(_currentFacts);
  }

  @override
  Widget build(BuildContext context) {
    // Le Consumer est essentiel pour forcer la reconstruction du widget lorsque le thème change
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        final double caloriesInKcal = _currentFacts.calories;

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

        // NOUVEAU: Déterminer l'unité et le label pour la portion
        final String portionUnit = _isMetric ? 'g' : 'oz';
        final String portionLabel = _isMetric
            ? 'Poids réel ($portionUnit)'
            : 'Poids réel ($portionUnit)';
        final double initialDisplayPortion = _getDisplayPortion(
          widget.initialFacts.portionInGrams,
        );
        final double currentDisplayPortion = _getDisplayPortion(
          _currentFacts.portionInGrams,
        );

        return Scaffold(
          appBar: AppBar(
            title: Text('Résultats de l\'Analyse'),
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

                Text(
                  _currentFacts.foodName,
                  style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),

                // --- AJUSTEMENT DE LA PORTION (avec unité dynamique) ---
                Text(
                  'Portion estimée par l\'IA: ${_formatNumber(initialDisplayPortion, fractionDigits: 0)}$portionUnit',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontStyle: FontStyle.italic,
                  ),
                ),
                const SizedBox(height: 10),

                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _weightController,
                        decoration: InputDecoration(
                          labelText: portionLabel, // Label dynamique
                          border: const OutlineInputBorder(),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                        ),
                        keyboardType: TextInputType.numberWithOptions(
                          decimal: true,
                        ),
                        inputFormatters: [
                          // Permet les décimales (point ou virgule)
                          FilteringTextInputFormatter.allow(RegExp(r'[\d.,]')),
                        ],
                      ),
                    ),
                    const SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: _refineAnalysis,
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 15,
                        ),
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        foregroundColor: Colors.white,
                      ),
                      child: const Text('Ajuster l\'Analyse'),
                    ),
                  ],
                ),
                const Divider(height: 30),

                // --- SWITCH POUR SÉLECTIONNER L'UNITÉ D'ÉNERGIE ---
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(switchLabel, style: TextStyle(fontSize: 14)),
                    Switch(
                      value: _useKilojoules,
                      onChanged: (bool newValue) {
                        setState(() {
                          _useKilojoules = newValue;
                        });
                      },
                      activeThumbColor: Theme.of(context).colorScheme.primary,
                      thumbColor: WidgetStateProperty.all(
                        Theme.of(context).colorScheme.primary,
                      ),
                      trackOutlineColor: WidgetStateProperty.all(
                        Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),

                // --- Carte des Faits Nutritifs ---
                Card(
                  elevation: 5,
                  shadowColor: Theme.of(context).colorScheme.primary,
                  color: Theme.of(context).cardColor.withAlpha(25),
                  
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(25),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // --- Titre (avec unité dynamique) ---
                        Text(
                          'Analyse Nutritionnelle pour ${_formatNumber(currentDisplayPortion, fractionDigits: 0)}$portionUnit',
                          style: Theme.of(context).textTheme.titleLarge
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
                        _buildFactRow(
                          'Matières grasses totales',
                          _currentFacts.totalFat,
                          'g',
                        ),
                        _buildSubFactRow(
                          'Graisses saturées',
                          _currentFacts.saturatedFat,
                          'g',
                        ),
                        _buildSubFactRow(
                          'Graisses trans',
                          _currentFacts.transFat,
                          'g',
                        ),
                        _buildFactRow(
                          'Cholestérol',
                          _currentFacts.cholesterol,
                          'mg',
                        ),
                        _buildFactRow('Sodium', _currentFacts.sodium, 'mg'),
                        _buildFactRow(
                          'Potassium',
                          _currentFacts.potassium,
                          'mg',
                        ),
                        _buildFactRow(
                          'Glucides totaux',
                          _currentFacts.totalCarbohydrates,
                          'g',
                        ),
                        _buildSubFactRow(
                          'Fibres alimentaires',
                          _currentFacts.dietaryFiber,
                          'g',
                        ),
                        _buildSubFactRow('Sucres', _currentFacts.sugar, 'g'),
                        _buildFactRow('Protéines', _currentFacts.protein, 'g'),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // --- BOUTON D'ACTION (Ajouter à l'Historique / Nouvelle analyse) ---
                ElevatedButton(
                  onPressed: _saveAndReturn,
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 50),
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    foregroundColor: Colors.white,
                  ),
                  child: const Text(
                    'Ajouter à l\'Historique',
                    style: TextStyle(fontSize: 18),
                  ),
                ),

                const SizedBox(height: 10),

                // --- BOUTON D'ACTION (Nouvelle analyse) ---
                Center(
                  child: TextButton.icon(
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
                      // Revenir à l'écran précédent en renvoyant null
                      Navigator.of(context).pop(null);
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
