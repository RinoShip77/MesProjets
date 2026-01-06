import 'dart:convert'; // Nécessaire pour décoder le UserProfile
import 'package:flutter/material.dart';
import 'package:macro_vision/models/nutritional_facts_entry.dart';
import 'package:macro_vision/screens/camera_screen.dart';
import 'package:macro_vision/widgets/analysis_list.dart';
import 'package:macro_vision/widgets/custom_app_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Imports nécessaires pour le calcul des données
import 'package:macro_vision/models/user_profile.dart';
import 'package:macro_vision/services/database_service.dart';
import 'package:macro_vision/services/nutrition_calculator.dart';
import 'package:macro_vision/utils/l10n_extension.dart';
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
                Expanded(
                  child: FittedBox(
                    fit: BoxFit
                        .scaleDown, // Shrinks the text only if it's too large
                    child: Row(
                      children: [
                        Icon(icon, size: 16, color: color),
                        const SizedBox(width: 4),
                        Text(
                          label,
                          style: TextStyle(
                            fontSize: Theme.of(
                              context,
                            ).textTheme.bodyLarge!.fontSize,
                            fontWeight: FontWeight.bold,
                            color: color.withAlpha(200),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 8),

            Text(
              '${value.toInt()} g',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),

            Text(
              context.l10n.homeScreenDailySummaryStatLbl(max.toInt()),
              style: TextStyle(fontSize: 10),
            ),

            const SizedBox(height: 8),

            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Theme.of(context).colorScheme.inversePrimary,
                  width: 1,
                ), // The border
                borderRadius: BorderRadius.circular(10), // Optional rounding
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(
                  8,
                ), // Matches border rounding
                child: LinearProgressIndicator(value: progress, minHeight: 8),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 2. Widget de la Roue des Calories
  Widget _buildCalorieWheel(double consumed, double goal) {
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
                color: Theme.of(context).colorScheme.primary,
                backgroundColor: Theme.of(context).colorScheme.primaryContainer,
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

                  Text(
                    context.l10n.homeScreenDailySummaryStatLbl(goal.toInt()),
                    style: TextStyle(fontSize: 12),
                  ),

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

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            // A. LA ROUE DES CALORIES
            _buildCalorieWheel(calConsumed, calGoal),

            const SizedBox(height: 30),

            // B. LES 3 CARTES DE MACROS (Alignées horizontalement)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildMacroCardInfo(
                  context,
                  label: context.l10n.homeScreenDailySummaryMacroCardLbl(
                    'carbohydrate',
                  ),
                  value: _consumedMacros['totalCarbohydrates'] ?? 0,
                  max: _goalMacros['totalCarbohydrates'] ?? 0,
                  color: Colors.orange,
                  icon: Icons.grain_rounded,
                ),

                const SizedBox(width: 10),

                _buildMacroCardInfo(
                  context,
                  label: context.l10n.homeScreenDailySummaryMacroCardLbl(
                    'protein',
                  ),
                  value: _consumedMacros['protein'] ?? 0,
                  max: _goalMacros['protein'] ?? 0,
                  color: Colors.green, // Ou utilisez Theme colors
                  icon: Icons.fitness_center_rounded,
                ),

                const SizedBox(width: 10),

                _buildMacroCardInfo(
                  context,
                  label: context.l10n.homeScreenDailySummaryMacroCardLbl('fat'),
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
      appBar: CustomAppBar(title: 'MacroVision'),
      body: Stack(
        children: [
          // Utilisation de SingleChildScrollView pour éviter l'overflow si l'écran est petit
          SingleChildScrollView(
            padding: EdgeInsets.symmetric(vertical: 30),
            child: Center(
              child: Column(
                children: [
                  Text(
                    textAlign: TextAlign.center,
                    context.l10n.homeScreenWelcomeLbl,
                    style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    child: Card(
                      child: Column(
                        children: [
                          // --- En-tête de la carte ---
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 16.0,
                              left: 16.0,
                              right: 16.0,
                            ),
                            child: Text(
                              context.l10n.appSummaryLbl('daily'),
                              style: Theme.of(context).textTheme.titleLarge
                                  ?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.primary,
                                  ),
                            ),
                          ),

                          const Divider(height: 16),

                          // NOUVELLE CARTE DE PROGRESSION ---
                          _buildDailySummaryCard(),

                          const SizedBox(height: 10),

                          AnalysisList(
                            // Appel direct
                            historyFuture:
                                _getTodayHistory(), // Le Future filtré
                            compactMode:
                                true, // Active le mode compact et le scroll interne
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Bouton vers le Tableau de Bord
                  // Tooltip(
                  //   message: 'Voir le tableau de bord.',
                  //   child: OutlinedButton.icon(
                  //     icon: const Icon(Icons.bar_chart_rounded),
                  //     label: const Text('Détails complets'),
                  //     onPressed: () =>
                  //         _navigateAndRefresh(context, DashboardScreen()),
                  //   ),
                  // ),

                  // const SizedBox(height: 15),

                  // Bouton principal pour la caméra
                  // Tooltip(
                  //   message: context.l10n.homeScreenStartAnalysisBtn,
                  //   child: ElevatedButton.icon(
                  //     icon: const Icon(Icons.camera_enhance_rounded),
                  //     label: Text(context.l10n.homeScreenStartAnalysisBtn),
                  //     onPressed: () =>
                  //         _navigateAndRefresh(context, CameraScreen(mode: CameraMode.mealAnalysis)),
                  //   ),
                  // ),

                  // // Bouton principal pour le scanner de valeurs nutritives
                  // Tooltip(
                  //   message: context.l10n.homeScreenStartAnalysisBtn,
                  //   child: ElevatedButton.icon(
                  //     icon: const Icon(Icons.document_scanner_rounded),
                  //     label: Text('Facts label scanner'),
                  //     onPressed: () =>
                  //         _navigateAndRefresh(context, CameraScreen(mode: CameraMode.labelScanner)),
                  //   ),
                  // ),

                  // // Bouton principal pour le scanner de code barres
                  // Tooltip(
                  //   message: context.l10n.homeScreenStartAnalysisBtn,
                  //   child: ElevatedButton.icon(
                  //     icon: const Icon(Icons.qr_code_scanner_rounded),
                  //     label: Text('Barcode scanner'),
                  //     onPressed: () =>
                  //         _navigateAndRefresh(context, CameraScreen(mode: CameraMode.barcodeScanner)),
                  //   ),
                  // ),
                  // Section 1 : Analyse Repas
                ],
              ),
            ),
          ),
        ],
      ),
      // floatingActionButtonLocation: ExpandableFab.location,
      // floatingActionButton: ExpandableFab(
      //   type: ExpandableFabType.fan,
      //   pos: ExpandableFabPos.center,
      //   fanAngle: 180,
      //   distance: 75,
      //   overlayStyle: ExpandableFabOverlayStyle(
      //     color: Theme.of(context).colorScheme.surface.withAlpha(150),
      //   ),
      //   openButtonBuilder: RotateFloatingActionButtonBuilder(
      //     child: const Icon(Icons.camera_enhance_rounded),
      //     fabSize: ExpandableFabSize.regular,
      //   ),
      //   closeButtonBuilder: DefaultFloatingActionButtonBuilder(
      //     child: const Icon(Icons.close),
      //     fabSize: ExpandableFabSize.small,
      //   ),
      //   children: [
      //     // Section 1 : Analyse Repas
      //     FloatingActionButton(
      //       heroTag: "mealAnalysisBtn",
      //       tooltip: "Analyse de repas",
      //       child: const Icon(Icons.restaurant),
      //       onPressed: () =>
      //           _navigateToCamera(context, CameraMode.mealAnalysis),
      //     ),

      //     // Section 2 : Scan Étiquette
      //     FloatingActionButton(
      //       heroTag: "labelAnalysisBtn",
      //       tooltip: "Analyse d'étiquette",
      //       child: const Icon(Icons.description),
      //       onPressed: () => _navigateToCamera(context, CameraMode.labelScanner),
      //     ),

      //     // Section 3 : Scan Code-barres
      //     FloatingActionButton(
      //       heroTag: "barcodeAnalysisBtn",
      //       tooltip: "Lire un code barre",
      //       child: const Icon(Icons.qr_code_scanner),
      //       onPressed: () => _navigateToCamera(context, CameraMode.barcodeScanner),
      //     ),
      //   ],
      // ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: SizedBox(
        width: MediaQuery.of(context).size.width * 0.9,
        child: _buildSegmentedActionButton(context),
      ),
    );
  }

  void _navigateToCamera(BuildContext context, CameraMode mode) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CameraScreen(mode: mode)),
    );
  }

  Widget _buildSegmentedActionButton(BuildContext context) {
    return Container(
      height: 60,
      margin: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceVariant,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Theme.of(context).colorScheme.outline),
      ),
      child: Row(
        children: [
          // Section 1 : Analyse Repas
          Expanded(
            child: _buildSegmentItem(
              context,
              icon: Icons.restaurant,
              label: "Repas",
              onTap: () => _navigateToCamera(context, CameraMode.mealAnalysis),
            ),
          ),
          _buildVerticalDivider(context),

          // Section 2 : Scan Étiquette
          Expanded(
            child: _buildSegmentItem(
              context,
              icon: Icons.description,
              label: "Étiquette",
              onTap: () => _navigateToCamera(context, CameraMode.labelScanner),
            ),
          ),
          _buildVerticalDivider(context),

          // Section 3 : Scan Code-barres
          Expanded(
            child: _buildSegmentItem(
              context,
              icon: Icons.qr_code_scanner,
              label: "Code",
              onTap: () =>
                  _navigateToCamera(context, CameraMode.barcodeScanner),
            ),
          ),
        ],
      ),
    );
  }

  // Helper pour chaque section
  Widget _buildSegmentItem(
    BuildContext context, {
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: Theme.of(context).colorScheme.primary),
          Text(
            label,
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  // Séparateur entre les boutons
  Widget _buildVerticalDivider(BuildContext context) {
    return VerticalDivider(
      width: 1,
      thickness: 1,
      indent: 12,
      endIndent: 12,
      color: Theme.of(context).colorScheme.outline.withOpacity(0.5),
    );
  }
}
