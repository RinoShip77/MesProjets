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
  static const bool _useMockData = true;
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

  // /// Analyzes a barcode string to identify a product and estimate nutrition.
  // Future<Map<String, dynamic>?> analyseBarcode(
  //   String barcode,
  //   String lang,
  // ) async {
  //   if (_useMockData) return _getMockData();

  //   return _generateAndParse([
  //     Content.text(_Prompts.barcodeAnalysis(barcode, lang)),
  //   ]);
  // }

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
      final mockData = await _getMockData();
      return NutritionalFacts.fromJson(mockData);
    }

    final file = File(imagePath);
    if (!await file.exists()) return null;

    final imageBytes = await file.readAsBytes();
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

// --- Prompts Repository ---
// Kept at the bottom to maintain code readability.
class _Prompts {
  static const _structure = '''
    {
      'foodName': 'string',
      'portionInGrams': 0.0,
      'calories': 0.0,
      'totalFat': 0.0,
      'saturatedFat': 0.0,
      'transFat': 0.0,
      'cholesterol': 0.0,
      'sodium': 0.0,
      'potassium': 0.0,
      'totalCarbohydrates': 0.0,
      'dietaryFiber': 0.0,
      'sugar': 0.0,
      'protein': 0.0
    }
  ''';

  static String barcodeAnalysis(String rawJson, String lang) =>
      '''
    Role: Data Standardizer for Nutrition App.
    Task: Convert the provided RAW PRODUCT DATA into the strict app JSON format.
    
    RAW DATA:
    $rawJson
    
    Rules:
    1. Extract the product Name and Brand from the raw data. Translate to $lang.
    2. Extract Nutrition Facts (calories, protein, carbs, fat). 
       - If exact values are missing in raw data, estimate them based on the Product Name/Ingredients found in the data.
    3. Output JSON ONLY. No Markdown.
    
    Target Structure: $_structure
  ''';

  // static String barcodeAnalysis(String code, String lang) =>
  //     '''
  //   Role: Nutrition Databse. Task: Identify product $code.
  //   Rules:
  //   2. If identified, return exact nutrition.
  //   3. If unknown, estimate based on product type.
  //   4. Language: $lang.
  //   4. Output JSON ONLY. No Markdown.
  //   Structure: $_structure
  // ''';

  static String labelAnalysis(String lang) =>
      '''
    Role: OCR Scanner. Task: Extract nutrition values from image.
    Rules:
    1. Convert all units to g (grams) or mg (milligrams).
    2. Handle "< 1g" as 0.5.
    3. Language: $lang.
    4. Output JSON ONLY. No Markdown.
    Structure: $_structure
  ''';

  static String mealAnalysis(String lang) =>
      '''
    Role: Nutrition Expert. Task: Analyse this meal photo.
    Rules:
    1. Identify the food and estimate portions realistically.
    2. Language: $lang.
    3. Output JSON ONLY. No Markdown.
    Structure: $_structure
  ''';
}
