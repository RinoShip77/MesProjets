import 'package:macro_vision/models/user_profile.dart';

/// Business logic for calculating BMR, TDEE, and Macro targets.
class NutritionCalculator {
  // --- Constants (Calories per gram) ---
  static const double _calPerCarb = 4.0;
  static const double _calPerProtein = 4.0;
  static const double _calPerFat = 9.0;
  static const double _minSafeCalories = 1200.0;

  /// Multipliers
  static const Map<ActivityLevel, double> _activityMultipliers = {
    ActivityLevel.sedentary: 1.2,
    ActivityLevel.lightly: 1.375,
    ActivityLevel.moderate: 1.55,
    ActivityLevel.very: 1.725,
    ActivityLevel.extra: 1.9,
  };

  /// Calculates BMR using Katch-McArdle (if Body Fat known) or Mifflin-St Jeor (Standard).
  static double calculateBMR(UserProfile profile) {
    // 1. PREFERRED: Katch-McArdle (If body fat is set)
    if (profile.bodyFat != null && profile.bodyFat! > 0) {
      final double leanBodyMass = profile.weight * (1 - (profile.bodyFat! / 100));
      return 370 + (21.6 * leanBodyMass);
    }

    // 2. FALLBACK: Mifflin-St Jeor (Standard)
    final double weightFactor = 10 * profile.weight;
    final double heightFactor = 6.25 * profile.height;
    final double ageFactor = 5.0 * profile.age;
    final double genderAdjustment = profile.gender == Gender.male ? 5.0 : -161.0;

    return (weightFactor + heightFactor - ageFactor + genderAdjustment).roundToDouble();
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

    if (profile.goal == Goal.maintain) {
      return tdee;
    }

    // 🧠 LOGIC: 1kg of fat ≈ 7700 kcal
    // We calculate the daily deficit needed to match the weekly pace (e.g., 0.5kg)
    final double weeklyCalorieDiff = profile.weeklyPace * 7700;
    final double dailyAdjustment = weeklyCalorieDiff / 7;

    double result;
    if (profile.goal == Goal.weightLoss) {
      result = tdee - dailyAdjustment;
    } else {
      // Muscle Gain
      result = tdee + dailyAdjustment;
    }

    // Safety Check: Never suggest dangerous starvation calories
    return result < _minSafeCalories
        ? _minSafeCalories
        : result.roundToDouble();
  }

  /// Generates a standard macro split (40% Carbs, 30% Protein, 30% Fat).
  static Map<String, double> calculateMacroGoals(UserProfile profile) {
    final double goalCals = calculateGoalCalories(profile);

    // TODO: Later you can adjust these % based on 'dietaryPreferences' (e.g. Keto)
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

  /// Water calculation
  static double calculateWaterGoal(double weightInKg) {
    final double result = weightInKg * 0.035;
    if (result < 1.0) return 1.0;
    if (result > 5.0) return 5.0;
    return double.parse(result.toStringAsFixed(1));
  }
}
