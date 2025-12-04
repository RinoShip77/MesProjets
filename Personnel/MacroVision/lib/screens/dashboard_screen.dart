// lib/screens/dashboard_screen.dart

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';

import 'package:macro_vision/models/user_profile.dart';
import 'package:macro_vision/services/database_service.dart';
import 'package:macro_vision/services/nutrition_calculator.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  UserProfile _profile = UserProfile();
  Map<String, double> _goalMacros = {};
  Map<String, double> _consumedMacros = {
    'calories': 0.0,
    'protein': 0.0,
    'totalFat': 0.0,
    'totalCarbohydrates': 0.0,
  };

  late Future<void> _loadingFuture;

  @override
  void initState() {
    super.initState();
    _loadingFuture = _loadData();
  }

  Future<void> _loadData() async {
    final prefs = await SharedPreferences.getInstance();
    final userJson = prefs.getString('userProfile');
    if (userJson != null) {
      _profile = UserProfile.fromJson(jsonDecode(userJson));
    }

    _goalMacros = NutritionCalculator.calculateMacroGoals(_profile);

    final today = DateTime.now();
    final startOfDay = DateTime(
      today.year,
      today.month,
      today.day,
    ).millisecondsSinceEpoch;

    final history = await DatabaseService().getHistoryForDay(startOfDay);

    double cal = 0, pro = 0, totalFat = 0, totalCarbohydrates = 0;
    for (var entry in history) {
      cal += entry.calories;
      pro += entry.protein;
      totalFat += entry.totalFat;
      totalCarbohydrates += entry.totalCarbohydrates;
    }

    _consumedMacros = {
      'calories': cal,
      'protein': pro,
      'totalFat': totalFat,
      'totalCarbohydrates': totalCarbohydrates,
    };

    if (mounted) {
      setState(() {});
    }
  }

  Future<void> _refreshData() async {
    setState(() {
      _loadingFuture = _loadData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tableau de Bord'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _refreshData,
            tooltip: 'Rafraîchir les données',
          ),
        ],
      ),
      body: FutureBuilder(
        future: _loadingFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Erreur: ${snapshot.error}'));
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Objectifs du Jour',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(height: 10),
                _buildMacroGoalCard(
                  context,
                  title: 'Calories',
                  consumed: _consumedMacros['calories'] ?? 0,
                  goal: _goalMacros['calories'] ?? 0,
                  unit: 'kcal',
                ),
                const SizedBox(height: 20),

                Row(
                  children: [
                    _buildMacroGoalCard(
                      context,
                      title: 'Protéines',
                      consumed: _consumedMacros['protein'] ?? 0,
                      goal: _goalMacros['protein'] ?? 0,
                      unit: 'g',
                      flex: 1,
                    ),
                    const SizedBox(width: 10),
                    _buildMacroGoalCard(
                      context,
                      title: 'Lipides',
                      consumed: _consumedMacros['totalFat'] ?? 0,
                      goal: _goalMacros['totalFat'] ?? 0,
                      unit: 'g',
                      flex: 1,
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                _buildMacroGoalCard(
                  context,
                  title: 'Glucides',
                  consumed: _consumedMacros['totalCarbohydrates'] ?? 0,
                  goal: _goalMacros['totalCarbohydrates'] ?? 0,
                  unit: 'g',
                ),
                const Divider(height: 40),

                Text(
                  'Suivi Hebdomadaire (Calories)',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(height: 10),
                WeeklyChart(),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildMacroGoalCard(
    BuildContext context, {
    required String title,
    required double consumed,
    required double goal,
    required String unit,
    int flex = 0,
  }) {
    final progress = goal > 0 ? (consumed / goal).clamp(0.0, 1.0) : 0.0;
    final Color color = Theme.of(context).primaryColor;

    final cardContent = Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              '${consumed.toStringAsFixed(1)} / ${goal.toStringAsFixed(0)} $unit',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            LinearProgressIndicator(
              value: progress,
              backgroundColor: Colors.grey[300],
              color: color,
            ),
          ],
        ),
      ),
    );

    return flex > 0 ? Expanded(flex: flex, child: cardContent) : cardContent;
  }
}

// --- Widget du Graphique Hebdomadaire ---

class WeeklyChart extends StatelessWidget {
  const WeeklyChart({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<DailySummary>>(
      future: DatabaseService().getWeeklySummary(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SizedBox(
            height: 250,
            child: Center(child: CircularProgressIndicator()),
          );
        }

        final data = snapshot.data ?? [];
        final Color primaryColor = Theme.of(context).primaryColor;

        if (data.isEmpty) {
          return const SizedBox(
            height: 250,
            child: Center(
              child: Text('Historique insuffisant pour le graphique.'),
            ),
          );
        }

        double maxCalories = data
            .map((e) => e.calories)
            .reduce((a, b) => a > b ? a : b);
        
        // Fixe la hauteur maximale à au moins 2500 pour le test si les valeurs sont très petites
        final double maxY = maxCalories > 0
            ? (maxCalories + 500)
            : 2500; 

        return SizedBox(
          height: 250,
          child: BarChart(
            BarChartData(
              alignment: BarChartAlignment.spaceAround,
              maxY: maxY,
              barTouchData: BarTouchData(enabled: false),
              titlesData: FlTitlesData(
                show: true,
                // Simplification maximale pour s'assurer que les titres d'axe ne bloquent rien
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    getTitlesWidget: (value, meta) {
                      return SideTitleWidget(
                        meta: meta,
                        space: 4,
                        child: Text(data[value.toInt()].dayName),
                      );
                    },
                    interval: 1,
                  ),
                ),
                leftTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    reservedSize: 40,
                    interval: maxY / 4, // Laisse FlChart choisir 4 intervalles
                    getTitlesWidget: (value, meta) {
                       return SideTitleWidget(
                        meta: meta,
                        space: 4,
                        child: Text(
                          '${value.toInt()}',
                          style: const TextStyle(
                            fontSize: 10,
                            color: Colors.grey,
                          ),
                        ),
                      );
                    },
                  ),
                ),
                topTitles: const AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
                rightTitles: const AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
              ),
              gridData: const FlGridData(show: false),
              borderData: FlBorderData(
                show: true,
                border: Border(
                  bottom: BorderSide(
                    color: Colors.grey.withOpacity(0.5),
                    width: 1,
                  ),
                  left: BorderSide(
                    color: Colors.grey.withOpacity(0.5),
                    width: 1,
                  ),
                ),
              ),
              barGroups: data.asMap().entries.map((entry) {
                final index = entry.key;
                final summary = entry.value;
                
                // TEST CRITIQUE: Force une hauteur minimale (500) à la barre si la valeur est > 0.
                final double barHeight = summary.calories > 0 
                  ? summary.calories.clamp(500.0, double.infinity) 
                  : 0.0;
                
                return BarChartGroupData(
                  x: index,
                  barRods: [
                    BarChartRodData(
                      toY: barHeight, // Utilise la hauteur forcée pour le test
                      color: primaryColor.withOpacity(0.8),
                      width: 18,
                      // Rendre le design simple pour éviter les erreurs de rendu
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(4),
                        topRight: Radius.circular(4),
                      ),
                      // ENLÈVE backDrawRodData POUR SIMPLIFIER EN CAS DE CONFLIT
                      // backDrawRodData: BackgroundBarChartRodData( 
                      //   show: true,
                      //   toY: maxY,
                      //   color: Colors.grey[200],
                      // ), 
                    ),
                  ],
                );
              }).toList(),
            ),
          ),
        );
      },
    );
  }
}