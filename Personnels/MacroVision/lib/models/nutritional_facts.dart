class NutritionalFacts {
  final String foodName; // Nom de l'aliment
  final double portionInGrams; // g - AJOUTÉ
  // Remarque : toutes les valeurs seront en grammes (g) ou milligrammes (mg),
  // sauf les Calories qui sont en Cal.
  final double calories; // Cal (au lieu de kcal)
  final double totalFat; // g
  final double saturatedFat; // g
  final double transFat; // g
  final double cholesterol; // mg
  final double sodium; // mg
  final double potassium; // mg
  final double totalCarbohydrates; // g
  final double dietaryFiber; // g
  final double sugar; // g
  final double protein; // g

  NutritionalFacts({
    required this.foodName,
    required this.portionInGrams, // AJOUTÉ
    required this.calories,
    required this.totalFat,
    required this.saturatedFat,
    required this.transFat,
    required this.cholesterol,
    required this.sodium,
    required this.potassium,
    required this.totalCarbohydrates,
    required this.dietaryFiber,
    required this.sugar,
    required this.protein,
  });

  // Factory constructor pour créer un objet à partir du JSON retourné par l'IA
  factory NutritionalFacts.fromJson(Map<String, dynamic> json) {
    // La méthode .toDouble() est utilisée pour s'assurer que les valeurs sont traitées comme des doubles
    return NutritionalFacts(
      foodName: json['foodName'] as String? ?? 'Aliment non identifié',
      portionInGrams:
          (json['portionInGrams'] as num?)?.toDouble() ?? 0.0, // AJOUTÉ
      // Conversion : Gemini donnera probablement des Kcal, on multiplie par 1000 pour les Cal.
      // Si l'IA donne des Cal, il faudra ajuster. On part du principe qu'elle donne des Kcal.
      calories: (json['calories'] as num?)?.toDouble() ?? 0.0,
      totalFat: (json['totalFat'] as num?)?.toDouble() ?? 0.0,
      saturatedFat: (json['saturatedFat'] as num?)?.toDouble() ?? 0.0,
      transFat: (json['transFat'] as num?)?.toDouble() ?? 0.0,
      cholesterol: (json['cholesterol'] as num?)?.toDouble() ?? 0.0,
      sodium: (json['sodium'] as num?)?.toDouble() ?? 0.0,
      potassium: (json['potassium'] as num?)?.toDouble() ?? 0.0,
      totalCarbohydrates:
          (json['totalCarbohydrates'] as num?)?.toDouble() ?? 0.0,
      dietaryFiber: (json['dietaryFiber'] as num?)?.toDouble() ?? 0.0,
      sugar: (json['sugar'] as num?)?.toDouble() ?? 0.0,
      protein: (json['protein'] as num?)?.toDouble() ?? 0.0,
    );
  }

  // MÉTHODE POUR L'AJUSTEMENT DE LA PORTION (Prompt 2.1)
  NutritionalFacts copyWithRefinedWeight(double newWeightInGrams) {
    if (portionInGrams == 0.0 || newWeightInGrams == 0.0) {
      return this;
    }

    // Calcul du facteur de mise à l'échelle
    final double scalingFactor = newWeightInGrams / portionInGrams;

    return NutritionalFacts(
      foodName: foodName,
      portionInGrams: newWeightInGrams,
      // Mise à l'échelle de toutes les macros
      calories: calories * scalingFactor,
      totalFat: totalFat * scalingFactor,
      saturatedFat: saturatedFat * scalingFactor,
      transFat: transFat * scalingFactor,
      cholesterol: cholesterol * scalingFactor,
      sodium: sodium * scalingFactor,
      potassium: potassium * scalingFactor,
      totalCarbohydrates: totalCarbohydrates * scalingFactor,
      dietaryFiber: dietaryFiber * scalingFactor,
      sugar: sugar * scalingFactor,
      protein: protein * scalingFactor,
    );
  }
}
