import 'dart:io';
import 'dart:convert';
import 'package:flutter/foundation.dart';
// Note: Le code ci-dessous est compatible avec la version 0.4.7 du package
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

    _model = GenerativeModel(
      model: 'gemini-2.5-flash', 
      apiKey: apiKey, // Utilisation de la clé API chargée depuis .env
    );
  }
  
  // Le prompt système pour forcer l'IA à retourner UNIQUEMENT du JSON
  // NOTE: Dans 0.4.7, ceci sera intégré au début du prompt principal.
  final String _systemInstruction = '''
    Tu es un expert en nutrition. Ton rôle est d'analyser l'image d'un plat ou d'aliments 
    et d'estimer les valeurs nutritionnelles pour l'ensemble du contenu visible.
    
    Tu DOIS retourner UNIQUEMENT un objet JSON strictement formaté selon le schéma ci-dessous. 
    Les valeurs doivent être des nombres (double).
    
    Le JSON doit contenir les clés suivantes, avec des estimations basées sur une portion typique :
    {
      "foodName": [chaîne de caractères] // NOUVEAU : Nom de l'aliment analysé (ex: "Salade de poulet et légumes")
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
    // 1. Lire le fichier image en tant que bytes
    final imageBytes = await imageFile.readAsBytes();
    
    // 2. Préparer le contenu pour l'API Gemini (Syntaxe 0.4.7)
    
    // Concaténer l'instruction système avec le prompt de requête
    final fullPrompt = '$_systemInstruction\n\nAnalyse la valeur nutritive de l\'aliment sur cette image et retourne les résultats en JSON.';
    
    // Créer les Parts (objets textes et data)
    final promptPart = TextPart(fullPrompt);
    final imagePart = DataPart('image/jpeg', imageBytes);

    // Regrouper les parts dans un objet Content (CORRECTION ICI !)
    final content = Content('user', [promptPart, imagePart]); // <-- Correction : rôle 'user' requis comme premier argument

    // 3. Configurer la génération (GenerationConfig) pour un JSON strict
    final generationConfig = GenerationConfig(
      responseMimeType: 'application/json',
    );

    // 4. Exécuter la requête (Le paramètre s'appelle 'generationConfig' dans la fonction)
    final response = await _model.generateContent(
      [content], // <-- Correction : Encapsuler l'objet 'content' dans une liste
      generationConfig: generationConfig,
    );

    // 5. Traitement de la réponse
    final jsonString = response.text?.trim();
    
    if (jsonString == null || jsonString.isEmpty) {
       throw Exception("L'API Gemini n'a retourné aucune donnée textuelle pour l'analyse.");
    }
    
    if (kDebugMode) {
      print("Réponse brute de l'IA : $jsonString");
    }
    
    try {
      // 6. Convertir la chaîne JSON en Map Dart
      final jsonMap = jsonDecode(jsonString) as Map<String, dynamic>;
      
      // 7. Créer notre modèle de données (NutritionalFacts)
      return NutritionalFacts.fromJson(jsonMap);
      
    } catch (e) {
      throw Exception("Erreur lors de l'analyse des données nutritionnelles : $e. Réponse de l'IA non conforme.");
    }
  }
}