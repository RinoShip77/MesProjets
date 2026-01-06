import 'dart:io';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:macro_vision/models/nutritional_facts.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart'; // Pour charger les variables d'environnement

// =========================================================================
// ERREUR PERSONNALISÉE
// =========================================================================
//TODO: Find a way to don't write plain text in the code
class NotInitializedError implements Exception {
  final String message =
      "Le service Gemini n'a pas été initialisé. Assurez-vous d'appeler initialize() dans main.dart.";

  @override
  String toString() => 'NotInitializedError: $message';
}

class GeminiService {
  // Rendre _model nullable et private
  GenerativeModel? _model;
  // late final GenerativeModel _model;

  // Implémentation du pattern Singleton
  GeminiService._internal();
  static final GeminiService _instance = GeminiService._internal();

  // Point d'accès unique
  factory GeminiService() {
    return _instance;
  }

  // Nouvelle méthode d'initialisation à appeler DANS main.dart
  void initialize() {
    if (_model != null) return; // Déjà initialisé

    // Récupérer la clé depuis le fichier .env
    final String apiKey = dotenv.env['GEMINI_API_KEY'] ?? '';

    if (apiKey.isEmpty) {
      throw Exception("Clé API GEMINI non trouvée dans le fichier .env.");
    }

    // Initialisation du modèle
    _model = GenerativeModel(
      model: 'gemini-2.5-flash',
      // *'systemInstruction' est maintenant supporté via GenerationConfig
      apiKey: apiKey,
    );
  }

  Future<Map<String, dynamic>?> getInfoFromBarcode(
    String barcode,
    String languageCode,
  ) async {
    final prompt =
        """
    L'utilisateur a scanné le code-barres suivant : $barcode.
    1. Identifie le produit correspondant à ce code EAN.
    2. Fournis les informations nutritionnelles pour 100g :
       - Calories (kcal)
       - Protéines (g)
       - Glucides (g)
       - Lipides (g)
    
    Réponds EXCLUSIVEMENT sous ce format JSON :
    {
      "productName": "Nom du produit",
      "calories": 0.0,
      "proteins": 0.0,
      "carbs": 0.0,
      "fat": 0.0
    }
    Langue de réponse : $languageCode.
    Si tu ne connais pas le produit, réponds "null".
  """;

    try {
      // On utilise generateContent sans image cette fois, juste le texte
      final response = await _model!.generateContent([Content.text(prompt)]);

      final text = response.text ?? "";
      if (text.contains("null")) return null;

      final jsonStart = text.indexOf('{');
      final jsonEnd = text.lastIndexOf('}') + 1;
      final jsonString = text.substring(jsonStart, jsonEnd);

      return jsonDecode(jsonString) as Map<String, dynamic>;
    } catch (e) {
      debugPrint("Erreur Gemini Barcode: $e");
      return null;
    }
  }

  Future<Map<String, dynamic>?> analyzeNutritionTable(
    Uint8List imageBytes,
    String languageCode,
  ) async {
    final prompt =
        """
    Analyse cette image d'un tableau nutritionnel.
    Extrais les valeurs suivantes pour 100g ou par portion (précise l'unité) :
    - Calories (cal)
    - Protéines (g)
    - Glucides (g)
    - Lipides (g)
    
    Réponds EXCLUSIVEMENT sous ce format JSON :
    {
      "calories": 0.0,
      "proteins": 0.0,
      "carbs": 0.0,
      "fat": 0.0,
      "servingSize": "100g"
    }
    Langue de l'utilisateur : $languageCode.
  """;

    try {
      final response = await _model!.generateContent([
        Content.multi([TextPart(prompt), DataPart('image/jpeg', imageBytes)]),
      ]);

      // Nettoyage de la réponse pour ne garder que le JSON
      final text = response.text ?? "";
      final jsonStart = text.indexOf('{');
      final jsonEnd = text.lastIndexOf('}') + 1;
      final jsonString = text.substring(jsonStart, jsonEnd);

      return jsonDecode(jsonString) as Map<String, dynamic>;
    } catch (e) {
      debugPrint("Erreur lors de l'analyse du tableau: $e");
      return null;
    }
  }

  Future<NutritionalFacts> analyzeImage(
    String imagePath,
    String languageCode,
  ) async {
    // Le prompt système mis à jour (Prompt 2.2)
    final String systemInstruction = '''
    Tu es un expert en nutrition. Ton rôle est d'analyser l'image d'un plat ou d'aliments 
    et d'estimer les valeurs nutritionnelles pour l'ensemble du contenu visible.
    
    Tu DOIS retourner UNIQUEMENT un objet JSON strictement formaté selon le schéma ci-dessous. 
    Les valeurs doivent être des nombres (double) SAUF la première. L'objet JSONS doit contenir les clés suivantes :
    {
      "foodName": [chaîne de caractères EN FRANÇAIS]
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

    // Vérification de sécurité (essentielle)
    if (_model == null) {
      throw NotInitializedError();
    }

    // Contenu pour l'API Gemini
    // 1. Lire le fichier image en tant que bytes
    final imageFile = File(imagePath);
    if (!await imageFile.exists()) {
      throw Exception("Le fichier image n'existe pas : $imagePath");
    }
    final imageBytes = await imageFile.readAsBytes();

    // 2. Préparer les contenus de la requête
    final imagePart = DataPart('image/jpeg', imageBytes);

    // Ajout d'une requête utilisateur générique pour une analyse alimentaire
    final userPrompt = TextPart('''
    Tu es un expert en nutrition. Ton rôle est d'analyser l'image d'un plat ou d'aliments et d'estimer les valeurs
    nutritionnelles pour l'ensemble du contenu visible. Ta réponse doit être intégralement en $languageCode. Tu
    DOIS retourner UNIQUEMENT un objet JSON strictement formaté selon le schéma ci-dessous. Les valeurs doivent
    être des nombres (double) SAUF la première. La réponse en avec UNIQUEMENT l'objet JSON doit contenir les clés
    suivantes :
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
    ''');

    final contents = [
      Content('user', [imagePart, userPrompt]),
    ];

    // 3. Configurer la génération (GenerationConfig) pour un JSON strict
    final generationConfig = GenerationConfig(
      responseMimeType: 'application/json',
    );

    // // Créer un Content pour l'instruction système
    // final systemContent = Content.system(_systemInstruction);

    // // Ajouter l'instruction système au début des contenus de la requête
    // final fullContents = [systemContent, ...content];

    // 4. Exécuter la requête
    final response = await _model!.generateContent(
      contents, // Utiliser la liste complète incluant l'instruction système
      generationConfig: generationConfig,
    );
    // final imageBytes = await compute(_readFileBytes, imagePath);
    // final response = await _model.generateContent(
    //   [Content('user', [TextPart(_systemInstruction), DataPart('image/jpeg', imageBytes)])],
    //   generationConfig: GenerationConfig(responseMimeType: 'application/json'),
    // );

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

    if (kDebugMode) {
      print("Réponse nettoyée de l'IA : $cleanedJson");
    }

    try {
      // Tenter de décoder le JSON et de le convertir en objet Dart
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
}
