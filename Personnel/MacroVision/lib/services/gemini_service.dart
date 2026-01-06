import 'dart:io';
import 'dart:convert';
import 'dart:async';
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
  // Mettez 'true' pour tester. Mettez 'false' pour la vraie IA.
  static const bool useMockData = true;
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
    // 1. MODE MOCK (Simulation pour économiser le quota)
    if (useMockData) {
      debugPrint("⚠️ API BARCODE MOCK : Réponse simulée pour $barcode");
      await Future.delayed(const Duration(seconds: 1)); // Petit délai réaliste

      // On retourne la structure exacte que vous avez demandée
      return {
        "foodName": "Barre Granola Miel & Amandes (Mock)",
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

    // 1. Définition du Prompt Strict
    // On liste EXPLICITEMENT les clés attendues par votre NutritionalFacts.fromJson
    final promptText =
        """
    Agis comme un expert en nutrition et une base de données de produits alimentaires.
    
    Tâche : Identifie le produit correspondant au code-barres suivant : "$barcode".
    
    Règles strictes :
    1. Si tu identifies le produit, fournis ses informations nutritionnelles.
    2. Si tu ne trouves pas le produit exact, essaie de déduire le type de produit (ex: "Soda Cola", "Barre céréale") et fournis des valeurs moyennes estimées pour ce type de produit.
    3. Traduis le 'foodName' en langue : "$languageCode".
    4. Réponds UNIQUEMENT en format JSON brut. Pas de Markdown (```json), pas de texte avant ou après.
    
    Structure JSON attendue (valeurs numériques (double) pour les nutriments, 0.0 si inconnu) :
    {
      "foodName": "Nom du produit",
      "portionInGrams": 100.0, 
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
    
    Si le code-barres est invalide ou que tu ne peux absolument pas identifier le type d'aliment, renvoie simplement : null
  """;

    try {
      // 2. Envoi à l'API (Utilisation de votre instance de modèle existante)
      // Note : Pour du texte seul, utilisez votre modèle 'gemini-pro' ou équivalent
      // Si vous utilisez 'gemini-pro-vision' pour tout, vous pouvez aussi lui envoyer du texte seul.
      final content = [Content.text(promptText)];
      final response = await _model!.generateContent(
        content,
      ); // _model est votre instance GenerativeModel

      final String? text = response.text;

      if (text == null || text.trim().toLowerCase() == 'null') {
        return null;
      }

      // 3. Nettoyage de la réponse (Gemini aime bien ajouter des balises Markdown)
      String cleanedJson = text
          .replaceAll('```json', '')
          .replaceAll('```', '')
          .trim();

      // 4. Parsing et validation
      final Map<String, dynamic> data = jsonDecode(cleanedJson);

      // Petit fix de sécurité : s'assurer que portionInGrams n'est pas 0 pour éviter les divisions par zéro plus tard
      if ((data['portionInGrams'] as num?) == 0) {
        data['portionInGrams'] = 100.0; // Valeur par défaut standard
      }

      return data;
    } catch (e) {
      // En cas d'erreur de parsing ou de réseau
      print("Gemini Barcode Error: $e");
      return null;
    }
  }

  Future<Map<String, dynamic>?> analyzeNutritionTable(
    Uint8List imageBytes,
    String languageCode,
  ) async {
    if (useMockData) {
      await Future.delayed(const Duration(seconds: 1));

      // On retourne la structure exacte que vous avez demandée
      return {
        "foodName": "Barre Granola Miel & Amandes (Mock)",
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

    // 1. Le Prompt spécialisé "Vision"
    final promptText =
        """
    Analyse cette image de tableau de valeur nutritive (Nutrition Facts).
    
    Tâche : Extrais les valeurs numériques pour chaque nutriment.
    
    Règles strictes :
    1. Réponds UNIQUEMENT en format JSON brut. Pas de Markdown, pas de texte.
    2. Convertis toutes les unités en Grammes (g) ou Milligrammes (mg) selon le standard ci-dessous.
    3. Si une valeur est "moins de 1g" (< 1g), mets 0.5. Si c'est "0g", mets 0.0.
    4. Pour 'foodName', essaie de lire le titre du produit s'il est visible au-dessus du tableau. Sinon, utilise "Aliment Scanné". Traduis-le en "$languageCode".
    5. Pour 'portionInGrams' : Cherche la taille de la portion (Serving Size) indiquée (ex: "Per 1 cup (228g)"). Extrais UNIQUEMENT le chiffre en grammes (ex: 228.0). Si ce n'est pas indiqué en grammes, estime une conversion ou mets 100.0 par défaut.
    
    Structure JSON attendue (respecte exactement ces clés) :
    {
      "foodName": "Nom détecté ou générique",
      "portionInGrams": 0.0,
      "calories": 0.0,    // Calories (pas kCal, juste le chiffre)
      "totalFat": 0.0,    // en grammes (g)
      "saturatedFat": 0.0,// en grammes (g)
      "transFat": 0.0,    // en grammes (g)
      "cholesterol": 0.0, // en milligrammes (mg)
      "sodium": 0.0,      // en milligrammes (mg)
      "potassium": 0.0,   // en milligrammes (mg)
      "totalCarbohydrates": 0.0, // en grammes (g)
      "dietaryFiber": 0.0,       // en grammes (g)
      "sugar": 0.0,              // en grammes (g)
      "protein": 0.0             // en grammes (g)
    }
  """;

    try {
      // 2. Construction de la requête Multimodale (Texte + Image)
      final content = [
        Content.multi([
          TextPart(promptText),
          DataPart('image/jpeg', imageBytes), // On envoie l'image brute
        ]),
      ];

      // Note: Assurez-vous d'utiliser un modèle capable de vision (ex: gemini-1.5-flash ou gemini-pro-vision)
      final response = await _model!.generateContent(content);

      final String? text = response.text;

      if (text == null) return null;

      // 3. Nettoyage (Gemini met souvent ```json ... ```)
      String cleanedJson = text
          .replaceAll('```json', '')
          .replaceAll('```', '')
          .trim();

      // 4. Décodage
      final Map<String, dynamic> data = jsonDecode(cleanedJson);

      // Validation de sécurité pour la portion
      if ((data['portionInGrams'] as num?) == 0) {
        data['portionInGrams'] = 100.0; // Fallback sécurité
      }

      return data;
    } catch (e) {
      print("Gemini Vision Error: $e");
      return null;
    }
  }

  Future<NutritionalFacts> analyzeImage(
    String imagePath,
    String languageCode,
  ) async {
    // 1. DÉTECTION DU MODE MOCK
    if (useMockData) {
      print("⚠️ MODE MOCK ACTIVÉ : Aucune requête API envoyée.");

      // On simule un délai de 2 secondes pour tester votre loader/spinner
      await Future.delayed(const Duration(seconds: 2));

      // On retourne une fausse réponse parfaite
      return NutritionalFacts(
        foodName: "Barre Granola Miel & Amandes (Mock)",
        portionInGrams: 42.0,
        calories: 190.0,
        totalFat: 6.0,
        saturatedFat: 1.0,
        transFat: 0.0,
        cholesterol: 0.0,
        sodium: 140.0,
        potassium: 95.0,
        totalCarbohydrates: 29.0,
        dietaryFiber: 2.0,
        sugar: 11.0,
        protein: 3.0,
      );
    }

    // Le prompt système mis à jour (Prompt 2.2)
    final String systemInstruction = '''
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
    nutritionnelles pour l'ensemble du contenu visible. Tu
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
    Langue de réponse : $languageCode.
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
