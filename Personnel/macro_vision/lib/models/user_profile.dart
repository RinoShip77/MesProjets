class UserProfile {
  String name;
  double weight; // en kg
  double height; // en cm
  int age;
  String goal; // Objectif principal (ex: Maintien, Perte de poids, etc.)

  UserProfile({
    this.name = 'Utilisateur',
    this.weight = 70.0,
    this.height = 170.0,
    this.age = 30,
    this.goal = 'Maintien',
  });

  // Pour stocker l'objet dans SharedPreferences (en JSON)
  Map<String, dynamic> toJson() => {
        'name': name,
        'weight': weight,
        'height': height,
        'age': age,
        'goal': goal,
      };

  // Pour charger l'objet depuis SharedPreferences (en JSON)
  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      name: json['name'] ?? 'Utilisateur',
      weight: (json['weight'] as num?)?.toDouble() ?? 70.0,
      height: (json['height'] as num?)?.toDouble() ?? 170.0,
      age: json['age'] ?? 30,
      goal: json['goal'] ?? 'Maintien',
    );
  }
}