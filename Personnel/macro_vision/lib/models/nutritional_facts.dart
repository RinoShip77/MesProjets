class NutritionalFacts {
  final String foodName; // Nom de l'aliment
  
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
    // et éviter les erreurs de type.
    return NutritionalFacts(
      foodName: json['foodName'] as String? ?? 'Aliment non identifié',

      // Conversion : Gemini donnera probablement des Kcal, on multiplie par 1000 pour les Cal.
      // Si l'IA donne des Cal, il faudra ajuster. On part du principe qu'elle donne des Kcal.
      calories: (json['calories'] as num).toDouble(),
      totalFat: (json['totalFat'] as num).toDouble(),
      saturatedFat: (json['saturatedFat'] as num).toDouble(),
      transFat: (json['transFat'] as num).toDouble(),
      cholesterol: (json['cholesterol'] as num).toDouble(),
      sodium: (json['sodium'] as num).toDouble(),
      potassium: (json['potassium'] as num).toDouble(),
      totalCarbohydrates: (json['totalCarbohydrates'] as num).toDouble(),
      dietaryFiber: (json['dietaryFiber'] as num).toDouble(),
      sugar: (json['sugar'] as num).toDouble(),
      protein: (json['protein'] as num).toDouble(),
    );
  }
}