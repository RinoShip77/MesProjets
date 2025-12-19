// Définitions pour les choix de l'utilisateur
enum Gender { male, female }

enum ActivityLevel {
  sedentary, // Sédentaire
  lightly, // Légèrement actif
  moderate, // Modérément actif
  very, // Très actif
  extra, // Extrêmement actif
}

enum Goal {
  weightLoss,
  muscleGain,
  maintain,
}

class UserProfile {
  String name;
  double weight; // en kg (STOCKAGE METRIQUE)
  double height; // en cm (STOCKAGE METRIQUE)
  int age;
  // String goal; // Objectif principal (ex: Maintien, Perte de poids, etc.)
  Gender gender;
  ActivityLevel activityLevel;
  Goal goal;

  // NOUVEAU: Choix de l'unité. true = Métrique (kg, cm), false = Impérial (lbs, ft/in)
  bool isMetric;

  UserProfile({
    this.name = 'Utilisateur',
    this.weight = 70.0,
    this.height = 170.0,
    this.age = 30,
    // this.goal = 'Maintien',
    this.gender = Gender.male, // Par défaut
    this.activityLevel = ActivityLevel.sedentary, // Par défaut
    this.goal = Goal.maintain, // Par défaut
    this.isMetric = true, // Par défaut à Métrique
  });

  // Pour stocker l'objet dans SharedPreferences (en JSON)
  Map<String, dynamic> toJson() => {
    'name': name,
    'weight': weight,
    'height': height,
    'age': age,
    // 'goal': goal,
    'gender': gender.name, // Sauvegarde comme string
    'activityLevel': activityLevel.name, // Sauvegarde comme string
    'goal': goal.name, // Sauvegarde comme string
    'isMetric': isMetric, // AJOUTÉ
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
      name: json['name'] ?? 'Utilisateur',
      weight: (json['weight'] as num?)?.toDouble() ?? 70.0,
      height: (json['height'] as num?)?.toDouble() ?? 170.0,
      age: json['age'] ?? 30,
      // goal: json['goal'] ?? 'Maintien',
      gender: parseGender(json['gender']),
      activityLevel: parseActivity(json['activityLevel']),
      goal: parseGoal(json['goal']),
      isMetric: json['isMetric'] as bool? ?? true, // LECTURE DU NOUVEAU CHAMP
    );
  }
}
