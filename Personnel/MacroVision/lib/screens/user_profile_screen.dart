// lib/screens/user_profile_screen.dart

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Import ajouté pour FilteringTextInputFormatter
import 'package:macro_vision/screens/history_screen.dart';
import 'package:macro_vision/services/nutrition_calculator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:macro_vision/models/user_profile.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({super.key});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  late UserProfile _profile;
  bool _isLoading = true;

  // Contrôleurs pour les champs du formulaire
  late TextEditingController _nameController;
  late TextEditingController _weightController;
  late TextEditingController _heightController;
  late TextEditingController _ageController;

  // Liste des objectifs pour le Dropdown
  final List<String> _goals = ['Perte de poids', 'Gain musculaire', 'Maintien'];
  
  // Constantes de Conversion
  static const double _kgToLbs = 2.20462;
  static const double _cmToInches = 0.393701;

  @override
  void initState() {
    super.initState();
    _loadUserProfile();
  }

  // --- LOGIQUE DE PERSISTANCE ET CONVERSION ---

  Future<void> _loadUserProfile() async {
    final prefs = await SharedPreferences.getInstance();
    final userJson = prefs.getString('userProfile');

    if (userJson != null) {
      _profile = UserProfile.fromJson(jsonDecode(userJson));
    } else {
      _profile = UserProfile(); // Valeurs par défaut
    }

    // CORRECTION CRUCIALE : Initialiser tous les contrôleurs avant la logique de conversion
    _nameController = TextEditingController(text: _profile.name);
    _ageController = TextEditingController(text: _profile.age.toString());
    // Initialiser les contrôleurs de poids/taille avec la valeur de stockage (temporaire)
    _weightController = TextEditingController(text: _profile.weight.toString()); 
    _heightController = TextEditingController(text: _profile.height.toString()); 
    
    // Appel à la fonction de mise à jour. Les contrôleurs sont maintenant sûrs à utiliser.
    _updateUnitSystem(_profile.isMetric);

    setState(() {
      _isLoading = false;
    });
  }

  // NOUVEAU: Fonction pour mettre à jour l'état et l'affichage des unités
  void _updateUnitSystem(bool newIsMetric) {
    // 1. Mettre à jour la préférence d'unité.
    _profile.isMetric = newIsMetric;

    // 2. Calculer les valeurs pour l'AFFICHAGE en utilisant la valeur de STOCKAGE (toujours en kg/cm)
    double newDisplayWeight = _profile.weight;
    double newDisplayHeight = _profile.height;

    if (!newIsMetric) {
      // Conversion KG -> LBS pour l'affichage
      newDisplayWeight = _profile.weight * _kgToLbs;
      // Conversion CM -> POUCES pour l'affichage
      newDisplayHeight = _profile.height * _cmToInches;
    }

    // 3. Mettre à jour les contrôleurs pour refléter les nouvelles valeurs formatées.
    // Les unités métriques (kg, cm) sont affichées sans décimale.
    // Les unités impériales (lbs, pouces) sont affichées avec une décimale.
    _weightController.text = newDisplayWeight.toStringAsFixed(newIsMetric ? 0 : 1);
    _heightController.text = newDisplayHeight.toStringAsFixed(newIsMetric ? 0 : 1);
  }

  Future<void> _saveUserProfile({bool shouldPop = true}) async {
    // Assurez-vous que l'objet _profile a les bonnes valeurs de stockage métrique
    if (!_formKey.currentState!.validate()) {
      if (shouldPop) return;
    }

    // 1. Récupérer les valeurs affichées (en unités courantes)
    // Remplacer la virgule par un point pour le parsing
    final double displayWeight = double.tryParse(_weightController.text.replaceAll(',', '.')) ?? 0.0;
    final double displayHeight = double.tryParse(_heightController.text.replaceAll(',', '.')) ?? 0.0;
    final int age = int.tryParse(_ageController.text) ?? 0;

    // 2. Conversion des valeurs d'affichage vers le STOCKAGE (Métrique)
    double storageWeight = displayWeight;
    double storageHeight = displayHeight;

    if (!_profile.isMetric) {
      // Conversion LBS -> KG
      storageWeight = displayWeight / _kgToLbs;
      // Conversion INCHES -> CM
      storageHeight = displayHeight / _cmToInches;
    }
    
    // 3. Mettre à jour l'objet UserProfile avec les valeurs STOCKÉES (Métrique) et le choix d'unité
    _profile.name = _nameController.text;
    _profile.weight = storageWeight; // Stocké en KG
    _profile.height = storageHeight; // Stocké en CM
    _profile.age = age;
    // Les autres champs (gender, activityLevel, goal) sont mis à jour directement via les Dropdowns
    // _profile.isMetric est mis à jour dans le SwitchListTile

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('userProfile', jsonEncode(_profile.toJson()));
    
    // NOTE: C'est ici que le NutritionCalculator mettrait à jour les objectifs
    // await NutritionCalculator().updateGoals(_profile);

    if (mounted && shouldPop) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Profil mis à jour avec succès!')),
      );
      Navigator.pop(context); // Retour à l'écran précédent
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _weightController.dispose();
    _heightController.dispose();
    _ageController.dispose();
    super.dispose();
  }

  // --- UI ---

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Scaffold(
        appBar: AppBar(title: const Text('Mon Profil')),
        body: const Center(child: CircularProgressIndicator()),
      );
    }
    
    // Détermination des unités pour les labels
    final String weightUnit = _profile.isMetric ? 'kg' : 'lbs';
    final String heightUnit = _profile.isMetric ? 'cm' : 'pouces'; 
    final Color primaryColor = Theme.of(context).colorScheme.primary;

    return Scaffold(
      appBar: AppBar(title: const Text('Mon Profil')),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: <Widget>[
            
            // --- NOUVEAU: CHOIX DU SYSTÈME D'UNITÉ (Impérial vs Métrique) ---
            SwitchListTile(
              title: const Text('Système d\'Unités', style: TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text(_profile.isMetric ? 'Métrique (kg, cm)' : 'Impérial (lbs, pouces)'),
              value: _profile.isMetric,
              onChanged: (bool newValue) {
                setState(() {
                  // Appel de la nouvelle fonction de mise à jour/conversion dans le setState
                  _updateUnitSystem(newValue);
                  // CORRECTION: Sauvegarde immédiate de la préférence d'unité sans navigation
                  _saveUserProfile(shouldPop: false);
                });
              },
              secondary: Icon(Icons.straighten, color: primaryColor),
              activeThumbColor: primaryColor,
              thumbColor: WidgetStateProperty.all(primaryColor),
              trackOutlineColor: WidgetStateProperty.all(primaryColor),
            ),
            const Divider(),

            // Nom
            _buildTextField(
              controller: _nameController,
              label: 'Nom d\'utilisateur',
              keyboardType: TextInputType.name,
              formatters: null, // Pas de formatage spécifique pour le texte
            ),

            // Poids (kg / lbs) - Utilise l'unité dynamique
            _buildTextField(
              controller: _weightController,
              label: 'Poids ($weightUnit)',
              // Pour les décimales, on utilise numberWithOptions(decimal: true)
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              // CORRECTION: Formateur pour accepter les décimales (virgules et points)
              formatters: [
                FilteringTextInputFormatter.allow(RegExp(r'[\d.,]')),
              ],
              validator: (val) => val == null || double.tryParse(val.replaceAll(',', '.')) == null
                  ? 'Entrez un poids valide.'
                  : null,
            ),

            // Grandeur (cm / pouces) - Utilise l'unité dynamique
            _buildTextField(
              controller: _heightController,
              label: 'Grandeur ($heightUnit)',
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              // CORRECTION: Formateur pour accepter les décimales
              formatters: [
                FilteringTextInputFormatter.allow(RegExp(r'[\d.,]')),
              ],
              validator: (val) => val == null || double.tryParse(val.replaceAll(',', '.')) == null
                  ? 'Entrez une grandeur valide.'
                  : null,
            ),

            // Âge
            _buildTextField(
              controller: _ageController,
              label: 'Âge',
              keyboardType: TextInputType.number,
              // CORRECTION: Formateur pour accepter uniquement les chiffres
              formatters: [
                FilteringTextInputFormatter.digitsOnly,
              ],
              validator: (val) => val == null || int.tryParse(val) == null
                  ? 'Entrez un âge valide.'
                  : null,
            ),

            const SizedBox(height: 24),

            // Genre (Dropdown)
            DropdownButtonFormField<Gender>(
              decoration: const InputDecoration(
                labelText: 'Sexe',
                border: OutlineInputBorder(),
              ),
              initialValue: _profile.gender,
              items: Gender.values.map((Gender gender) {
                return DropdownMenuItem<Gender>(
                  value: gender,
                  child: Text(gender == Gender.male ? 'Homme' : 'Femme'),
                );
              }).toList(),
              onChanged: (Gender? newValue) {
                if (newValue != null) {
                  setState(() {
                    _profile.gender = newValue;
                  });
                }
              },
            ),

            const SizedBox(height: 15),

            // Niveau d'Activité (Dropdown)
            DropdownButtonFormField<ActivityLevel>(
              decoration: const InputDecoration(
                labelText: 'Niveau d\'Activité Physique',
                border: OutlineInputBorder(),
              ),
              initialValue: _profile.activityLevel,
              items: ActivityLevel.values.map((ActivityLevel level) {
                return DropdownMenuItem<ActivityLevel>(
                  value: level,
                  // Utilise le service pour afficher les noms clairs
                  child: Text(NutritionCalculator.getActivityName(level)),
                );
              }).toList(),
              onChanged: (ActivityLevel? newValue) {
                if (newValue != null) {
                  setState(() {
                    _profile.activityLevel = newValue;
                  });
                }
              },
            ),

            const SizedBox(height: 20),

            // Objectif (Dropdown)
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(
                labelText: 'Objectif Principal',
                border: OutlineInputBorder(),
              ),
              initialValue: _profile.goal,
              items: _goals.map((String goal) {
                return DropdownMenuItem<String>(value: goal, child: Text(goal));
              }).toList(),
              onChanged: (String? newValue) {
                if (newValue != null) {
                  setState(() {
                    _profile.goal = newValue;
                  });
                }
              },
            ),

            const SizedBox(height: 15),

            // Accès à l'Historique
            ListTile(
              leading: Icon(
                Icons.history,
                color: primaryColor,
              ),
              title: const Text('Voir l\'Historique des Analyses'),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const HistoryScreen(),
                  ),
                );
              },
            ),

            const SizedBox(height: 30),

            // Bouton de Sauvegarde
            ElevatedButton(
              onPressed: () => _saveUserProfile(shouldPop: true),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 15),
                backgroundColor: primaryColor,
                foregroundColor: Colors.white,
              ),
              child: const Text(
                'Sauvegarder le Profil',
                style: TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Fonction utilitaire mise à jour pour accepter les formatters
  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required TextInputType keyboardType,
    List<TextInputFormatter>? formatters, // NOUVEAU: Paramètre optionnel
    String? Function(String?)? validator,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15.0),
      child: TextFormField(
        controller: controller,
        // Utilisation du paramètre formatters
        inputFormatters: formatters,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
        validator:
            validator ??
            (value) {
              if (value == null || value.isEmpty) {
                return 'Ce champ est requis.';
              }
              return null;
            },
      ),
    );
  }
}