import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:macro_vision/helpers/helpers.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:macro_vision/models/nutritional_facts.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

/// Exception thrown when API calls are made before initialization.
class NotInitializedError implements Exception {
  @override
  String toString() =>
      '🔴 Error: GeminiService not initialized. Call initialize() in main.';
}

/// Service responsible for all AI interactions.
/// Implements a dynamic factory pattern to select the best model (Speed vs. Intelligence)
/// for the specific task at hand.
class GeminiService {
  // --- Singleton Pattern ---
  GeminiService._internal();
  static final GeminiService _instance = GeminiService._internal();
  factory GeminiService() => _instance;

  // --- Configuration ---
  // Set to 'true' to test. Set 'false' for real AI.
  static const bool _useMockData = false;
  // static const bool _useMockData = (kDebugMode && !kReleaseMode) ? true : false; // Use mock in Debug mode
  GenerativeModel? _model;

  /// Initializes the Gemini Model with the API key.
  /// Must be called in `main.dart` before the app starts.
  void initialize() {
    if (_model != null) return;

    final String apiKey = dotenv.env['GEMINI_API_KEY'] ?? '';
    if (apiKey.isEmpty) {
      debugPrint('🔴 Error: GEMINI_API_KEY is missing in .env file.');
      return;
    }
    _model = GenerativeModel(
      model: 'gemini-2.5-flash', // Flash is chosen for low latency and cost
      apiKey: apiKey,
      generationConfig: GenerationConfig(responseMimeType: 'application/json'),
    );
  }

  // ===========================================================================
  // PUBLIC ANALYSIS METHODS
  // ===========================================================================

  /// Orchestrates the lookup:
  /// 1. Asks OpenFoodFacts for the raw data.
  /// 2. If found, asks Gemini to format it into your strict JSON.
  /// 3. If NOT found, returns null immediately (prevents hallucination).
  Future<Map<String, dynamic>?> analyseBarcode(
    String barcode,
    String lang,
  ) async {
    if (_useMockData) return _getMockData();

    // Step 1: Real Database Lookup
    final rawProductData = await _fetchProduct(barcode);

    // CRITICAL: If the database doesn't know it, Gemini won't either.
    // We return null so your UI can say: "Product not found. Take a photo instead?"
    if (rawProductData == null) {
      return null;
    }

    // Step 2: AI Formatting
    // We send the messy raw data to Gemini to standardize into your App's JSON
    return _generateAndParse([
      Content.text(_Prompts.barcodeAnalysis(jsonEncode(rawProductData), lang)),
    ]);
  }

  /// Private helper to hit the OpenFoodFacts API
  Future<Map<String, dynamic>?> _fetchProduct(String barcode) async {
    try {
      final url = Uri.parse(
        'https://world.openfoodfacts.org/api/v2/product/$barcode.json',
      );
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        // "status" 1 means found, 0 means not found
        if (data['status'] == 1) {
          // We return the specific product object
          return data['product'] as Map<String, dynamic>;
        }
      }
    } catch (e) {
      debugPrint('OpenFoodFacts Error: $e');
    }
    return null;
  }

  /// Performs OCR on a Nutrition Facts label image.
  Future<Map<String, dynamic>?> analyzeLabel(
    Uint8List imageBytes,
    String lang,
  ) async {
    if (_useMockData) return _getMockData();

    return _generateAndParse([
      Content.multi([
        TextPart(_Prompts.labelAnalysis(lang)),
        DataPart('image/jpeg', imageBytes),
      ]),
    ]);
  }

  /// Analyzes a photo of a meal to estimate nutritional content.
  Future<NutritionalFacts?> analyzeImage(String imagePath, String lang) async {
    if (_useMockData) {
      return NutritionalFacts.fromJson(await _getMockData());
    }

    if (!await File(imagePath).exists()) return null;

    final imageBytes = await File(imagePath).readAsBytes();
    final content = [
      Content.multi([
        DataPart('image/jpeg', imageBytes),
        TextPart(_Prompts.mealAnalysis(lang)),
      ]),
    ];

    final data = await _generateAndParse(content);
    return data != null ? NutritionalFacts.fromJson(data) : null;
  }

  // ===========================================================================
  // PRIVATE HELPERS
  // ===========================================================================

  /// Wrapper to handle API calls, errors, and JSON cleaning in one place.
  Future<Map<String, dynamic>?> _generateAndParse(List<Content> content) async {
    if (_model == null) throw NotInitializedError();

    try {
      final response = await _model!.generateContent(content);
      // Use shared helper to strip Markdown and parse JSON
      return cleanAndParseJson(response.text);
    } catch (e) {
      debugPrint('🔴 Gemini API Error: $e');
      return null;
    }
  }

  /// Returns mock data with a realistic delay for UI testing.
  Future<Map<String, dynamic>> _getMockData() async {
    await Future.delayed(const Duration(seconds: 1));
    return mockGeminiResponse;
  }
}

