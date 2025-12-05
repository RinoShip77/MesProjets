import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:macro_vision/models/nutritional_facts.dart';
import 'package:macro_vision/services/theme_provider.dart';
import 'package:flutter/services.dart';

class ResultScreen extends StatefulWidget {
  final NutritionalFacts
  initialFacts; // FIX: Changé de 'facts' à 'initialFacts'
  final String imagePath; // Chemin de l'image pour l'affichage

  const ResultScreen({
    super.key,
    required this.initialFacts,
    required this.imagePath,
  }); // FIX: Changé de 'facts' à 'initialFacts'

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  late NutritionalFacts _currentFacts;
  final TextEditingController _weightController = TextEditingController();

  // true = affiche Kilojoules (kJ)
  // false = affiche Kilocalories (kcal)
  bool _useKilojoules = false;

  // Taux de conversion : 1 kcal ≈ 4.184 kJ
  static const double _kJConversionFactor = 4.184;

  @override
  void initState() {
    super.initState();
    _currentFacts = widget.initialFacts;
    // Pré-remplir avec l'estimation initiale de Gemini
    _weightController.text = _currentFacts.portionInGrams.toStringAsFixed(0);
  }

  // Fonction pour l'ajustement (Prompt 2.1)
  void _refineAnalysis() {
    final double? newWeight = double.tryParse(_weightController.text);

    if (newWeight != null && newWeight > 0) {
      // Nous repartons de l'estimation initiale de l'IA pour éviter les arrondis cumulés
      final updatedFacts = widget.initialFacts.copyWithRefinedWeight(newWeight);

      setState(() {
        _currentFacts = updatedFacts;
        _weightController.text = newWeight.toStringAsFixed(0);
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Analyse ajustée pour ${newWeight.toStringAsFixed(0)}g.',
          ),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Veuillez entrer un poids valide en grammes.'),
        ),
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
    final int fractionDigits = unit == 'mg' ? 0 : 1;

    return Padding(
      padding: const EdgeInsets.only(left: 16.0, top: 4.0, bottom: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontSize: 14)),
          Text(
            '${_formatNumber(value, fractionDigits: fractionDigits)} $unit',
            style: const TextStyle(fontSize: 14),
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
        // final double caloriesInKcal = widget.initialFacts.calories;
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

        return Scaffold(
          appBar: AppBar(
            title: Text(
              _currentFacts.foodName,
            ), // TODO : Ajuster pour toujours afficher le nom correct
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

                // --- AJUSTEMENT DE LA PORTION (Prompt 2.1) ---
                Text(
                  'Portion estimée par l\'IA: ${_formatNumber(widget.initialFacts.portionInGrams, fractionDigits: 0)}g',
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
                        decoration: const InputDecoration(
                          labelText: 'Poids réel (g)',
                          border: OutlineInputBorder(),
                        ),
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
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

                // --- SWITCH POUR SÉLECTIONNER L'UNITÉ ---
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
                          'Analyse Nutritionnelle pour ${_formatNumber(_currentFacts.portionInGrams, fractionDigits: 0)}g',
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
