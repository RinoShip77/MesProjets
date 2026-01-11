import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:macro_vision/helpers/helpers.dart';
import 'package:macro_vision/models/nutritional_facts_entry.dart';
import 'package:macro_vision/screens/camera_screen.dart';
import 'package:macro_vision/widgets/analysis_list.dart';
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
  // 1. Default to Today
  DateTime _selectedDate = DateTime.now();
  int _currentWaterMl = 0;

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

    // 1. Fetch Food history
    final mealsLogs = await DatabaseService().getHistoryForDay(
      getStartOfDayTimestamp(_selectedDate),
    );

    // 2. Fetch Water history
    final waterLogs = await DatabaseService().getWaterIntake(
      getStartOfDayTimestamp(_selectedDate),
    );

    double cal = 0, pro = 0, totalFat = 0, totalCarbohydrates = 0;
    for (var entry in mealsLogs) {
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
      setState(() {
        _currentWaterMl = waterLogs;
      });
    }
  }

  // 3. The Picker Logic
  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2024), // Set a reasonable start limit
      lastDate: DateTime.now(), // Don't allow future logging
      builder: (context, child) {
        // Optional: Wrap in a Theme to match your app colors if needed
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: Theme.of(context).colorScheme, // Use app scheme
          ),
          child: child!,
        );
      },
    );

    if (picked != null && picked != _selectedDate) {
      _loadData();
      setState(() {
        _selectedDate = picked;
        // The UI will rebuild, and the FutureBuilder will re-fetch
        // using the new _selectedDate automatically.
      });
    }
  }

  Future<void> updateWater(int amountMl) async {
    int newValue = _currentWaterMl + amountMl;
    if (newValue < 0) newValue = 0; // Safety check

    setState(() {
      _currentWaterMl = newValue;
    });

    // Save to DB (assuming your DB service can accept any integer)
    await DatabaseService().setWaterIntake(
      getStartOfDayTimestamp(_selectedDate),
      newValue,
    );
  }

  Future<void> _showCustomWaterDialog() async {
    final controller = TextEditingController();
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(context.l10n.dashboardScreenDailyWaterIntakeDialogTitle),
        titleTextStyle: TextStyle(color: Theme.of(context).colorScheme.primary),
        content: TextField(
          controller: controller,
          keyboardType: TextInputType.number,
          autofocus: true,
          decoration: InputDecoration(
            labelText: context.l10n.dashboardScreenDailyWaterIntakeDialogInpLbl,
            suffixText: 'ml',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              context.l10n.dashboardScreenDailyWaterIntakeDialogAction(
                'cancel',
              ),
            ),
          ),
          FilledButton(
            onPressed: () {
              final val = int.tryParse(controller.text);
              if (val != null && val > 0) {
                updateWater(val);
                Navigator.pop(context);
              }
            },
            child: Text(context.l10n.dashboardScreenDailyWaterIntakeDialogAction('add')),
          ),
        ],
      ),
    );
  }

  // TODO: Envoyer cette fonction de un fichier "helpers.dart"
  Future<void> _refreshData() async {
    setState(() {
      _loadingFuture = _loadData();
    });
  }

  // 1. Handle Deletion (DB + File + Refresh)
  Future<void> _handleDismissed(NutritionalFactsEntry entry) async {
    final date = DateTime.fromMillisecondsSinceEpoch(entry.timestamp);

    // Logique de suppression de l'entrée et du fichier
    if (entry.id != null) {
      await DatabaseService().deleteEntry(entry.id!);
      try {
        await File(entry.imagePath).delete();
      } catch (e) {
        if (mounted) {
          showSnackBar(context, context.l10n.appErrorDelete, true);
        }
      }
      _refreshData(); // Rafraîchir l'interface
    }

    if (mounted) {
      showSnackBar(
        context,
        context.l10n.historyScreenDeleteSuccessLbl(formatDate(date)),
        false,
      );
    }
  }

  Widget _buildWaterTracker() {
    // 1. Get Goal (Convert L to ml)
    // If goal is 2.5L -> 2500ml
    final double goalMl = _profile.waterGoal * 1000;

    // 2. Calculate Progress (0.0 to 1.0)
    final double progress = (goalMl > 0)
        ? (_currentWaterMl / goalMl).clamp(0.0, 1.0)
        : 0.0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          context.l10n.dashboardScreenDailyWaterLogsLbl,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        const SizedBox(height: 10),

        // --- MAIN CARD (The Filling Container) ---
        Card(
          elevation: 4,
          shadowColor: Colors.blue.withOpacity(0.3),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: SizedBox(
              height: 140, // Fixed height for the dashboard card
              child: Stack(
                children: [
                  // LAYER 1: The Rising Water Background
                  Positioned.fill(
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 800),
                        curve: Curves.easeOutCubic,
                        height: 140 * progress, // Fills up based on %
                        width: double.infinity,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.blue.withOpacity(0.3),
                              Colors.blue.withOpacity(0.5),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),

                  // LAYER 2: The Content (Row: Text Left | Circle Right)
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24.0,
                      vertical: 16.0,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // LEFT SIDE: Text Info
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              context.l10n.dashboardScreenDailyWaterIntakeLbl,
                              style: Theme.of(context).textTheme.bodyMedium
                                  ?.copyWith(
                                    color: Colors.blueGrey,
                                    fontWeight: FontWeight.w600,
                                  ),
                            ),
                            const SizedBox(height: 4),
                            RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: '$_currentWaterMl',
                                    style: TextStyle(
                                      fontSize: 32,
                                      fontWeight: FontWeight.bold,
                                      // Adaptive color based on theme (usually black/white)
                                      color: Theme.of(
                                        context,
                                      ).colorScheme.onSurface,
                                    ),
                                  ),
                                  const TextSpan(
                                    text: ' ml',
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.blueGrey,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              formatDateLabel(_selectedDate),
                              style: const TextStyle(
                                fontSize: 13,
                                color: Colors.blueGrey,
                              ),
                            ),
                          ],
                        ),

                        // RIGHT SIDE: Circular Progress
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            // Background Circle (Faint trace)
                            SizedBox(
                              width: 70,
                              height: 70,
                              child: CircularProgressIndicator(
                                value: 1.0,
                                strokeWidth: 6,
                                color: Colors.grey.withOpacity(0.1),
                              ),
                            ),
                            // Actual Progress
                            SizedBox(
                              width: 70,
                              height: 70,
                              child: CircularProgressIndicator(
                                value: progress,
                                strokeWidth: 6,
                                strokeCap: StrokeCap.round,
                                // Color changes to Green when goal met
                                color: progress >= 1.0
                                    ? Colors.green
                                    : Theme.of(context).colorScheme.primary,
                              ),
                            ),
                            // Icon inside
                            Icon(
                              Icons.local_drink_rounded,
                              color: Theme.of(context).colorScheme.primary,
                              size: 28,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),

        const SizedBox(height: 12),

        // --- CONTROLS ROW (Quick Actions) ---
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // 1. ADD 250ml
            Expanded(
              child: _buildQuickAddButton(
                icon: Icons.local_drink,
                label: '(250 ml)',
                color: Colors.lightBlueAccent.shade100,
                onTap: () => updateWater(250),
              ),
            ),

            const SizedBox(width: 8),

            // 2. ADD 500ml
            Expanded(
              child: _buildQuickAddButton(
                icon: Icons.water_drop,
                label: '(500 ml)',
                color: Colors.lightBlueAccent.shade100,
                onTap: () => updateWater(500),
              ),
            ),

            const SizedBox(width: 8),

            // 3. CUSTOM INPUT
            SizedBox(
              width: 50,
              height: 50,
              child: IconButton.filledTonal(
                onPressed: _showCustomWaterDialog,
                icon: const Icon(Icons.add),
                color: Theme.of(context).colorScheme.onPrimaryContainer,
              ),
            ),

            const SizedBox(width: 8),

            // 4. REMOVE BUTTON (Undo 250ml)
            SizedBox(
              width: 50,
              height: 50,
              child: IconButton.filledTonal(
                onPressed: () => updateWater(-250),
                icon: const Icon(Icons.remove),
                color: Theme.of(context).colorScheme.onPrimaryContainer,
              ),
            ),
          ],
        ),
      ],
    );
  }

  // Helper for the quick action buttons
  Widget _buildQuickAddButton({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          height: 50,
          decoration: BoxDecoration(
            color: color, // Subtle background
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.lightBlueAccent),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 18, color: Colors.blue[800]),
              const SizedBox(width: 6),
              Text(
                label,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMealLog() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          context.l10n.dashboardScreenDailyMealLogsLbl,
          style: Theme.of(context).textTheme.headlineMedium,
        ),

        const SizedBox(height: 10),

        AnalysisList(
          // Fetch list for the SELECTED date
          historyFuture: DatabaseService().getHistoryForDay(
            getStartOfDayTimestamp(_selectedDate),
          ),
          compactMode: false, // Show full list
          disableScroll: true, // <--- Let Dashboard handle scrolling
          onDismissed: _handleDismissed, // Enable Swipe-to-Delete
        ),
      ],
    );
  }

  // TODO: Envoyer cette fonction de un fichier "helpers.dart"
  // 3. WIDGET DU SÉLECTEUR DE GRAPHIQUE
  Widget _buildChartTypeSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          context.l10n.dashboardScreenWeeklySummaryLbl,
          style: Theme.of(context).textTheme.headlineMedium,
        ),

        const SizedBox(height: 10),

        ToggleButtons(
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
      ],
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

  // NEW: Combined Header (Title + Date Picker)
  Widget _buildInlineHeader() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0), // Add some breathing room
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // 1. The Title (Left side)
          // We use Flexible to ensure it doesn't overflow if the date is long
          Flexible(
            child: Text(
              context.l10n.dashboardScreenDailyObjectivesLbl,
              style: Theme.of(context).textTheme.headlineMedium,
              overflow: TextOverflow.ellipsis,
            ),
          ),

          // 2. Right Side Actions
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              // A. The Date Picker
              InkWell(
                onTap: _selectDate,
                borderRadius: BorderRadius.circular(8),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // The Calendar Icon
                      if (!DateUtils.isSameDay(
                        _selectedDate,
                        DateTime.now(),
                      )) ...[
                        Icon(
                          Icons.calendar_month_rounded,
                          color: Theme.of(context).colorScheme.primary,
                        ),

                        const SizedBox(width: 8),
                      ],

                      // Date Text (e.g. "Today" or "2023-10-15")
                      Text(
                        formatDateLabel(_selectedDate),
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),

                      // The Calendar Icon
                      if (DateUtils.isSameDay(
                        _selectedDate,
                        DateTime.now(),
                      )) ...[
                        const SizedBox(width: 8),

                        Icon(
                          Icons.calendar_month_rounded,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ],
                    ],
                  ),
                ),
              ),

              // B. NEW: "Add to this Day" Button
              // Only show if we are NOT on "Today" (since the main FAB handles Today)
              if (!DateUtils.isSameDay(_selectedDate, DateTime.now())) ...[
                const SizedBox(width: 12),
                IconButton.filled(
                  icon: const Icon(Icons.add_a_photo_rounded),
                  tooltip: 'Ajouter à cette date',
                  onPressed: () {
                    Navigator.of(context)
                        .push(
                          MaterialPageRoute(
                            builder: (_) => CameraScreen(
                              mode: CameraMode.mealAnalysis, // Default mode
                              targetDate: _selectedDate, // <--- PASS THE DATE
                            ),
                          ),
                        )
                        .then(
                          (_) => _refreshData(),
                        ); // Refresh dashboard on return
                  },
                ),
              ],
            ],
          ),
        ],
      ),
    );
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
                // 1. The new Date Header
                _buildInlineHeader(),

                _buildMacroGoalCard(
                  context,
                  title: context.l10n.dashboardScreenDailyObjectiveLbl(
                    'calories',
                  ),
                  consumed: _consumedMacros['calories'] ?? 0,
                  goal: _goalMacros['calories'] ?? 0,
                  unit: 'cal',
                ),

                const SizedBox(height: 10),

                Row(
                  children: [
                    _buildMacroGoalCard(
                      context,
                      title: context.l10n.dashboardScreenDailyObjectiveLbl(
                        'protein',
                      ),
                      consumed: _consumedMacros['protein'] ?? 0,
                      goal: _goalMacros['protein'] ?? 0,
                      unit: 'g',
                      flex: 1,
                    ),

                    const SizedBox(width: 10),

                    _buildMacroGoalCard(
                      context,
                      title: context.l10n.dashboardScreenDailyObjectiveLbl(
                        'totalFat',
                      ),
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
                  title: context.l10n.dashboardScreenDailyObjectiveLbl(
                    'totalCarbohydrate',
                  ),
                  consumed: _consumedMacros['totalCarbohydrates'] ?? 0,
                  goal: _goalMacros['totalCarbohydrates'] ?? 0,
                  unit: 'g',
                ),

                const Divider(),

                // 2. THE DAILY WATER LOG
                _buildWaterTracker(),

                const Divider(),

                // 3. THE DAILY MEAL LOG
                _buildMealLog(),

                const Divider(),

                // 3. THE CHART SELECTOR
                _buildChartTypeSelector(),

                const SizedBox(height: 20),

                // PASSAGE DE LA SÉLECTION AU GRAPHIQUE
                WeeklyChart(
                  chartType: _selectedChartType,
                  // Pass the calculated goal (default to 2000 if 0)
                  dailyGoal: _goalMacros['calories'] ?? 2000,
                ),
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
  final double dailyGoal;

  const WeeklyChart({
    required this.chartType,
    required this.dailyGoal,
    super.key,
  });

  // TODO: Envoyer cette fonction de un fichier "helpers.dart"
  // --- GRAPHIQUE À BARRES ---
  Widget _buildBarChart(
    BuildContext context,
    List<DailySummary> data,
    double maxY,
  ) {
    return BarChart(
      BarChartData(
        alignment: BarChartAlignment.spaceAround,
        maxY: maxY,
        barTouchData: BarTouchData(
          handleBuiltInTouches: true,
          touchTooltipData: BarTouchTooltipData(
            getTooltipColor: (spot) =>
                Theme.of(context).colorScheme.primaryContainer,
            tooltipBorderRadius: const BorderRadius.all(Radius.circular(8.0)),
            tooltipPadding: const EdgeInsets.all(8.0),
            tooltipMargin: 10,
            getTooltipItem: (group, groupIndex, rod, rodIndex) {
              final day = data[group.x.toInt()].dayName;

              // rodIndex 0 is Goal, 1 is Consumed
              final String label = rodIndex == 0 ? 'Goal' : 'Taken';
              final String value = '${rod.toY.round()} cal';
              // final calories = rod.toY;

              return BarTooltipItem(
                '$day\n',
                const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                children: <TextSpan>[
                  TextSpan(
                    text: '$label: $value',
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              );
            },
          ),
        ),
        barGroups: data.asMap().entries.map((entry) {
          final index = entry.key;
          final summary = entry.value;

          // Logic: Is this day over the limit?
          final bool isOverBudget = summary.calories > dailyGoal;

          // Use switch expression for cleaner selection logic
          final Color consumedColor = switch (summary.calories) {
            _ when isOverBudget =>
              Theme.brightnessOf(context) == Brightness.light
                  ? Theme.of(context).colorScheme.error
                  : Theme.of(context).colorScheme.errorContainer,
            _ when summary.calories > (dailyGoal - 250) => Colors.green,
            _ => Colors.blue,
          };

          return BarChartGroupData(
            x: index,
            // Spacing between the two bars inside the group
            barsSpace: 4,
            barRods: [
              // 1. GOAL ROD (Left, Grey)
              BarChartRodData(
                toY: dailyGoal,
                color: Theme.of(context).colorScheme.onInverseSurface,
                width: 12,
                borderRadius: BorderRadius.circular(4),
              ),

              // 2. CONSUMED ROD (Right, Colored)
              BarChartRodData(
                toY: summary.calories,
                color: consumedColor,
                width: 12,
                borderRadius: BorderRadius.circular(4),
                // Optional: Make the "excess" part glow or highlight?
                // For now, simple color change is cleanest.
              ),
            ],
          );
        }).toList(),
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
            bottom: BorderSide(
              color: Theme.of(context).colorScheme.inverseSurface,
              width: 1,
            ),
            left: BorderSide(
              color: Theme.of(context).colorScheme.inverseSurface,
              width: 1,
            ),
          ),
        ),
      ),
    );
  }

  // TODO: Envoyer cette fonction de un fichier "helpers.dart"
  // --- GRAPHIQUE EN LIGNES ---
  Widget _buildLineChart(
    BuildContext context,
    List<DailySummary> data,
    double maxY,
  ) {
    return LineChart(
      LineChartData(
        minY: 0,
        maxY: maxY,
        lineTouchData: LineTouchData(
          handleBuiltInTouches: true,
          touchTooltipData: LineTouchTooltipData(
            getTooltipColor: (spot) =>
                Theme.of(context).colorScheme.primaryContainer,
            tooltipBorderRadius: const BorderRadius.all(Radius.circular(8.0)),
            tooltipPadding: const EdgeInsets.all(8.0),
            tooltipMargin: 10,
            getTooltipItems: (List<LineBarSpot> lineBarsSpot) {
              return lineBarsSpot.map((spot) {
                final day = data[spot.x.toInt()].dayName;
                final calories = spot.y;

                return LineTooltipItem(
                  '$day\n',
                  const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  children: <TextSpan>[
                    TextSpan(
                      text: '${calories.toStringAsFixed(0)} cal',
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                );
              }).toList();
            },
          ),
        ),

        // 1. THE GOAL LINE (Threshold)
        extraLinesData: ExtraLinesData(
          horizontalLines: [
            HorizontalLine(
              y: dailyGoal, // The magic number (e.g., 2000)
              color: Theme.of(
                context,
              ).colorScheme.error, // Subtle red warning color
              strokeWidth: 2,
              dashArray: [8, 6], // Makes it dashed (5px line, 5px gap)
              label: HorizontalLineLabel(
                show: true,
                alignment: Alignment.topRight,
                style: TextStyle(
                  color: Theme.brightnessOf(context) == Brightness.light
                      ? Theme.of(context).colorScheme.error
                      : Theme.of(context).colorScheme.errorContainer,
                  fontWeight: FontWeight.bold,
                ),
                labelResolver: (line) => 'Goal', // Label text
              ),
            ),
          ],
        ),

        // 2. THE DATA LINE
        lineBarsData: [
          LineChartBarData(
            spots: data.asMap().entries.map((entry) {
              final index = entry.key;
              final summary = entry.value;
              return FlSpot(index.toDouble(), summary.calories);
            }).toList(),
            isCurved: true,
            color: Theme.of(context).colorScheme.primary, // Line color
            // Highlight the dots that are OVER the limit
            dotData: FlDotData(
              show: true,
              // checkToShowDot: (spot, barData) {
              //   // Only show dots for days where we exceeded the goal
              //   return spot.y > dailyGoal;
              // },
              getDotPainter: (spot, percent, barData, index) {
                return FlDotCirclePainter(
                  radius: 5,
                  color: spot.y > dailyGoal
                      ? Theme.brightnessOf(context) == Brightness.light
                            ? Theme.of(context).colorScheme.error
                            : Theme.of(context).colorScheme.errorContainer
                      : Theme.of(context).colorScheme.primary,
                  strokeWidth: spot.y > dailyGoal ? 2 : 0,
                  strokeColor: spot.y > dailyGoal
                      ? Theme.of(context).colorScheme.surface
                      : Theme.of(context).colorScheme.surface,
                );
              },
            ),
            // Fill area with a subtle gradient
            belowBarData: BarAreaData(
              show: true,
              gradient: LinearGradient(
                colors: [
                  Theme.of(context).colorScheme.primary.withValues(alpha: 0.8),
                  Theme.of(context).colorScheme.primary.withValues(alpha: 0.6),
                  Theme.of(context).colorScheme.primary.withValues(alpha: 0.4),
                  Theme.of(context).colorScheme.primary.withValues(alpha: 0.2),
                  Theme.of(context).colorScheme.primary.withValues(alpha: 0.0),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
        ],
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
            bottom: BorderSide(
              color: Theme.of(context).colorScheme.inverseSurface,
              width: 1,
            ),
            left: BorderSide(
              color: Theme.of(context).colorScheme.inverseSurface,
              width: 1,
            ),
          ),
        ),
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

        // CALCULATE MAX Y
        // We need the chart to be at least as tall as the Goal,
        // OR the highest calorie day (whichever is bigger).
        final double maxConsumed = data
            .map((e) => e.calories)
            .fold(0, (p, c) => p > c ? p : c);
        final double maxY =
            (maxConsumed > dailyGoal ? maxConsumed : dailyGoal) *
            1.2; // Add 20% headroom

        return SizedBox(
          height: 250,
          child: chartType == ChartType.bar
              ? _buildBarChart(context, data, maxY)
              : _buildLineChart(context, data, maxY),
        );
      },
    );
  }
}
