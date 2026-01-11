// Définitions pour les choix de l'utilisateur
enum WeightUnit {
  kg,
  lbs;

  // Optional: Helper for display text (e.g. "kg" vs "Kilogrammes")
  String get label => name;
}

enum HeightUnit {
  cm,
  ft; // represents feet & inches usually

  String get label => name;
}

enum ActivityLevel { sedentary, lightly, moderate, very, extra }

enum Gender { male, female }

enum Goal { weightLoss, muscleGain, maintain }

enum PaceIntensity {
  slow,
  moderate,
  intense;

  // Static helper to determine intensity based on KG value
  static PaceIntensity fromKg(double kgPerWeek) {
    if (kgPerWeek <= 0.25) return PaceIntensity.slow;
    if (kgPerWeek <= 0.5) return PaceIntensity.moderate;
    return PaceIntensity.intense;
  }
}

enum DietaryPreference {
  vegetarian,
  vegan,
  glutenFree,
  keto,
  lactoseFree,
  none,
}


class UserProfile {
  String name;
  int age;
  double weight;
  WeightUnit weightUnit;
  double height;
  HeightUnit heightUnit;
  ActivityLevel activityLevel;
  Gender gender;
  Goal goal;
  double weeklyPace;
  List<DietaryPreference> dietaryPreferences;
  bool isMetric;
  
  PaceIntensity get paceIntensity => PaceIntensity.fromKg(weeklyPace);

  UserProfile({
    this.name = '',
    this.age = 0,
    this.weight = 0.0,
    this.weightUnit = WeightUnit.kg,
    this.height = 0.0,
    this.heightUnit = HeightUnit.cm,
    this.activityLevel = ActivityLevel.sedentary,
    this.gender = Gender.male,
    this.goal = Goal.maintain,
    this.weeklyPace = 0.5,
    List<DietaryPreference>? dietaryPreferences,
    this.isMetric = true,
  }) : dietaryPreferences = dietaryPreferences ?? [];

  // Pour charger l'objet depuis SharedPreferences (en JSON)
  factory UserProfile.fromJson(Map<String, dynamic> json) {
    // Fonction utilitaire pour la conversion sécurisée
    WeightUnit parseWeightUnit(String? value) {
      try {
        if (value == null) return WeightUnit.kg;
        return WeightUnit.values.firstWhere((e) => e.name == value);
      } catch (_) {
        return WeightUnit.kg;
      }
    }

    HeightUnit parseHeightUnit(String? value) {
      try {
        if (value == null) return HeightUnit.cm;
        return HeightUnit.values.firstWhere((e) => e.name == value);
      } catch (_) {
        return HeightUnit.cm;
      }
    }

    ActivityLevel parseActivityLevel(String? value) {
      try {
        if (value == null) return ActivityLevel.sedentary;
        return ActivityLevel.values.firstWhere((e) => e.name == value);
      } catch (_) {
        return ActivityLevel.sedentary;
      }
    }

    Gender parseGender(String? value) {
      try {
        if (value == null) return Gender.male;
        return Gender.values.firstWhere((e) => e.name == value);
      } catch (_) {
        return Gender.male;
      }
    }

    Goal parseGoal(String? value) {
      try {
        if (value == null) return Goal.maintain;
        return Goal.values.firstWhere((e) => e.name == value);
      } catch (_) {
        return Goal.maintain;
      }
    }

    return UserProfile(
      name: json['name'] ?? '',
      age: json['age'] ?? 0,
      weight: (json['weight'] ?? 0.0).toDouble(),
      weightUnit: parseWeightUnit(json['weightUnit']),
      height: (json['height'] ?? 0.0).toDouble(),
      heightUnit: parseHeightUnit(json['heightUnit']),
      activityLevel: parseActivityLevel(json['activityLevel']),
      gender: parseGender(json['gender']),
      goal: parseGoal(json['goal']),
      weeklyPace: (json['weeklyPace'] ?? 0.5).toDouble(),
      dietaryPreferences:
          (json['dietaryPreferences'] as List<dynamic>?)
              ?.map(
                (e) => DietaryPreference.values.firstWhere(
                  (dp) => dp.name == e,
                  orElse: () => DietaryPreference.none,
                ),
              )
              .where((e) => e != DietaryPreference.none)
              .toList() ??
          [],
      isMetric: json['isMetric'] ?? true,
    );
  }

  // Pour stocker l'objet dans SharedPreferences (en JSON)
  Map<String, dynamic> toJson() => {
    'name': name,
    'age': age,
    'weight': weight,
    'weightUnit': weightUnit.name,
    'height': height,
    'heightUnit': heightUnit.name,
    'activityLevel': activityLevel.name,
    'gender': gender.name,
    'goal': goal.name,
    'weeklyPace': weeklyPace,
    'dietaryPreferences': dietaryPreferences.map((e) => e.name).toList(),
    'isMetric': isMetric,
  };
}
