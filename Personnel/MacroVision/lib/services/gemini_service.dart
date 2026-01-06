import 'dart:io';
import 'dart:convert';
import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:macro_vision/models/nutritional_facts.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class NotInitializedError implements Exception {
  @override
  String toString() =>
      'GeminiService not initialized. Call initialize() in main.';
}

class GeminiService {
  // Set to 'true' to test. Set 'false' for real AI.
  static const bool useMockData = (kDebugMode && !kReleaseMode) ? true : false;
  GenerativeModel? _model;

  GeminiService._internal();
  static final GeminiService _instance = GeminiService._internal();
  factory GeminiService() => _instance;

  void initialize() {
    if (_model != null) return;
    final String apiKey = dotenv.env['GEMINI_API_KEY'] ?? '';
    if (apiKey.isEmpty) throw Exception("GEMINI_API_KEY missing in .env");

    _model = GenerativeModel(
      model:
          'gemini-2.5-flash', // Optimization: Flash is faster/cheaper for this logic
      apiKey: apiKey,
      // generationConfig: GenerationConfig(responseMimeType: 'application/json'),
    );
  }

  // --- API Methods ---

  Future<Map<String, dynamic>?> getInfoFromBarcode(
    String barcode,
    String lang,
  ) async {
    if (useMockData) return _getMockData();

    try {
      final prompt = _Prompts.barcode(barcode, lang);
      return _generateAndParse([Content.text(prompt)]);
    } catch (e) {
      debugPrint("Gemini Barcode Error: $e");
      return null;
    }

    //   final promptText =
    //       """
    //   Agis comme un expert en nutrition et une base de données de produits alimentaires.

    //   Tâche : Identifie le produit correspondant au code-barres suivant : "$barcode".

    //   Règles strictes :
    //   1. Si tu identifies le produit, fournis ses informations nutritionnelles.
    //   2. Si tu ne trouves pas le produit exact, essaie de déduire le type de produit (ex: "Soda Cola", "Barre céréale") et fournis des valeurs moyennes estimées pour ce type de produit.
    //   3. Traduis le 'foodName' en langue : "$lang".
    //   4. Réponds UNIQUEMENT en format JSON brut. Pas de Markdown (```json), pas de texte avant ou après.

    //   Structure JSON attendue (valeurs numériques (double) pour les nutriments, 0.0 si inconnu) :
    //   {
    //     "foodName": "Nom du produit",
    //     "portionInGrams": 100.0,
    //     "calories": 0.0,
    //     "totalFat": 0.0,
    //     "saturatedFat": 0.0,
    //     "transFat": 0.0,
    //     "cholesterol": 0.0,
    //     "sodium": 0.0,
    //     "potassium": 0.0,
    //     "totalCarbohydrates": 0.0,
    //     "dietaryFiber": 0.0,
    //     "sugar": 0.0,
    //     "protein": 0.0
    //   }

    //   Si le code-barres est invalide ou que tu ne peux absolument pas identifier le type d'aliment, renvoie simplement : null
    // """;

    //   try {
    //   final content = [Content.text(promptText)];
    //   final response = await _model!.generateContent(
    //     content,
    //   );

    //   final String? text = response.text;

    //   if (text == null || text.trim().toLowerCase() == 'null') {
    //     return null;
    //   }

    //   // 3. Nettoyage de la réponse (Gemini aime bien ajouter des balises Markdown)
    //   String cleanedJson = text
    //       .replaceAll('```json', '')
    //       .replaceAll('```', '')
    //       .trim();

    //   // 4. Parsing et validation
    //   final Map<String, dynamic> data = jsonDecode(cleanedJson);

    //   // Petit fix de sécurité : s'assurer que portionInGrams n'est pas 0 pour éviter les divisions par zéro plus tard
    //   if ((data['portionInGrams'] as num?) == 0) {
    //     data['portionInGrams'] = 100.0; // Valeur par défaut standard
    //   }

    //   return data;
    // } catch (e) {
    //   // En cas d'erreur de parsing ou de réseau
    //   print("Gemini Barcode Error: $e");
    //   return null;
    // }
  }

