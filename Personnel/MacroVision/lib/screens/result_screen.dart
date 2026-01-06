import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:macro_vision/helpers/helpers.dart';
import 'package:macro_vision/services/gemini_service.dart';
import 'package:macro_vision/widgets/custom_app_bar.dart';
import 'package:provider/provider.dart';
import 'package:macro_vision/models/nutritional_facts.dart';
import 'package:macro_vision/services/theme_provider.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:macro_vision/models/user_profile.dart'; // Import pour UserProfile
import 'package:macro_vision/utils/l10n_extension.dart';

class ResultScreen extends StatefulWidget {
  final NutritionalFacts initialFacts;
  final String imagePath;
  final String origin;

  const ResultScreen({
    super.key,
    required this.initialFacts,
    required this.imagePath,
    required this.origin,
  });

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  late NutritionalFacts _currentFacts;
  final TextEditingController _weightController = TextEditingController();
  late String origin;

  // true = affiche Kilojoules (kJ)
  // false = affiche Kilocalories (kcal)
  bool _useKilojoules = false;

  // NOUVEAU: Préférence d'unité chargée (g ou lbs pour la portion)
  bool _isMetric = true;

  // Taux de conversion : 1 kcal ≈ 4.184 kJ
  static const double _kJConversionFactor = 4.184;
  // NOUVEAU: Constante de conversion: 1 gramme ≈ 0.002205 livre (lbs)
  static const double _gToLbs = 0.002205;

  @override
  void initState() {
    super.initState();
    _currentFacts = widget.initialFacts;
    origin = widget.origin;
    _loadUnitPreference(); // Chargement de la préférence d'unité
  }

  // TODO: Envoyer cette fonction de un fichier "helpers.dart"
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

  // TODO: Envoyer cette fonction de un fichier "helpers.dart"
  // NOUVEAU: Conversion du poids (g) pour l'affichage (lbs)
  double _getDisplayPortion(double grams) {
    if (_isMetric) {
      return grams; // Afficher en grammes
    } else {
      return grams * _gToLbs; // Afficher en livres (lbs)
    }
  }

  // TODO: Envoyer cette fonction de un fichier "helpers.dart"
  // Fonction pour l'ajustement (Prompt 2.1)
  void _refineAnalysis() {
    // Remplacer la virgule par un point pour le parsing
    final double? displayWeight = double.tryParse(
      _weightController.text.replaceAll(',', '.'),
    );

    if (displayWeight != null && displayWeight > 0) {
      // 1. Conversion de la valeur saisie (Impérial/lbs) vers le STOCKAGE (Métrique/g)
      double newWeightInGrams;
      if (!_isMetric) {
        // Conversion livres (lbs) -> grammes (g)
        newWeightInGrams = displayWeight / _gToLbs;
      } else {
        newWeightInGrams = displayWeight; // Reste en grammes
      }

      // 2. Application de la mise à l'échelle sur le modèle (qui utilise des grammes)
      final updatedFacts = widget.initialFacts.copyWithRefinedWeight(
        newWeightInGrams,
      );

      setState(() {
        _currentFacts = updatedFacts;
        // 3. Mettre à jour le contrôleur avec la valeur affichée (g ou lbs)
        _weightController.text = _getDisplayPortion(
          updatedFacts.portionInGrams,
        ).toStringAsFixed(0);
      });

      final String portionUnit = _isMetric ? 'g' : 'lb';

      if (mounted) {
        showSnackBar(
          context,
          context.l10n.resultScreenRefineAnalysisLbl(
            _weightController.text,
            portionUnit,
          ),
          false,
        );
      }
    } else {
      if (mounted) {
        showSnackBar(
          context,
          context.l10n.appWarningFormValidation('weight'),
          true,
        );
      }
    }
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
          switchLabel = context.l10n.resultScreenSwitchLbl(energyUnit);
          // switchLabel = 'Afficher en kcal/cal';
        } else {
          // Affichage en Kilocalories (kcal)
          energyUnit = 'cal';
          energyValue = caloriesInKcal;
          switchLabel = context.l10n.resultScreenSwitchLbl(energyUnit);
          // switchLabel = 'Afficher en kJ';
        }

        // NOUVEAU: Déterminer l'unité et le label pour la portion
        final String portionUnit = _isMetric ? 'g' : 'lbs';
        final String portionLabel = context.l10n.resultScreenPortionLbl(
          portionUnit,
        );
        final double initialDisplayPortion = _getDisplayPortion(
          widget.initialFacts.portionInGrams,
        );
        final double currentDisplayPortion = _getDisplayPortion(
          _currentFacts.portionInGrams,
        );

