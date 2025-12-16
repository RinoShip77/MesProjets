import 'dart:convert'; // Nécessaire pour décoder le UserProfile
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:macro_vision/helpers/helpers.dart';
import 'package:macro_vision/models/nutritional_facts_entry.dart';
import 'package:macro_vision/screens/camera_screen.dart';
import 'package:macro_vision/screens/dashboard_screen.dart';
import 'package:macro_vision/widgets/analysis_list.dart';
import 'package:macro_vision/widgets/custom_app_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Imports nécessaires pour le calcul des données
import 'package:macro_vision/models/user_profile.dart';
import 'package:macro_vision/services/database_service.dart';
import 'package:macro_vision/services/nutrition_calculator.dart';
// Pour le guide

// Convertir en StatefulWidget
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // --- VARIABLES POUR LE RÉSUMÉ QUOTIDIEN ---
  bool _isLoadingStats = true;
  UserProfile _profile = UserProfile();
  Map<String, double> _goalMacros = {};
  Map<String, double> _consumedMacros = {
    'calories': 0.0,
    'protein': 0.0,
    'totalFat': 0.0,
    'totalCarbohydrates': 0.0,
  };

  @override
  void initState() {
    super.initState();
    _loadDailyStats(); // Charger les stats au démarrage
  }

  // =========================================================================
  // LOGIQUE DE CHARGEMENT DES DONNÉES (RÉSUMÉ QUOTIDIEN)
  // =========================================================================
  Future<void> _loadDailyStats() async {
    setState(() {
      _isLoadingStats = true;
    });

    try {
      // 1. Charger le profil utilisateur pour les objectifs
      final prefs = await SharedPreferences.getInstance();
      final userJson = prefs.getString('userProfile');
      if (userJson != null) {
        _profile = UserProfile.fromJson(jsonDecode(userJson));
      }

      // 2. Calculer les objectifs basés sur le profil
      _goalMacros = NutritionCalculator.calculateMacroGoals(_profile);

      // 3. Récupérer l'historique d'AUJOURD'HUI
      final today = DateTime.now();
      final startOfDay = DateTime(
        today.year,
        today.month,
        today.day,
      ).millisecondsSinceEpoch;

      final history = await DatabaseService().getHistoryForDay(startOfDay);

      // 4. Faire la somme des macros consommées
      double cal = 0, pro = 0, totalFat = 0, totalCarbs = 0;
      for (var entry in history) {
        cal += entry.calories;
        pro += entry.protein;
        totalFat += entry.totalFat;
        totalCarbs += entry.totalCarbohydrates;
      }

      if (mounted) {
        setState(() {
          _consumedMacros = {
            'calories': cal,
            'protein': pro,
            'totalFat': totalFat,
            'totalCarbohydrates': totalCarbs,
          };
          _isLoadingStats = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoadingStats = false;
        });
        // Optionnel: Gérer l'erreur silencieusement ou via log
      }
    }
  }

  // Cette méthode est appelée lors de la navigation vers un autre écran
  // Elle attend le retour et recharge les données (pour mettre à jour les barres)
  Future<void> _navigateAndRefresh(BuildContext context, Widget screen) async {
    await Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (context) => screen));
    // Au retour, on recharge les stats
    _loadDailyStats();
  }

  // =========================================================================
  // WIDGETS UI POUR LE RÉSUMÉ (ROUE + CARTES)
  // =========================================================================
  // 1. Widget pour une petite carte de Macro (Carrée avec barre de progression)
  Widget _buildMacroCardInfo(
    BuildContext context, {
    required String label,
    required double value,
    required double max,
    required Color color,
    required IconData icon,
  }) {
    final double progress = max > 0 ? (value / max).clamp(0.0, 1.0) : 0.0;

    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: color.withAlpha(
            75,
          ), // Fond très léger de la couleur de la macro
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: color.withAlpha(50)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, size: 16, color: color),
                const SizedBox(width: 4),
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: color.withAlpha(200),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 8),

            Text(
              '${value.toInt()}g',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),

            Text('sur ${max.toInt()} g', style: TextStyle(fontSize: 10)),

            const SizedBox(height: 8),

            LinearProgressIndicator(
              value: progress,
              minHeight: 6,
              borderRadius: BorderRadius.circular(3),
            ),
          ],
        ),
      ),
    );
  }

  // 2. Widget de la Roue des Calories
  Widget _buildCalorieWheel(double consumed, double goal, Color primaryColor) {
    final double progress = goal > 0 ? (consumed / goal).clamp(0.0, 1.0) : 0.0;

    return Column(
      children: [
        SizedBox(
          height: 160,
          width: 160,
          child: Stack(
            fit: StackFit.expand,
            children: [
              // Roue de progression (couleur primaire)
              CircularProgressIndicator(
                color: primaryColor,
                value: progress,
                strokeWidth: 12,
                strokeCap: StrokeCap.round,
                trackGap: 6.0,
                year2023: false,
              ),
              // Texte au centre
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.local_fire_department_rounded,
                    size: 28,
                    color: Colors.orange,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    consumed.toInt().toString(),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 28,
                    ),
                  ),
                  Text("sur ${goal.toInt()}", style: TextStyle(fontSize: 12)),
                  const Text(
                    "Cal",
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  // 3. Widget principal de la carte de résumé (Conteneur global)
  Widget _buildDailySummaryCard() {
    if (_isLoadingStats) {
      return const SizedBox(
        height: 250,
        child: Center(child: CircularProgressIndicator()),
      );
    }

    final double calConsumed = _consumedMacros['calories'] ?? 0;
    final double calGoal = _goalMacros['calories'] ?? 2000;
    final Color primaryColor = Theme.of(context).colorScheme.primary;

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            // A. LA ROUE DES CALORIES
            _buildCalorieWheel(calConsumed, calGoal, primaryColor),

            const SizedBox(height: 30),

            // B. LES 3 CARTES DE MACROS (Alignées horizontalement)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildMacroCardInfo(
                  context,
                  label: "Glu",
                  value: _consumedMacros['totalCarbohydrates'] ?? 0,
                  max: _goalMacros['totalCarbohydrates'] ?? 0,
                  color: Colors.orange,
                  icon: Icons.grain_rounded,
                ),

                const SizedBox(width: 10),

                _buildMacroCardInfo(
                  context,
                  label: "Pro",
                  value: _consumedMacros['protein'] ?? 0,
                  max: _goalMacros['protein'] ?? 0,
                  color: Colors.green, // Ou utilisez Theme colors
                  icon: Icons.fitness_center_rounded,
                ),

                const SizedBox(width: 10),

                _buildMacroCardInfo(
                  context,
                  label: "Lip",
                  value: _consumedMacros['totalFat'] ?? 0,
                  max: _goalMacros['totalFat'] ?? 0,
                  color: Colors.redAccent,
                  icon: Icons.water_drop_rounded,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Nouvelle méthode pour le filtrage
  Future<List<NutritionalFactsEntry>> _getTodayHistory() async {
    // 1. Récupérer l'historique complet
    final allHistory = await DatabaseService().getHistory();

    // 2. Filtrer les résultats pour 'aujourd'hui'
    final now = DateTime.now();

    return allHistory.where((entry) {
      final entryDate = DateTime.fromMillisecondsSinceEpoch(entry.timestamp);
      return entryDate.year == now.year &&
          entryDate.month == now.month &&
          entryDate.day == now.day;
    }).toList();
  }

  // =========================================================================
  // WIDGET BUILD
  // =========================================================================
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'MacroVision', backButton: false),
      body: Stack(
        children: [
          // Utilisation de SingleChildScrollView pour éviter l'overflow si l'écran est petit
          SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            child: Center(
              child: Column(
                children: [
                  Text(
                    'Bienvenue sur MacroVision',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    child: Column(
                      children: [
                        // NOUVELLE CARTE DE PROGRESSION ---
                        _buildDailySummaryCard(),

                        const SizedBox(height: 10),

                        AnalysisList(
                          // Appel direct
                          historyFuture: _getTodayHistory(), // Le Future filtré
                          compactMode:
                              true, // Active le mode compact et le scroll interne
                        ),
                      ],
                    ),
                  ),

                  // Bouton vers le Tableau de Bord
                  Tooltip(
                    message: 'Voir le tableau de bord.',
                    child: OutlinedButton.icon(
                      icon: const Icon(Icons.bar_chart_rounded),
                      label: const Text('Détails complets'),
                      onPressed: () =>
                          _navigateAndRefresh(context, DashboardScreen()),
                    ),
                  ),

                  const SizedBox(height: 15),

                  // Bouton principal pour la caméra
                  Tooltip(
                    message: 'Commencer l\'analyse.',
                    child: ElevatedButton.icon(
                      icon: const Icon(Icons.camera_enhance_rounded),
                      label: const Text('Analyser un repas'),
                      onPressed: () =>
                          _navigateAndRefresh(context, CameraScreen()),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