  Future<Map<String, dynamic>?> analyzeNutritionTable(
    Uint8List imageBytes,
    String lang,
  ) async {
    if (useMockData) return _getMockData();

    try {
      final prompt = _Prompts.nutritionTable(lang);
      final content = [
        Content.multi([TextPart(prompt), DataPart('image/jpeg', imageBytes)]),
      ];

      return _generateAndParse(content);
    } catch (e) {
      debugPrint("Gemini nutrition label Error: $e");
      return null;
    }

    //   if (useMockData) {
    //     await Future.delayed(const Duration(seconds: 1));

    //     // On retourne la structure exacte que vous avez demandée
    //     return {
    //       "foodName": "Barre Granola Miel & Amandes (Mock)",
    //       "portionInGrams": 42.0,
    //       "calories": 190.0,
    //       "totalFat": 6.0,
    //       "saturatedFat": 1.0,
    //       "transFat": 0.0,
    //       "cholesterol": 0.0,
    //       "sodium": 140.0,
    //       "potassium": 95.0,
    //       "totalCarbohydrates": 29.0,
    //       "dietaryFiber": 2.0,
    //       "sugar": 11.0,
    //       "protein": 3.0,
    //     };
    //   }

    //   // 1. Le Prompt spécialisé "Vision"
    //   final promptText =
    //       """
    //   Analyse cette image de tableau de valeur nutritive (Nutrition Facts).

    //   Tâche : Extrais les valeurs numériques pour chaque nutriment.

    //   Règles strictes :
    //   1. Réponds UNIQUEMENT en format JSON brut. Pas de Markdown, pas de texte.
    //   2. Convertis toutes les unités en Grammes (g) ou Milligrammes (mg) selon le standard ci-dessous.
    //   3. Si une valeur est "moins de 1g" (< 1g), mets 0.5. Si c'est "0g", mets 0.0.
    //   4. Pour 'foodName', essaie de lire le titre du produit s'il est visible au-dessus du tableau. Sinon, utilise "Aliment Scanné". Traduis-le en "$languageCode".
    //   5. Pour 'portionInGrams' : Cherche la taille de la portion (Serving Size) indiquée (ex: "Per 1 cup (228g)"). Extrais UNIQUEMENT le chiffre en grammes (ex: 228.0). Si ce n'est pas indiqué en grammes, estime une conversion ou mets 100.0 par défaut.

    //   Structure JSON attendue (respecte exactement ces clés) :
    //   {
    //     "foodName": "Nom détecté ou générique",
    //     "portionInGrams": 0.0,
    //     "calories": 0.0,    // Calories (pas kCal, juste le chiffre)
    //     "totalFat": 0.0,    // en grammes (g)
    //     "saturatedFat": 0.0,// en grammes (g)
    //     "transFat": 0.0,    // en grammes (g)
    //     "cholesterol": 0.0, // en milligrammes (mg)
    //     "sodium": 0.0,      // en milligrammes (mg)
    //     "potassium": 0.0,   // en milligrammes (mg)
    //     "totalCarbohydrates": 0.0, // en grammes (g)
    //     "dietaryFiber": 0.0,       // en grammes (g)
    //     "sugar": 0.0,              // en grammes (g)
    //     "protein": 0.0             // en grammes (g)
    //   }
    // """;

    //   try {
    //     // 2. Construction de la requête Multimodale (Texte + Image)
    //     final content = [
    //       Content.multi([
    //         TextPart(promptText),
    //         DataPart('image/jpeg', imageBytes), // On envoie l'image brute
    //       ]),
    //     ];

    //     // Note: Assurez-vous d'utiliser un modèle capable de vision (ex: gemini-1.5-flash ou gemini-pro-vision)
    //     final response = await _model!.generateContent(content);

    //     final String? text = response.text;

    //     if (text == null) return null;

    //     // 3. Nettoyage (Gemini met souvent ```json ... ```)
    //     String cleanedJson = text
    //         .replaceAll('```json', '')
    //         .replaceAll('```', '')
    //         .trim();

    //     // 4. Décodage
    //     final Map<String, dynamic> data = jsonDecode(cleanedJson);

    //     // Validation de sécurité pour la portion
    //     if ((data['portionInGrams'] as num?) == 0) {
    //       data['portionInGrams'] = 100.0; // Fallback sécurité
    //     }

    //     return data;
    //   } catch (e) {
    //     print("Gemini Vision Error: $e");
    //     return null;
    //   }
  }