// ===========================================================================
// PROMPT REPOSITORY
// ===========================================================================

/// Contains all prompt templates used by the GeminiService.
class _Prompts {
  /// Target JSON structure for all analyses.
  static const String _structure = '''
    {
      'foodName': 'String',
      'portionInGrams': Double,
      'calories': Double,
      'totalFat': Double,
      'saturatedFat': Double,
      'transFat': Double,
      'cholesterol': Double,
      'sodium': Double,
      'potassium': Double,
      'totalCarbohydrates': Double,
      'dietaryFiber': Double,
      'sugar': Double,
      'protein': Double
    }
  ''';

  /// Generates the prompt for barcode analysis.
  /// Strategy: Don't guess. Read the messy database JSON and clean it up.
  static String barcodeAnalysis(String rawJson, String lang) =>
      '''
    Role: Data Standardizer for Nutrition App.
    Task: Convert the provided RAW PRODUCT DATA into the strict app JSON format.
    
    RAW DATA:
    $rawJson
    
    Rules:
    1. Extract the product Name and Brand from the raw data. Translate to $lang.
    2. Extract Nutrition Facts (quantity for one portion, calories, protein, carbs, fat). 
       - If exact values are missing in raw data, estimate them based on the Product Name/Ingredients found in the data.
    3. Output JSON ONLY. No Markdown.
    
    Target Structure: $_structure
  ''';

  /// Generates the prompt for nutrition label analysis.
  /// Strategy: Trust the text first, use Math (4-4-9 rule) only to repair damage.
  static String labelAnalysis(String lang) =>
      '''
    Role: Expert Nutritionist OCR.
    Task: Extract nutrition facts from this image.
    
    Instructions:
    1. PRIORITIZE VISIBLE TEXT: Trust the numbers you see on the label above all else.
    2. REPAIR DAMAGE: Only if a number is illegible (glare/crease) or missing, estimate it using the 4-4-9 rule (Protein/Carbs*4, Fat*9).
    3. Translate values to $lang.
    4. Normalize to "Per Serving" if possible.
    
    Output JSON ONLY. Structure: $_structure
  ''';

  /// Generates the prompt for meal photo analysis.
  /// Strategy: Deconstruct the meal, check for hidden oils, and reject non-food.
  static String mealAnalysis(String lang) =>
      '''
    Role: Expert AI Dietitian & Chef.
    Task: Analyze the provided image to estimate precise nutritional data.
    
    PHASE 1: VALIDATION
    - Check if the image contains food.
    - If the image is NOT food (e.g., a person, blurry object, room), return JSON with name "Not Food Detected" and all values as 0.
    
    PHASE 2: SPATIAL DECONSTRUCTION
    1. Identify all distinct components (e.g., "150g Steak", "100g Rice").
    2. OIL & GLAZE CHECK: Look for surface sheen/reflection. If present, assume added fats (butter/oil) and increase the Fat/Calorie count accordingly.
    3. VOLUME ESTIMATION: Use the plate size as a reference to estimate portion weight in grams.
    
    PHASE 3: OUTPUT
    - Translate the final Dish Name to $lang.
    - Combine all components into ONE total nutritional profile.
    - Return STRICT JSON only. No Markdown formatting (no ```json).
    
    Target Structure: $_structure
  ''';
}
