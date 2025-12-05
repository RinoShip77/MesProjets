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
    Les valeurs doivent être des nombres (double).
    
    Le JSON doit contenir les clés suivantes :
    {
      "foodName": [chaîne de caractères] // Nom de l'aliment analysé (ex: "Salade de poulet et légumes")
      "portionInGrams": [nombre] // NOUVEAU: Estimation de la quantité en grammes (g). Concentre-toi sur l'estimation de la quantité par rapport au récipient ou aux objets de référence visibles (ex: fourchette, bord de l'assiette).
      "calories": [nombre] // EN KCAL
      "totalFat": [nombre] // en g
      "saturatedFat": [nombre] // en g
      "transFat": [nombre] // en g (Utiliser 0 si non estimable)
      "cholesterol": [nombre] // en mg
      "sodium": [nombre] // en mg
      "potassium": [nombre] // en mg
      "totalCarbohydrates": [nombre] // en g
      "dietaryFiber": [nombre] // en g
      "sugar": [nombre] // en g
      "protein": [nombre] // en g
    }
    
    Ne retourne AUCUN texte, explication, ni autre caractère avant ou après le JSON.
    ''';

  Future<NutritionalFacts> analyzeImage(File imageFile) async {
    // Contenu pour l'API Gemini
    final imageBytes = await imageFile.readAsBytes();
    final fullPrompt =
        '$_systemInstruction\n\nAnalyse la valeur nutritive de l\'aliment sur cette image et retourne les résultats en JSON.';
    final promptPart = TextPart(fullPrompt);
    final imagePart = DataPart('image/jpeg', imageBytes);
    final content = Content('user', [promptPart, imagePart]);
    final response = await _model.generateContent([content]);
    final jsonString = response.text?.trim() ?? '';

    if (jsonString.isEmpty) {
      // Retourne un objet d'erreur complet si l'analyse échoue
      return NutritionalFacts(
        foodName: 'Erreur d\'analyse (API vide)',
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

    // // 3. Configurer la génération (GenerationConfig) pour un JSON strict
    // final generationConfig = GenerationConfig(
    //   responseMimeType: 'application/json',
    // );

    // // 4. Exécuter la requête (Le paramètre s'appelle 'generationConfig' dans la fonction)
    // final response = await _model.generateContent(
    //   [content], // <-- Correction : Encapsuler l'objet 'content' dans une liste
    //   generationConfig: generationConfig,
    // );

    // if (jsonString == null || jsonString.isEmpty) {
    //    throw Exception("L'API Gemini n'a retourné aucune donnée textuelle pour l'analyse.");
    // }

    // if (kDebugMode) {
    //   print("Réponse brute de l'IA : $jsonString");
    // }

    // try {
    //   // 6. Convertir la chaîne JSON en Map Dart
    //   final jsonMap = jsonDecode(jsonString) as Map<String, dynamic>;

    //   // 7. Créer notre modèle de données (NutritionalFacts)
    //   return NutritionalFacts.fromJson(jsonMap);

    // } catch (e) {
    //   throw Exception("Erreur lors de l'analyse des données nutritionnelles : $e. Réponse de l'IA non conforme.");
    // }
  }
}