  Future<NutritionalFacts?> analyzeImage(String imagePath, String lang) async {
    if (useMockData) {
      final mockMap = await _getMockData();
      return NutritionalFacts.fromJson(mockMap);
    }

    if (_model == null) throw NotInitializedError();

    final imageFile = File(imagePath);
    if (!await imageFile.exists()) return null;

    final imageBytes = await imageFile.readAsBytes();
    final prompt = _Prompts.mealAnalysis(lang);

    final content = [
      Content.multi([DataPart('image/jpeg', imageBytes), TextPart(prompt)]),
    ];

    final data = await _generateAndParse(content);

    if (data == null) return null;
    return NutritionalFacts.fromJson(data);

    //   // 1. DÉTECTION DU MODE MOCK
    //   if (useMockData) {
    //     print("⚠️ MODE MOCK ACTIVÉ : Aucune requête API envoyée.");

    //     // On simule un délai de 2 secondes pour tester votre loader/spinner
    //     await Future.delayed(const Duration(seconds: 2));

    //     // On retourne une fausse réponse parfaite
    //     return NutritionalFacts(
    //       foodName: "Barre Granola Miel & Amandes (Mock)",
    //       portionInGrams: 42.0,
    //       calories: 190.0,
    //       totalFat: 6.0,
    //       saturatedFat: 1.0,
    //       transFat: 0.0,
    //       cholesterol: 0.0,
    //       sodium: 140.0,
    //       potassium: 95.0,
    //       totalCarbohydrates: 29.0,
    //       dietaryFiber: 2.0,
    //       sugar: 11.0,
    //       protein: 3.0,
    //     );
    //   }

    //   // Le prompt système mis à jour (Prompt 2.2)
    //   final String systemInstruction = '''
    //   Tu es un expert en nutrition. Ton rôle est d'analyser l'image d'un plat ou d'aliments
    //   et d'estimer les valeurs nutritionnelles pour l'ensemble du contenu visible.

    //   Tu DOIS retourner UNIQUEMENT un objet JSON strictement formaté selon le schéma ci-dessous.
    //   Les valeurs doivent être des nombres (double) SAUF la première. L'objet JSONS doit contenir les clés suivantes :
    //   {
    //     "foodName": [chaîne de caractères]
    //     "portionInGrams": [nombre]
    //     "calories": [nombre]
    //     "totalFat": [nombre]
    //     "saturatedFat": [nombre]
    //     "transFat": [nombre]
    //     "cholesterol": [nombre]
    //     "sodium": [nombre]
    //     "potassium": [nombre]
    //     "totalCarbohydrates": [nombre]
    //     "dietaryFiber": [nombre]
    //     "sugar": [nombre]
    //     "protein": [nombre]
    //   }
    // ''';

    //   // Vérification de sécurité (essentielle)
    //   if (_model == null) {
    //     throw NotInitializedError();
    //   }

    //   // Contenu pour l'API Gemini
    //   // 1. Lire le fichier image en tant que bytes
    //   final imageFile = File(imagePath);
    //   if (!await imageFile.exists()) {
    //     throw Exception("Le fichier image n'existe pas : $imagePath");
    //   }
    //   final imageBytes = await imageFile.readAsBytes();

    //   // 2. Préparer les contenus de la requête
    //   final imagePart = DataPart('image/jpeg', imageBytes);

    //   // Ajout d'une requête utilisateur générique pour une analyse alimentaire
    //   final userPrompt = TextPart('''
    //   Tu es un expert en nutrition. Ton rôle est d'analyser l'image d'un plat ou d'aliments et d'estimer les valeurs
    //   nutritionnelles pour l'ensemble du contenu visible. Tu
    //   DOIS retourner UNIQUEMENT un objet JSON strictement formaté selon le schéma ci-dessous. Les valeurs doivent
    //   être des nombres (double) SAUF la première. La réponse en avec UNIQUEMENT l'objet JSON doit contenir les clés
    //   suivantes :
    //   {
    //     "foodName": [chaîne de caractères]
    //     "portionInGrams": [nombre]
    //     "calories": [nombre]
    //     "totalFat": [nombre]
    //     "saturatedFat": [nombre]
    //     "transFat": [nombre]
    //     "cholesterol": [nombre]
    //     "sodium": [nombre]
    //     "potassium": [nombre]
    //     "totalCarbohydrates": [nombre]
    //     "dietaryFiber": [nombre]
    //     "sugar": [nombre]
    //     "protein": [nombre]
    //   }
    //   Langue de réponse : $lang.
    //   ''');

    //   final contents = [
    //     Content('user', [imagePart, userPrompt]),
    //   ];

    //   // 3. Configurer la génération (GenerationConfig) pour un JSON strict
    //   final generationConfig = GenerationConfig(
    //     responseMimeType: 'application/json',
    //   );

    //   // // Créer un Content pour l'instruction système
    //   // final systemContent = Content.system(_systemInstruction);

    //   // // Ajouter l'instruction système au début des contenus de la requête
    //   // final fullContents = [systemContent, ...content];

    //   // 4. Exécuter la requête
    //   final response = await _model!.generateContent(
    //     contents, // Utiliser la liste complète incluant l'instruction système
    //     generationConfig: generationConfig,
    //   );
    //   // final imageBytes = await compute(_readFileBytes, imagePath);
    //   // final response = await _model.generateContent(
    //   //   [Content('user', [TextPart(_systemInstruction), DataPart('image/jpeg', imageBytes)])],
    //   //   generationConfig: GenerationConfig(responseMimeType: 'application/json'),
    //   // );

    //   final jsonString = response.text?.trim() ?? '';

    //   if (jsonString.isEmpty) {
    //     return NutritionalFacts(
    //       foodName: 'Erreur d\'analyse (réponse vide)',
    //       portionInGrams: 0.0,
    //       calories: 0.0,
    //       totalFat: 0.0,
    //       saturatedFat: 0.0,
    //       transFat: 0.0,
    //       cholesterol: 0.0,
    //       sodium: 0.0,
    //       potassium: 0.0,
    //       totalCarbohydrates: 0.0,
    //       dietaryFiber: 0.0,
    //       sugar: 0.0,
    //       protein: 0.0,
    //     );
    //   }

    //   String cleanedJson = jsonString;
    //   if (cleanedJson.startsWith('```json')) {
    //     cleanedJson = cleanedJson.substring(7);
    //   }
    //   if (cleanedJson.endsWith('```')) {
    //     cleanedJson = cleanedJson.substring(0, cleanedJson.length - 3);
    //   }
    //   cleanedJson = cleanedJson.trim();

    //   if (kDebugMode) {
    //     print("Réponse nettoyée de l'IA : $cleanedJson");
    //   }

    //   try {
    //     // Tenter de décoder le JSON et de le convertir en objet Dart
    //     final jsonMap = jsonDecode(cleanedJson) as Map<String, dynamic>;

    //     return NutritionalFacts.fromJson(jsonMap);
    //   } catch (e) {
    //     if (kDebugMode) {
    //       print("Erreur de décodage JSON : $e");
    //     }
    //     return NutritionalFacts(
    //       foodName: 'Erreur d\'analyse (JSON non conforme)',
    //       portionInGrams: 0.0,
    //       calories: 0.0,
    //       totalFat: 0.0,
    //       saturatedFat: 0.0,
    //       transFat: 0.0,
    //       cholesterol: 0.0,
    //       sodium: 0.0,
    //       potassium: 0.0,
    //       totalCarbohydrates: 0.0,
    //       dietaryFiber: 0.0,
    //       sugar: 0.0,
    //       protein: 0.0,
    //     );
    //   }
  }

