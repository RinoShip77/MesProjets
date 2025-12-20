import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:macro_vision/widgets/custom_app_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:macro_vision/models/user_profile.dart';
import 'package:macro_vision/services/database_service.dart';
import 'package:macro_vision/services/nutrition_calculator.dart';
import 'package:macro_vision/utils/l10n_extension.dart';

// 1. DÉFINITION DE L'ÉNUMÉRATION
enum ChartType { bar, line }

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

  // 2. VARIABLE D'ÉTAT POUR LE TYPE DE GRAPHIQUE
  ChartType _selectedChartType = ChartType.bar;

  @override
  void initState() {
    super.initState();
    _loadingFuture = _loadData();
  }

  // TODO: Envoyer cette fonction de un fichier "helpers.dart"
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

  // TODO: Envoyer cette fonction de un fichier "helpers.dart"
  Future<void> _refreshData() async {
    setState(() {
      _loadingFuture = _loadData();
    });
  }

  // TODO: Envoyer cette fonction de un fichier "helpers.dart"
  // 3. WIDGET DU SÉLECTEUR DE GRAPHIQUE
  Widget _buildChartTypeSelector() {
    return Tooltip(
      message: context.l10n.dashboardScreenSelectChartTypeLbl,
      child: ToggleButtons(
        isSelected: ChartType.values
            .map((type) => type == _selectedChartType)
            .toList(),
        onPressed: (int index) {
          setState(() {
            _selectedChartType = ChartType.values[index];
          });
        },
        constraints: const BoxConstraints(minHeight: 36.0, minWidth: 80.0),
        children: [
          Text(context.l10n.dashboardScreenChartTypeOption('bars')),
          Text(context.l10n.dashboardScreenChartTypeOption('lines')),
          ],
      ),
    );
  }

  // TODO: Envoyer cette fonction de un fichier "helpers.dart"
  Widget _buildMacroGoalCard(
    BuildContext context, {
    required String title,
    required double consumed,
    required double goal,
    required String unit,
    int flex = 0,
  }) {
    final progress = goal > 0 ? (consumed / goal).clamp(0.0, 1.0) : 0.0;

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
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 5),

            Text(
              '${consumed.toStringAsFixed(1)} / ${goal.toStringAsFixed(0)} $unit',
              style: Theme.of(context).textTheme.bodyLarge,
            ),

            const SizedBox(height: 8),

            LinearProgressIndicator(value: progress),
          ],
        ),
      ),
    );

    return flex > 0 ? Expanded(flex: flex, child: cardContent) : cardContent;
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: context.l10n.dashboardScreenTitle,
        actions: [
          IconButton(
            tooltip: context.l10n.appRefreshDataLbl,
            icon: const Icon(Icons.refresh),
            onPressed: _refreshData,
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
            return Center(child: Text(context.l10n.appWarningEmptyData));
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  context.l10n.dashboardScreenDailyObjectivesLbl,
                  style: Theme.of(context).textTheme.headlineMedium,
                ),

                const SizedBox(height: 10),

                _buildMacroGoalCard(
                  context,
                  title: context.l10n.dashboardScreenDailyObjectiveLbl('calories'),
                  consumed: _consumedMacros['calories'] ?? 0,
                  goal: _goalMacros['calories'] ?? 0,
                  unit: 'cal',
                ),

                const SizedBox(height: 10),

                Row(
                  children: [
                    _buildMacroGoalCard(
                      context,
                      title: context.l10n.dashboardScreenDailyObjectiveLbl('protein'),
                      consumed: _consumedMacros['protein'] ?? 0,
                      goal: _goalMacros['protein'] ?? 0,
                      unit: 'g',
                      flex: 1,
                    ),

                    const SizedBox(width: 10),

                    _buildMacroGoalCard(
                      context,
                      title: context.l10n.dashboardScreenDailyObjectiveLbl('totalFat'),
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
                  title: context.l10n.dashboardScreenDailyObjectiveLbl('totalCarbohydrate'),
                  consumed: _consumedMacros['totalCarbohydrates'] ?? 0,
                  goal: _goalMacros['totalCarbohydrates'] ?? 0,
                  unit: 'g',
                ),

                Divider(),

                Text(
                  context.l10n.appSummaryLbl('weekly'),
                  style: Theme.of(context).textTheme.headlineMedium,
                ),

                const SizedBox(height: 10),

                // UTILISATION DU SÉLECTEUR
                _buildChartTypeSelector(),

                const SizedBox(height: 20),

                // PASSAGE DE LA SÉLECTION AU GRAPHIQUE
                WeeklyChart(chartType: _selectedChartType),
              ],
            ),
          );
        },
      ),
    );
  }

}

// --- Widget du Graphique Hebdomadaire ---

class WeeklyChart extends StatelessWidget {
  final ChartType chartType;
  const WeeklyChart({required this.chartType, super.key});

