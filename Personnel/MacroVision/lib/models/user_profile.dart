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

enum DietaryPreference {
  vegetarian,
  vegan,
  glutenFree,
  keto,
  lactoseFree,
  none,
}

enum Goal { weightLoss, muscleGain, maintain }

class UserProfile {
  String name;
  int age;
  double weight;
  WeightUnit weightUnit;
  double height;
  HeightUnit heightUnit;
  ActivityLevel activityLevel;
  Gender gender;
  List<DietaryPreference> dietaryPreferences;
  Goal goal;
  bool isMetric;

  UserProfile({
    this.name = '',
    this.age = 0,
    this.weight = 0.0,
    this.weightUnit = WeightUnit.kg,
    this.height = 0.0,
    this.heightUnit = HeightUnit.cm,
    this.activityLevel = ActivityLevel.sedentary,
    this.gender = Gender.male,
    List<DietaryPreference>? dietaryPreferences,
    this.goal = Goal.maintain,
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

    DietaryPreference parseDietaryPreference(String? value) {
      try {
        if (value == null) return DietaryPreference.none;
        return DietaryPreference.values.firstWhere((e) => e.name == value);
      } catch (_) {
        return DietaryPreference.none;
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
      goal: parseGoal(json['goal']),
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
    'dietaryPreferences': dietaryPreferences.map((e) => e.name).toList(),
    'goal': goal.name,
    'isMetric': isMetric,
  };
}