  // --- Helpers ---

  /// Core execution logic: Sends request -> Cleans JSON -> Decodes
  Future<Map<String, dynamic>?> _generateAndParse(List<Content> content) async {
    try {
      if (_model == null) throw NotInitializedError();

      final response = await _model!.generateContent(content);
      return _cleanAndParseJson(response.text);
    } catch (e) {
      debugPrint("🔴 Gemini API Error: $e");
      return null;
    }
  }

  Map<String, dynamic>? _cleanAndParseJson(String? rawText) {
    if (rawText == null || rawText.isEmpty) return null;

    try {
      // Remove Markdown blocks (```json ... ```)
      String clean = rawText.replaceAll(RegExp(r'^```json|```$'), '').trim();

      // If the regex didn't catch trailing/leading ticks due to whitespace
      clean = clean.replaceAll('```json', '').replaceAll('```', '').trim();

      final Map<String, dynamic> data = jsonDecode(clean);

      // Safety: Normalize portion size
      if ((data['portionInGrams'] as num?) == 0) {
        data['portionInGrams'] = 100.0;
      }
      return data;
    } catch (e) {
      debugPrint("🔴 JSON Parsing Error: $e");
      return null;
    }
  }

  Future<Map<String, dynamic>> _getMockData() async {
    debugPrint("⚠️ Using MOCK Data");
    await Future.delayed(const Duration(seconds: 1));
    return {
      "foodName": "Barre Granola Mock",
      "portionInGrams": 42.0,
      "calories": 190.0,
      "totalFat": 6.0,
      "saturatedFat": 1.0,
      "transFat": 0.0,
      "cholesterol": 0.0,
      "sodium": 140.0,
      "potassium": 95.0,
      "totalCarbohydrates": 29.0,
      "dietaryFiber": 2.0,
      "sugar": 11.0,
      "protein": 3.0,
    };
  }
}

