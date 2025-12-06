import 'dart:io';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:macro_vision/models/nutritional_facts.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart'; // Pour charger les variables d'environnement

class GeminiService {
  late final GenerativeModel _model;

  GeminiService() {
    // Récupérer la clé depuis le fichier .env
    final String apiKey = dotenv.env['GEMINI_API_KEY'] ?? '';

    // Vérification simple (optionnel mais recommandé)
    if (apiKey.isEmpty) {
      throw Exception("Clé API GEMINI non trouvée dans le fichier .env.");
    }

    // Le constructeur GenerativeModel est correct
    _model = GenerativeModel(
      model: 'gemini-2.5-flash',
      apiKey: apiKey, // Utilisation de la clé API chargée depuis .env
    );
  }

  // Le prompt système mis à jour (Prompt 2.2)
  final String _systemInstruction = '''
    Tu es un expert en nutrition. Ton rôle est d'analyser l'image d'un plat ou d'aliments 
    et d'estimer les valeurs nutritionnelles pour l'ensemble du contenu visible.
    
    Tu DOIS retourner UNIQUEMENT un objet JSON strictement formaté selon le schéma ci-dessous. 
    Les valeurs doivent être des nombres (double) SAUF la première. L'objet JSONS doit contenir les clés suivantes :
    {
      "foodName": [chaîne de caractères]
      "portionInGrams": [nombre]
      "calories": [nombre]
      "totalFat": [nombre]
      "saturatedFat": [nombre]
      "transFat": [nombre]
      "cholesterol": [nombre]
      "sodium": [nombre]
      "potassium": [nombre]
      "totalCarbohydrates": [nombre]
      "dietaryFiber": [nombre]
      "sugar": [nombre]
      "protein": [nombre]
    }
  ''';

  Future<NutritionalFacts> analyzeImage(String imagePath) async {
    // Contenu pour l'API Gemini
    final imageBytes = await compute(_readFileBytes, imagePath);
    final response = await _model.generateContent(
      [Content('user', [TextPart(_systemInstruction), DataPart('image/jpeg', imageBytes)])],
      generationConfig: GenerationConfig(responseMimeType: 'application/json'),
    );

    final jsonString = response.text?.trim() ?? '';

    if (jsonString.isEmpty) {
      return NutritionalFacts(
        foodName: 'Erreur d\'analyse (réponse vide)',
        portionInGrams: 0.0,
        calories: 0.0,
        totalFat: 0.0,
        saturatedFat: 0.0,
        transFat: 0.0,
        cholesterol: 0.0,
        sodium: 0.0,
        potassium: 0.0,
        totalCarbohydrates: 0.0,
        dietaryFiber: 0.0,
        sugar: 0.0,
        protein: 0.0,
      );
    }

    String cleanedJson = jsonString;
    if (cleanedJson.startsWith('```json')) {
      cleanedJson = cleanedJson.substring(7);
    }
    if (cleanedJson.endsWith('```')) {
      cleanedJson = cleanedJson.substring(0, cleanedJson.length - 3);
    }
    cleanedJson = cleanedJson.trim();

    try {
      final jsonMap = jsonDecode(cleanedJson) as Map<String, dynamic>;
      
      return NutritionalFacts.fromJson(jsonMap);
    } catch (e) {
      if (kDebugMode) {
        print("Erreur de décodage JSON : $e");
      }
      return NutritionalFacts(
        foodName: 'Erreur d\'analyse (JSON non conforme)',
        portionInGrams: 0.0,
        calories: 0.0,
        totalFat: 0.0,
        saturatedFat: 0.0,
        transFat: 0.0,
        cholesterol: 0.0,
        sodium: 0.0,
        potassium: 0.0,
        totalCarbohydrates: 0.0,
        dietaryFiber: 0.0,
        sugar: 0.0,
        protein: 0.0,
      );
    }
  }

  Future<Uint8List> _readFileBytes(String path) async {
    return File(path).readAsBytes();
  }
}
