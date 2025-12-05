// Définitions pour les choix de l'utilisateur
enum Gender { male, female }
enum ActivityLevel {
  sedentary, // Sédentaire
  lightlyActive, // Légèrement actif
  moderatelyActive, // Modérément actif
  veryActive, // Très actif
  extraActive // Extrêmement actif
}

class UserProfile {
  String name;
  // TODO : Mettre à jour les unités si nécessaire (ex: poids en livres)
  double weight; // en kg
  double height; // en cm
  int age;
  String goal; // Objectif principal (ex: Maintien, Perte de poids, etc.)
  Gender gender;
  ActivityLevel activityLevel;

  UserProfile({
    this.name = 'Utilisateur',
    this.weight = 70.0,
    this.height = 170.0,
    this.age = 30,
    this.goal = 'Maintien',
    this.gender = Gender.male, // Par défaut
    this.activityLevel = ActivityLevel.sedentary, // Par défaut
  });

  // Pour stocker l'objet dans SharedPreferences (en JSON)
  Map<String, dynamic> toJson() => {
        'name': name,
        'weight': weight,
        'height': height,
        'age': age,
        'goal': goal,
        'gender': gender.name, // Sauvegarde comme string
        'activityLevel': activityLevel.name, // Sauvegarde comme string
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

    return UserProfile(
      name: json['name'] ?? 'Utilisateur',
      weight: (json['weight'] as num?)?.toDouble() ?? 70.0,
      height: (json['height'] as num?)?.toDouble() ?? 170.0,
      age: json['age'] ?? 30,
      goal: json['goal'] ?? 'Maintien',
      gender: parseGender(json['gender']), // Chargement du nouveau champ
      activityLevel: parseActivity(json['activityLevel']), // Chargement du nouveau champ
    );
  }
}