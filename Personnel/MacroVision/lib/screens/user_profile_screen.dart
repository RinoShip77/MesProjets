// lib/screens/user_profile_screen.dart

import 'dart:convert';
import 'package:flutter/material.dart';
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

  @override
  void initState() {
    super.initState();
    _loadUserProfile();
  }

  // --- LOGIQUE DE PERSISTANCE ---

  Future<void> _loadUserProfile() async {
    final prefs = await SharedPreferences.getInstance();
    final userJson = prefs.getString('userProfile');

    if (userJson != null) {
      _profile = UserProfile.fromJson(jsonDecode(userJson));
    } else {
      _profile = UserProfile(); // Valeurs par défaut
    }

    _nameController = TextEditingController(text: _profile.name);
    _weightController = TextEditingController(
      text: _profile.weight.toStringAsFixed(1),
    );
    _heightController = TextEditingController(
      text: _profile.height.toStringAsFixed(0),
    );
    _ageController = TextEditingController(text: _profile.age.toString());

    setState(() {
      _isLoading = false;
    });
  }

  Future<void> _saveUserProfile() async {
    if (_formKey.currentState!.validate()) {
      _profile.name = _nameController.text;
      _profile.weight = double.tryParse(_weightController.text) ?? 0.0;
      _profile.height = double.tryParse(_heightController.text) ?? 0.0;
      _profile.age = int.tryParse(_ageController.text) ?? 0;

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('userProfile', jsonEncode(_profile.toJson()));

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Profil mis à jour avec succès!')),
        );
        Navigator.pop(context); // Retour à l'écran précédent
      }
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

    return Scaffold(
      appBar: AppBar(title: const Text('Mon Profil')),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: <Widget>[
            // Nom
            _buildTextField(
              controller: _nameController,
              label: 'Nom d\'utilisateur',
              keyboardType: TextInputType.name,
            ),

            // Poids (kg)
            _buildTextField(
              controller: _weightController,
              label: 'Poids (kg)',
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              validator: (val) => val == null || double.tryParse(val) == null
                  ? 'Entrez un poids valide.'
                  : null,
            ),

            // Grandeur (cm)
            _buildTextField(
              controller: _heightController,
              label: 'Grandeur (cm)',
              keyboardType: TextInputType.number,
              validator: (val) => val == null || int.tryParse(val) == null
                  ? 'Entrez une grandeur valide.'
                  : null,
            ),

            // Âge
            _buildTextField(
              controller: _ageController,
              label: 'Âge',
              keyboardType: TextInputType.number,
              validator: (val) => val == null || int.tryParse(val) == null
                  ? 'Entrez un âge valide.'
                  : null,
            ),

            const SizedBox(height: 15),

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
                setState(() {
                  _profile.gender = newValue!;
                });
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
                  // Utilise le service pour afficher les noms clairs (doit être importé)
                  child: Text(NutritionCalculator.getActivityName(level)),
                );
              }).toList(),
              onChanged: (ActivityLevel? newValue) {
                setState(() {
                  _profile.activityLevel = newValue!;
                });
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
                setState(() {
                  _profile.goal = newValue!;
                });
              },
            ),

            const SizedBox(height: 15),

            // NOUVEL ÉLÉMENT : Accès à l'Historique
            ListTile(
              leading: Icon(
                Icons.history,
                color: Theme.of(context).colorScheme.primary,
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
              onPressed: _saveUserProfile,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 15),
                backgroundColor: Theme.of(context).primaryColor,
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

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required TextInputType keyboardType,
    String? Function(String?)? validator,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15.0),
      child: TextFormField(
        controller: controller,
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