        return Scaffold(
          appBar: CustomAppBar(
            title: context.l10n.resultScreenTitle,
            backButton: true,
          ),
          body: Stack(
            children: <Widget>[
              SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // --- AFFICHAGE DE L'IMAGE CAPTURÉE ---
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: File(widget.imagePath).existsSync()
                          ? Image.file(
                              File(widget.imagePath),
                              height: 200,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            )
                          : Icon(
                              Icons.fastfood_outlined,
                              size: 40,
                              color: Theme.of(context).colorScheme.error,
                            ),
                    ),

                    const SizedBox(height: 16),

                    Text(
                      _currentFacts.foodName,
                      style: Theme.of(context).textTheme.headlineLarge
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),

                    const SizedBox(height: 10),

                    if (!origin.contains('History')) ...{
                      // --- AJUSTEMENT DE LA PORTION (avec unité dynamique) ---
                      Text(
                        context.l10n.resultScreenEstimatedWeightLbl(
                          formatNumber(
                            initialDisplayPortion,
                            fractionDigits: 0,
                          ),
                          portionUnit,
                        ),
                        // 'Portion estimée par l\'IA: ${formatNumber(initialDisplayPortion, fractionDigits: 0)} $portionUnit',
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(fontStyle: FontStyle.italic),
                      ),

                      const SizedBox(height: 10),

                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: _weightController,
                              decoration: InputDecoration(
                                labelText: portionLabel,
                              ),
                              keyboardType: TextInputType.numberWithOptions(
                                decimal: true,
                              ),
                              inputFormatters: [
                                // Permet les décimales (point ou virgule)
                                FilteringTextInputFormatter.allow(
                                  RegExp(r'[\d.,]'),
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(width: 20),

                          ElevatedButton(
                            onPressed: _refineAnalysis,
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 15,
                              ),
                            ),
                            child: Text(
                              context.l10n.resultScreenRefineAnalysisBtn,
                            ),
                          ),
                        ],
                      ),

                      Divider(),

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
                          ),
                        ],
                      ),
                    },

                    const SizedBox(height: 5),

                    // --- Carte des Faits Nutritifs ---
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(25),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // --- Titre (avec unité dynamique) ---
                            Text(
                              'Analyse nutritionnelle pour ${formatNumber(currentDisplayPortion, fractionDigits: 0)} $portionUnit',
                              style: Theme.of(context).textTheme.titleLarge
                                  ?.copyWith(fontWeight: FontWeight.bold),
                            ),

                            Divider(),

                            // Affichage de l'Énergie avec la valeur et l'unité dynamique
                            if (_useKilojoules)
                              buildFactRow(
                                context,
                                context.l10n.resultScreenAnalysisOutputLbl(
                                  'energy',
                                ),
                                energyValue,
                                energyUnit,
                              ),
                            if (!_useKilojoules)
                              buildFactRow(
                                context,
                                context.l10n.resultScreenAnalysisOutputLbl(
                                  'calories',
                                ),
                                energyValue,
                                energyUnit,
                              ),

                            // Séparateur avec couleur primaire éclaircie via l'opacité
                            Divider(),

                            // --- Détails des Macronutriments ---
                            buildFactRow(
                              context,
                              context.l10n.resultScreenAnalysisOutputLbl(
                                'totalFat',
                              ),
                              _currentFacts.totalFat,
                              'g',
                            ),

                            buildSubFactRow(
                              context,
                              context.l10n.resultScreenAnalysisOutputLbl(
                                'saturatedFat',
                              ),
                              _currentFacts.saturatedFat,
                              'g',
                            ),

                            buildSubFactRow(
                              context,
                              context.l10n.resultScreenAnalysisOutputLbl(
                                'transFat',
                              ),
                              _currentFacts.transFat,
                              'g',
                            ),

                            buildFactRow(
                              context,
                              context.l10n.resultScreenAnalysisOutputLbl(
                                'cholesterol',
                              ),
                              _currentFacts.cholesterol,
                              'mg',
                            ),

                            buildFactRow(
                              context,
                              context.l10n.resultScreenAnalysisOutputLbl(
                                'sodium',
                              ),
                              _currentFacts.sodium,
                              'mg',
                            ),

                            buildFactRow(
                              context,
                              context.l10n.resultScreenAnalysisOutputLbl(
                                'potassium',
                              ),
                              _currentFacts.potassium,
                              'mg',
                            ),

                            buildFactRow(
                              context,
                              context.l10n.resultScreenAnalysisOutputLbl(
                                'carbohydrate',
                              ),
                              _currentFacts.totalCarbohydrates,
                              'g',
                            ),

                            buildSubFactRow(
                              context,
                              context.l10n.resultScreenAnalysisOutputLbl(
                                'fiber',
                              ),
                              _currentFacts.dietaryFiber,
                              'g',
                            ),

                            buildSubFactRow(
                              context,
                              context.l10n.resultScreenAnalysisOutputLbl(
                                'sugar',
                              ),
                              _currentFacts.sugar,
                              'g',
                            ),

                            buildFactRow(
                              context,
                              context.l10n.resultScreenAnalysisOutputLbl(
                                'protein',
                              ),
                              _currentFacts.protein,
                              'g',
                            ),
                          ],
                        ),
                      ),
                    ),

                    if (!origin.contains('History')) ...[
                      const SizedBox(height: 15),

                      Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          // --- BOUTON D'ACTION (Ajouter à l'Historique / Nouvelle analyse) ---
                          Tooltip(
                            message: '',
                            child: ElevatedButton.icon(
                              icon: const Icon(Icons.add_a_photo_rounded),
                              label: Text(
                                context.l10n.resultScreenNewAnalysisBtn,
                              ),
                              onPressed: () =>
                                  saveAndReturn(context, _currentFacts),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
