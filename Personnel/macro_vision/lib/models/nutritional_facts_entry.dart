import 'nutritional_facts.dart';

class NutritionalFactsEntry extends NutritionalFacts {
  final int? id; // ID unique dans la BDD (peut être null avant l'insertion)
  final int timestamp; // Date et heure de l'analyse (stockée en millisecondes)
  final String imagePath; // Chemin local de la photo

  NutritionalFactsEntry({
    this.id,
    required this.timestamp,
    required this.imagePath,
    required super.foodName,
    required super.calories,
    required super.totalFat,
    required super.saturatedFat,
    required super.transFat,
    required super.cholesterol,
    required super.sodium,
    required super.potassium,
    required super.totalCarbohydrates,
    required super.dietaryFiber,
    required super.sugar,
    required super.protein
  });
  
  // Créer à partir d'un résultat d'analyse + le chemin de la photo
  factory NutritionalFactsEntry.fromAnalysis(NutritionalFacts facts, String path) {
    return NutritionalFactsEntry(
      timestamp: DateTime.now().millisecondsSinceEpoch,
      imagePath: path,
      foodName: facts.foodName,
      calories: facts.calories,
      totalFat: facts.totalFat,
      saturatedFat: facts.saturatedFat,
      transFat: facts.transFat,
      cholesterol: facts.cholesterol,
      sodium: facts.sodium,
      potassium: facts.potassium,
      totalCarbohydrates: facts.totalCarbohydrates,
      dietaryFiber: facts.dietaryFiber,
      sugar: facts.sugar,
      protein: facts.protein
    );
  }

  // Convertir en Map pour l'insertion dans la BDD
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'timestamp': timestamp,
      'foodName': foodName,
      'calories': calories,
      'totalFat': totalFat,
      'saturatedFat': saturatedFat,
      'transFat': transFat,
      'cholesterol': cholesterol,
      'sodium': sodium,
      'potassium': potassium,
      'totalCarbohydrates': totalCarbohydrates,
      'dietaryFiber': dietaryFiber,
      'sugar': sugar,
      'protein': protein,
      'imagePath': imagePath,
    };
  }

  // Créer à partir d'une Map lue dans la BDD
  factory NutritionalFactsEntry.fromMap(Map<String, dynamic> map) {
    return NutritionalFactsEntry(
      id: map['id'],
      timestamp: map['timestamp'],
      imagePath: map['imagePath'],
      foodName: map['foodName'],
      calories: map['calories'],
      totalFat: map['totalFat'],
      saturatedFat: map['saturatedFat'],
      transFat: map['transFat'],
      cholesterol: map['cholesterol'],
      sodium: map['sodium'],
      potassium: map['potassium'],
      totalCarbohydrates: map['totalCarbohydrates'],
      dietaryFiber: map['dietaryFiber'],
      sugar: map['sugar'],
      protein: map['protein'],
    );
  }
}