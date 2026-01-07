import 'package:macro_vision/models/user_profile.dart';

/// Business logic for calculating BMR, TDEE, and Macro targets.
class NutritionCalculator {
  // --- Constants (Calories per gram) ---
  static const double _calPerCarb = 4.0;
  static const double _calPerProtein = 4.0;
  static const double _calPerFat = 9.0;

  // Safety floor to prevent unhealthy recommendations
  static const double _minSafeCalories = 1200.0;

  // Multipliers
  static const Map<ActivityLevel, double> _activityMultipliers = {
    ActivityLevel.sedentary: 1.2,
    ActivityLevel.lightly: 1.375,
    ActivityLevel.moderate: 1.55,
    ActivityLevel.very: 1.725,
    ActivityLevel.extra: 1.9,
  };

  /// Calculates Basal Metabolic Rate (BMR) using the Mifflin-St Jeor equation.
  static double calculateBMR(UserProfile profile) {
    final double weightFactor = 10 * profile.weight;
    final double heightFactor = 6.25 * profile.height;
    final double ageFactor = 5.0 * profile.age;

    // Adjustment: Male (+5), Female (-161)
    final double genderAdjustment = profile.gender == Gender.male
        ? 5.0
        : -161.0;

    return (weightFactor + heightFactor - ageFactor + genderAdjustment)
        .roundToDouble();
  }

  /// Calculates Total Daily Energy Expenditure (TDEE).
  static double calculateTDEE(UserProfile profile) {
    final bmr = calculateBMR(profile);
    final multiplier = _activityMultipliers[profile.activityLevel] ?? 1.2;
    return (bmr * multiplier).roundToDouble();
  }

  /// Calculates the daily calorie goal based on the user's objective.
  static double calculateGoalCalories(UserProfile profile) {
    final tdee = calculateTDEE(profile);

    // Apply deficit or surplus
    final double adjustment = switch (profile.goal) {
      Goal.weightLoss => -500.0, // approx 0.5kg weight loss per week
      Goal.muscleGain => 300.0, // Mild surplus for muscle gain
      _ => 0.0, // Maintenance
    };

    final result = tdee + adjustment;
    return result < _minSafeCalories
        ? _minSafeCalories
        : result.roundToDouble();
  }

  /// Generates a standard macro split (40% Carbs, 30% Protein, 30% Fat).
  static Map<String, double> calculateMacroGoals(UserProfile profile) {
    final double goalCals = calculateGoalCalories(profile);

    // Standard Split: 40C / 30P / 30F
    const splitCarb = 0.40;
    const splitProtein = 0.30;
    const splitFat = 0.30;

    return {
      'calories': goalCals,
      'protein': (goalCals * splitProtein / _calPerProtein).roundToDouble(),
      'totalCarbohydrates': (goalCals * splitCarb / _calPerCarb)
          .roundToDouble(),
      'totalFat': (goalCals * splitFat / _calPerFat).roundToDouble(),
    };
  }

  /// Returns a human-readable description for the activity level.
  static String getActivityName(ActivityLevel level) {
    return switch (level) {
      ActivityLevel.sedentary => 'Sedentary (Little or no exercise)',
      ActivityLevel.lightly => 'Lightly active (1-3 days/week)',
      ActivityLevel.moderate => 'Moderately active (3-5 days/week)',
      ActivityLevel.very => 'Very active (6-7 days/week)',
      ActivityLevel.extra => 'Extra active (Physical job or 2x/day)',
    };
  }
}
