import 'package:macro_vision/models/user_profile.dart';

class NutritionCalculator {
  // Facteurs d'activité physique pour le calcul du TDEE
  static const Map<ActivityLevel, double> _activityMultipliers = {
    ActivityLevel.sedentary: 1.2,
    ActivityLevel.lightlyActive: 1.375,
    ActivityLevel.moderatelyActive: 1.55,
    ActivityLevel.veryActive: 1.725,
    ActivityLevel.extraActive: 1.9,
  };

  // --- CALCULATEUR DE BESOINS DE BASE (TMB) ---
  
  // Utilise la formule de Mifflin-St Jeor
  static double calculateBMR(UserProfile profile) {
    final double weightFactor = 10 * profile.weight; // 10 * kg
    final double heightFactor = 6.25 * profile.height; // 6.25 * cm
    final double ageFactor = 5.0 * profile.age; // 5 * années
    double genderAdjustment = profile.gender == Gender.male ? 5 : -161;

    double bmr = weightFactor + heightFactor - ageFactor + genderAdjustment;
    return bmr.roundToDouble();
  }

  // --- CALCULATEUR DÉPENSE ÉNERGÉTIQUE QUOTIDIENNE (TDEE) ---
  
  static double calculateTDEE(UserProfile profile) {
    final double bmr = calculateBMR(profile);
    final double multiplier = _activityMultipliers[profile.activityLevel] ?? 1.2;
    return (bmr * multiplier).roundToDouble();
  }

  // --- CALCULATEUR D'OBJECTIFS CALORIQUES ---
  
  static double calculateGoalCalories(UserProfile profile) {
    final double tdee = calculateTDEE(profile);
    
    double goalAdjustment;
    switch (profile.goal) {
      case 'Perte de poids':
        goalAdjustment = -500; // Déficit modéré pour perdre environ 0.5kg/semaine
        break;
      case 'Gain musculaire':
        goalAdjustment = 300; // Surplus modéré
        break;
      case 'Maintien':
      default:
        goalAdjustment = 0;
        break;
    }
    
    // S'assurer que le minimum est respecté (même avec un déficit, pour éviter des régimes extrêmes)
    final double result = tdee + goalAdjustment;
    return result < 1200 ? 1200 : result.roundToDouble(); 
  }
  
  // --- CALCULATEUR D'OBJECTIFS MACRO (Exemple 40/30/30) ---
  
  static Map<String, double> calculateMacroGoals(UserProfile profile) {
    final double goalCals = calculateGoalCalories(profile);
    
    // Répartition classique (ex: 40% Glucides, 30% Protéines, 30% Lipides)
    // 1g Protéines = 4 Kcal | 1g Glucides = 4 Kcal | 1g Lipides = 9 Kcal
    
    final double proteinCals = goalCals * 0.30;
    final double carbCals = goalCals * 0.40;
    final double fatCals = goalCals * 0.30;
    
    return {
      'calories': goalCals,
      'protein': (proteinCals / 4).roundToDouble(),
      'totalCarbohydrates': (carbCals / 4).roundToDouble(),
      'totalFat': (fatCals / 9).roundToDouble(),
    };
  }

  // --- Noms d'Affichage pour l'Activité ---
  
  static String getActivityName(ActivityLevel level) {
    switch (level) {
      case ActivityLevel.sedentary: return 'Sédentaire (peu ou pas d\'exercice)';
      case ActivityLevel.lightlyActive: return 'Légèrement actif (1-3 jours/semaine)';
      case ActivityLevel.moderatelyActive: return 'Modérément actif (3-5 jours/semaine)';
      case ActivityLevel.veryActive: return 'Très actif (6-7 jours/semaine)';
      case ActivityLevel.extraActive: return 'Extrêmement actif (2x/jour)';
    }
  }
}