  // TODO: Envoyer cette fonction de un fichier "helpers.dart"
  // --- GRAPHIQUE EN LIGNES ---
  Widget _buildLineChart(
    BuildContext context,
    List<DailySummary> data,
    double maxY,
    Color primaryColor,
  ) {
    return LineChart(
      LineChartData(
        minY: 0,
        maxY: maxY,
        lineTouchData: LineTouchData(
          handleBuiltInTouches: true,
          touchTooltipData: LineTouchTooltipData(
            getTooltipColor: (spot) => primaryColor,
            tooltipBorderRadius: BorderRadius.all(Radius.circular(8.0)),
            tooltipPadding: EdgeInsets.all(8.0),
            tooltipMargin: 10,
            getTooltipItems: (List<LineBarSpot> lineBarsSpot) {
              return lineBarsSpot.map((spot) {
                final day = data[spot.x.toInt()].dayName;
                final calories = spot.y;
                return LineTooltipItem(
                  '$day\n',
                  TextStyle(
                    color: Colors.black87,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                  children: <TextSpan>[
                    TextSpan(
                      text: '${calories.toStringAsFixed(0)} cal',
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                );
              }).toList();
            },
          ),
        ),
        titlesData: FlTitlesData(
          show: true,
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
              interval: maxY / 4,
              getTitlesWidget: (value, meta) {
                return SideTitleWidget(
                  meta: meta,
                  space: 4,
                  child: Text(
                    '${value.toInt()}',
                    style: const TextStyle(fontSize: 10),
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
        gridData: const FlGridData(show: true, drawVerticalLine: false),
        borderData: FlBorderData(
          show: true,
          border: Border(
            bottom: BorderSide(color: primaryColor.withAlpha(75), width: 1),
            left: BorderSide(color: primaryColor.withAlpha(75), width: 1),
          ),
        ),
        lineBarsData: [
          LineChartBarData(
            spots: data.asMap().entries.map((entry) {
              final index = entry.key;
              final summary = entry.value;
              return FlSpot(index.toDouble(), summary.calories);
            }).toList(),
            isCurved: true,
            color: primaryColor, // Couleur de la ligne
            dotData: const FlDotData(
              show: true,
            ), // Afficher les points sur la ligne
            belowBarData: BarAreaData(
              show: true,
              color: primaryColor.withAlpha(70),
            ),
          ),
        ],
      ),
    );
  }

  // TODO: Envoyer cette fonction de un fichier "helpers.dart"
  // --- GRAPHIQUE À BARRES ---
  Widget _buildBarChart(
    BuildContext context,
    List<DailySummary> data,
    double maxY,
    Color primaryColor,
  ) {
    return BarChart(
      BarChartData(
        alignment: BarChartAlignment.spaceAround,
        maxY: maxY,
        barTouchData: BarTouchData(
          handleBuiltInTouches: true,
          touchTooltipData: BarTouchTooltipData(
            getTooltipColor: (spot) => primaryColor,
            tooltipBorderRadius: BorderRadius.all(Radius.circular(8.0)),
            tooltipPadding: EdgeInsets.all(8.0),
            tooltipMargin: 10,
            getTooltipItem: (group, groupIndex, rod, rodIndex) {
              final day = data[group.x.toInt()].dayName;
              final calories = rod.toY;
              return BarTooltipItem(
                '$day\n',
                TextStyle(
                  color: Colors.black87,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
                children: <TextSpan>[
                  TextSpan(
                    text: '${calories.toStringAsFixed(0)} cal',
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              );
            },
          ),
        ),
        titlesData: FlTitlesData(
          show: true,
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
              interval: 500,
              getTitlesWidget: (value, meta) {
                if (value % 500 != 0 && value != 0) {
                  return Container();
                }

                return SideTitleWidget(
                  meta: meta,
                  space: 4,
                  child: Text(
                    '${value.toInt()}',
                    style: const TextStyle(fontSize: 10),
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
            bottom: BorderSide(color: primaryColor.withAlpha(75), width: 1),
            left: BorderSide(color: primaryColor.withAlpha(75), width: 1),
          ),
        ),
        barGroups: data.asMap().entries.map((entry) {
          final index = entry.key;
          final summary = entry.value;
          return BarChartGroupData(
            x: index,
            barRods: [
              BarChartRodData(
                toY: summary.calories,
                color: primaryColor,
                width: 18,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(8),
                  topRight: Radius.circular(8),
                ),
                backDrawRodData: BackgroundBarChartRodData(
                  show: true,
                  toY: maxY,
                  color: primaryColor.withAlpha(50),
                ),
              ),
            ],
          );
        }).toList(),
      ),
    );
  }

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

        if (data.isEmpty) {
          return SizedBox(
            height: 250,
            child: Center(
              child: Text(context.l10n.dashboardScreenNotEnoughDataLbl),
            ),
          );
        }

        double maxCalories = data
            .map((e) => e.calories)
            .reduce((a, b) => a > b ? a : b);
        final double maxY = maxCalories > 0 ? (maxCalories + 500) : 2500;

        return SizedBox(
          height: 250,
          child: chartType == ChartType.bar
              ? _buildBarChart(
                  context,
                  data,
                  maxY,
                  Theme.of(context).colorScheme.primary,
                )
              : _buildLineChart(
                  context,
                  data,
                  maxY,
                  Theme.of(context).colorScheme.primary,
                ),
        );
      },
    );
  }

}
