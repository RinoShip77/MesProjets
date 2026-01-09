// Définitions pour les choix de l'utilisateur
enum Gender { male, female }

enum ActivityLevel {
  sedentary, // Sédentaire
  lightly, // Légèrement actif
  moderate, // Modérément actif
  very, // Très actif
  extra, // Extrêmement actif
}

enum Goal { weightLoss, muscleGain, maintain }

class UserProfile {
  String name;
  int age;
  double weight;
  double height;
  String weightUnit;
  String heightUnit;
  bool isMetric;
  Gender gender;
  ActivityLevel activityLevel;
  Goal goal;

  UserProfile({
    this.name = '',
    this.age = 0,
    this.weight = 0.0,
    this.height = 0.0,
    this.weightUnit = 'kg',
    this.heightUnit = 'cm',
    this.isMetric = true,
    this.gender = Gender.male,
    this.activityLevel = ActivityLevel.sedentary,
    this.goal = Goal.maintain,
  });

  // Pour stocker l'objet dans SharedPreferences (en JSON)
  Map<String, dynamic> toJson() => {
    'name': name,
    'age': age,
    'weight': weight,
    'height': height,
    'weightUnit': weightUnit,
    'heightUnit': heightUnit,
    'isMetric': isMetric,
    'gender': gender.name,
    'activityLevel': activityLevel.name,
    'goal': goal.name,
  };

  // Pour charger l'objet depuis SharedPreferences (en JSON)
  factory UserProfile.fromJson(Map<String, dynamic> json) {
    // Fonction utilitaire pour la conversion sécurisée
    Gender parseGender(String? value) {
      try {
        if (value == null) return Gender.male;
        return Gender.values.firstWhere((e) => e.name == value);
      } catch (_) {
        return Gender.male;
      }
    }

    ActivityLevel parseActivity(String? value) {
      try {
        if (value == null) return ActivityLevel.sedentary;
        return ActivityLevel.values.firstWhere((e) => e.name == value);
      } catch (_) {
        return ActivityLevel.sedentary;
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
      height: (json['height'] ?? 0.0).toDouble(),
      weightUnit: json['weightUnit'] ?? (json['isMetric'] == true ? 'kg' : 'lbs'),
      heightUnit: json['heightUnit'] ?? (json['isMetric'] == true ? 'cm' : 'ft'),
      isMetric: json['isMetric'] ?? true,
      gender: parseGender(json['gender']),
      activityLevel: parseActivity(json['activityLevel']),
      goal: parseGoal(json['goal']),
    );
  }
}
