import 'package:macro_vision/models/user_profile.dart';

class NutritionCalculator {
  // Constants for Readability
  static const double _calPerCarb = 4.0;
  static const double _calPerProtein = 4.0;
  static const double _calPerFat = 9.0;

  static const double _minSafeCalories = 1200.0;

  // Multipliers
  static const Map<ActivityLevel, double> _activityMultipliers = {
    ActivityLevel.sedentary: 1.2,
    ActivityLevel.lightly: 1.375,
    ActivityLevel.moderate: 1.55,
    ActivityLevel.very: 1.725,
    ActivityLevel.extra: 1.9,
  };

  static double calculateBMR(UserProfile profile) {
    // Mifflin-St Jeor Formula
    final genderAdjustment = profile.gender == Gender.male ? 5 : -161;
    final bmr =
        (10 * profile.weight) +
        (6.25 * profile.height) -
        (5.0 * profile.age) +
        genderAdjustment;

    return bmr.roundToDouble();
  }

  static double calculateTDEE(UserProfile profile) {
    final bmr = calculateBMR(profile);
    final multiplier =
        _activityMultipliers[profile.activityLevel] ?? 1.2;
    return (bmr * multiplier).roundToDouble();
  }

  static double calculateGoalCalories(UserProfile profile) {
    final tdee = calculateTDEE(profile);
    final double adjustment = switch (profile.goal) {
      Goal.weightLoss => -500.0, // ~0.5kg/week loss
      Goal.muscleGain => 300.0,
      _ => 0.0, // 'Maintain'
    };

    final result = tdee + adjustment;
    return result < _minSafeCalories ? _minSafeCalories : result.roundToDouble();
  }
  
  static Map<String, double> calculateMacroGoals(UserProfile profile) {
    final double goalCals = calculateGoalCalories(profile);

    // Standard Split: 40C / 30P / 30F
    const splitCarb = 0.40;
    const splitProtein = 0.30;
    const splitFat = 0.30;

    return {
      'calories': goalCals,
      'protein': (goalCals * splitProtein / _calPerProtein).roundToDouble(),
      'totalCarbohydrates': (goalCals * splitCarb / _calPerCarb).roundToDouble(),
      'totalFat': (goalCals * splitFat / _calPerFat).roundToDouble(),
    };
  }

  static String getActivityName(ActivityLevel level) {
    return switch (level) {
      ActivityLevel.sedentary => 'Sédentaire (peu ou pas d\'exercice)',
      ActivityLevel.lightly => 'Légèrement actif (1-3 jours/semaine)',
      ActivityLevel.moderate => 'Modérément actif (3-5 jours/semaine)',
      ActivityLevel.very => 'Très actif (6-7 jours/semaine)',
      ActivityLevel.extra => 'Extrêmement actif (2x/jour)',
    };
  }
}