// --- Static Prompts (Moved to bottom for readability) ---
class _Prompts {
  static const _jsonStructure = '''
    {
      "foodName": "string",
      "portionInGrams": 0.0,
      "calories": 0.0,
      "totalFat": 0.0,
      "saturatedFat": 0.0,
      "transFat": 0.0,
      "cholesterol": 0.0,
      "sodium": 0.0,
      "potassium": 0.0,
      "totalCarbohydrates": 0.0,
      "dietaryFiber": 0.0,
      "sugar": 0.0,
      "protein": 0.0
    }
  ''';

  static String barcode(String code, String lang) =>
      """
    Role: Nutrition Database. Task: Identify product "$code".
    Rules:
    1. If identified, provide exact nutrition.
    2. If not found, estimate based on product type (e.g., "Cola").
    3. Translate 'foodName' to "$lang".
    4. JSON ONLY. No Markdown.
    Structure: $_jsonStructure
  """;

  static String nutritionTable(String lang) =>
      """
    Role: OCR. Task: Extract nutrition values from this label image.
    Rules:
    1. JSON ONLY. No text.
    2. Convert units to g or mg.
    3. "< 1g" = 0.5. "0g" = 0.0.
    4. Translate 'foodName' to "$lang".
    5. Extract 'portionInGrams' strictly from Serving Size. Default 100.0 if missing.
    Structure: $_jsonStructure
  """;

  static String mealAnalysis(String lang) =>
      """
    Role: Nutrition Expert. Task: Estimate nutrition for the food visible in this image.
    Rules:
    1. JSON ONLY.
    2. Values are doubles.
    3. Language: $lang.
    Structure: $_jsonStructure
  """;
}
