import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:async';
import 'package:intl/intl.dart';
import 'package:macro_vision/models/nutritional_facts_entry.dart';

class DailySummary {
  final String dayName;
  final double calories;

  DailySummary({required this.dayName, required this.calories});
}

class DatabaseService {
  static final DatabaseService _instance = DatabaseService._internal();
  factory DatabaseService() => _instance;
  static Database? _database;
  final String _oldDbName = 'macro_vision_history.db';
  final String _newDbName = 'macro_vision.db';

  DatabaseService._internal();

  final String tableName = 'analysis_history';
  final String columnId = 'id';
  final String columnTimestamp = 'timestamp';
  final String columnName = 'foodName';
  final String columnPortionInGrams = 'portionInGrams'; // AJOUTÉ
  final String columnCalories = 'calories';
  final String columnTotalFat = 'totalFat';
  final String columnSaturatedFat = 'saturatedFat';
  final String columnTransFat = 'transFat';
  final String columnCholesterol = 'cholesterol';
  final String columnSodium = 'sodium';
  final String columnPotassium = 'potassium';
  final String columnTotalCarbohydrates = 'totalCarbohydrates';
  final String columnDietaryFiber = 'dietaryFiber';
  final String columnSugar = 'sugar';
  final String columnProtein = 'protein';
  final String columnImagePath = 'imagePath';

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  // Méthode privée pour encapsuler l'accès à la DB
  Future<T> _withDatabase<T>(Future<T> Function(Database db) action) async {
    // Garantit que la base de données est initialisée et disponible
    final db = await database;
    // Exécute l'action de l'utilisateur avec l'instance de la DB
    return await action(db);
  }

  // ===========================================================================
  // 💾 INITIALISATION ET MIGRATION DE LA BASE DE DONNÉES
  // ===========================================================================
  Future<Database> _initDB() async {
    final databasePath = await getDatabasesPath();
    final oldPath = join(databasePath, _oldDbName);
    final newPath = join(databasePath, _newDbName);

    // Étape 1: Gérer la migration de nom pour les anciens utilisateurs
    // Vérifie si l'ancienne DB existe et que la nouvelle n'existe PAS encore
    if (await databaseExists(oldPath) && !(await databaseExists(newPath))) {
      final oldFile = File(oldPath);

      // Tenter le renommage en premier (c'est plus rapide et atomic)
      try {
        await oldFile.rename(newPath);
        if (kDebugMode) {
          print("DB_MIGRATION: Succès du renommage (de $oldFile vers $newPath).");
        }
      } 
      // Si le renommage échoue, nous passons à la logique de copie de sécurité
      catch (e) {
        if (kDebugMode) {
          print("DB_MIGRATION: ERREUR de renommage. Tentative de copie de sécurité... $e");
        }
        
        try {
          // Utiliser copy() à la place de rename()
          await oldFile.copy(newPath);
          
          // Si la copie réussit, on supprime l'ancienne pour éviter la duplication
          await oldFile.delete(); 
          if (kDebugMode) {
            print("DB_MIGRATION: Succès de la copie de sécurité et suppression de l'ancienne DB.");
          }

        } catch (eCopy) {
          // Si la copie/suppression échoue, c'est une erreur critique.
          // Pour la robustesse, on peut décider d'ouvrir l'ancienne DB
          // et laisser l'utilisateur utiliser la V1.

          if (kDebugMode) {
            print("DB_MIGRATION: ÉCHEC CRITIQUE de la copie. Ouverture de l'ancienne DB.");
          }
          
          // On ouvre l'ancienne DB, et l'application fonctionnera
          // mais utilisera l'ancien nom de fichier.
          return openDatabase(
            oldPath, 
            onCreate: _onCreate,
            onUpgrade: _onUpgrade,
            version: 2,
          );
        }
      }
    }

    // Étape 2: Ouvrir la DB avec le nouveau nom (ou l'ancienne si le renommage a échoué)
    // Cela fonctionnera dans tous les cas:
    // - Nouvelle installation: le fichier n'existe pas, il est créé.
    // - Utilisateur existant: le fichier renommé est ouvert.
    return openDatabase(
      newPath, // Utilise le nouveau nom (chemin)
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
      version: 2, // PASSAGE DE VERSION 1 À 2 POUR LES MISES À JOUR
    );
  }

  // Crée les tables si la DB n'existe pas
  Future<void> _onCreate(Database db, int version) async {
    // Crée la table avec toutes les colonnes requises
    return db.execute('''
      CREATE TABLE $tableName (
        $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
        $columnTimestamp INTEGER NOT NULL,
        $columnImagePath TEXT NOT NULL,
        $columnName TEXT NOT NULL,
        $columnPortionInGrams REAL NOT NULL,
        $columnCalories REAL NOT NULL,
        $columnTotalFat REAL NOT NULL,
        $columnSaturatedFat REAL NOT NULL,
        $columnTransFat REAL NOT NULL,
        $columnCholesterol REAL NOT NULL,
        $columnSodium REAL NOT NULL,
        $columnPotassium REAL NOT NULL,
        $columnTotalCarbohydrates REAL NOT NULL,
        $columnDietaryFiber REAL NOT NULL,
        $columnSugar REAL NOT NULL,
        $columnProtein REAL NOT NULL
      )
      ''');
  }

  // Gère les mises à jour de la structure de la DB
  // (Laisser vide pour la version 1.0.0, mais essentiel pour l'avenir)
  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 2) {
      // Ajout de la nouvelle colonne avec une valeur par défaut de 0.0
      await db.execute(
        'ALTER TABLE $tableName ADD COLUMN $columnPortionInGrams REAL DEFAULT 0.0',
      );
    }
    // Ajouter d'autres blocs 'if (oldVersion < 3)' pour les futures mises à jour
  }

  // Obtenir l'historique complet, trié par date décroissante
  Future<List<NutritionalFactsEntry>> getHistory() async {
    return _queryEntries();
  }

  // Obtenir les entrées pour une journée spécifique
  Future<List<NutritionalFactsEntry>> getHistoryForDay(
    int startTimestamp,
  ) async {
    return _queryEntries(
      where: '$columnTimestamp >= ?',
      whereArgs: [startTimestamp],
    );
  }

  Future<List<DailySummary>> getWeeklySummary() async {
    return _withDatabase((db) async {
      final sevenDaysAgo = DateTime.now().subtract(const Duration(days: 7));
      final startTimestamp = DateTime(
        sevenDaysAgo.year,
        sevenDaysAgo.month,
        sevenDaysAgo.day,
      ).millisecondsSinceEpoch;

      final List<Map<String, dynamic>> result = await db.rawQuery(
        '''
      SELECT 
        strftime('%Y-%m-%d', $columnTimestamp / 1000, 'unixepoch', 'localtime') as day,
        SUM($columnCalories) as totalCalories
      FROM $tableName
      WHERE $columnTimestamp >= ?
      GROUP BY day
      ORDER BY day ASC
      ''',
        [startTimestamp],
      );

      Map<String, double> summaryMap = {};
      for (var row in result) {
        final String dayKey = row['day'] as String;
        final num totalCalNum = row['totalCalories'] as num;
        final double totalCal = totalCalNum.toDouble();
        summaryMap[dayKey] = totalCal;
      }

      List<DailySummary> weeklySummary = [];
      final now = DateTime.now();

      for (int i = 6; i >= 0; i--) {
        final date = now.subtract(Duration(days: i));
        final dateString = DateFormat('yyyy-MM-dd').format(date);
        // Utilisation du format par défaut pour éviter le plantage de la locale 'fr'
        final dayName = DateFormat('E').format(date);

        weeklySummary.add(
          DailySummary(
            dayName: dayName,
            calories: summaryMap[dateString] ?? 0.0,
          ),
        );
      }

      return weeklySummary;
    });
  }

  // Insérer une nouvelle entrée d'analyse
  Future<int> insertEntry(NutritionalFactsEntry entry) async {
    return _withDatabase((db) async {
      return await db.insert(
        tableName,
        entry.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    });
  }

  // Mettre à jour une entrée d'analyse
  Future<int> updateEntry(NutritionalFactsEntry entry) async {
    return _withDatabase((db) async {
      return await db.update(
        tableName,
        entry.toMap(),
        where: '$columnId = ?',
        whereArgs: [entry.id],
      );
    });
  }

  // Supprimer une entrée par son ID
  Future<int> deleteEntry(int id) async {
    return _withDatabase((db) async {
      return await db.delete(
        tableName,
        where: '$columnId = ?',
        whereArgs: [id],
      );
    });
  }

  // ===========================================================================
  // 🆕 FONCTIONS D'INITIALISATION DE DONNÉES FICTIVES (SEEDS)
  // ===========================================================================

  // Méthode pour vérifier si la table est vide
  Future<bool> isDatabaseEmpty() async {
    final db = await database;
    final count = Sqflite.firstIntValue(
      await db.rawQuery('SELECT COUNT(*) FROM $tableName'),
    );
    return (count ?? 0) == 0;
  }

  // Méthode interne pour insérer une liste d'entrées
  Future<void> _insertDummyEntries(List<NutritionalFactsEntry> entries) async {
    final db = await database;
    for (var entry in entries) {
      await db.insert(
        tableName,
        entry.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
  }

  // Méthode publique pour initialiser la base de données avec des données de test
  Future<void> seedDatabaseForTesting() async {
    // Si la BD n'est pas vide, on arrête ici
    if (!(await isDatabaseEmpty())) {
      print(
        "[DB] La base de données contient déjà des données. Saut de l'initialisation des données fictives.",
      );
      return;
    }

    print("[DB] Insertion des données fictives pour le test...");
    final now = DateTime.now();
    final yesterday = now.subtract(const Duration(days: 1));
    final twoDaysAgo = now.subtract(const Duration(days: 2));

    // Aide pour obtenir le timestamp de début de journée
    int getStartOfDayTimestamp(DateTime date) {
      return DateTime(date.year, date.month, date.day).millisecondsSinceEpoch;
    }

    final int todayStart = getStartOfDayTimestamp(now);
    final int yesterdayStart = getStartOfDayTimestamp(yesterday);
    final int twoDaysAgoStart = getStartOfDayTimestamp(twoDaysAgo);

    // --- Données pour AUJOURD'HUI (Journée partielle) ---
    final todayEntries = [
      NutritionalFactsEntry(
        timestamp:
            todayStart + const Duration(hours: 9, minutes: 30).inMilliseconds,
        imagePath: 'assets/dummy_breakfast.png',
        foodName: 'Petit Déjeuner (Omelette)',
        portionInGrams: 250.0,
        calories: 450.0,
        totalFat: 25.0,
        saturatedFat: 8.0,
        transFat: 0.0,
        cholesterol: 300.0,
        sodium: 300.0,
        potassium: 100.0,
        totalCarbohydrates: 5.0,
        dietaryFiber: 1.0,
        sugar: 3.0,
        protein: 40.0,
      ),
      NutritionalFactsEntry(
        timestamp:
            todayStart + const Duration(hours: 13, minutes: 45).inMilliseconds,
        imagePath: 'assets/dummy_lunch.png',
        foodName: 'Dîner (Salade de poulet)',
        portionInGrams: 400.0,
        calories: 600.0,
        totalFat: 30.0,
        saturatedFat: 5.0,
        transFat: 0.0,
        cholesterol: 120.0,
        sodium: 450.0,
        potassium: 500.0,
        totalCarbohydrates: 20.0,
        dietaryFiber: 5.0,
        sugar: 8.0,
        protein: 50.0,
      ),
    ];

    // --- Données pour HIER (Journée complète, objectif dépassé) ---
    final yesterdayEntries = [
      NutritionalFactsEntry(
        timestamp:
            yesterdayStart +
            const Duration(hours: 8, minutes: 0).inMilliseconds,
        imagePath: 'assets/dummy_bf_2.png',
        foodName: 'Petit Déjeuner (Yogourt + Granola)',
        portionInGrams: 300.0,
        calories: 320.0,
        totalFat: 5.0,
        saturatedFat: 3.0,
        transFat: 0.0,
        cholesterol: 10.0,
        sodium: 150.0,
        potassium: 200.0,
        totalCarbohydrates: 35.0,
        dietaryFiber: 0.0,
        sugar: 30.0,
        protein: 30.0,
      ),
      NutritionalFactsEntry(
        timestamp:
            yesterdayStart +
            const Duration(hours: 12, minutes: 30).inMilliseconds,
        imagePath: 'assets/dummy_lunch_2.png',
        foodName: 'Dîner (Pâtes à la viande)',
        portionInGrams: 550.0,
        calories: 850.0,
        totalFat: 35.0,
        saturatedFat: 12.0,
        transFat: 0.0,
        cholesterol: 150.0,
        sodium: 800.0,
        potassium: 550.0,
        totalCarbohydrates: 90.0,
        dietaryFiber: 10.0,
        sugar: 5.0,
        protein: 30.0,
      ),
      NutritionalFactsEntry(
        timestamp:
            yesterdayStart +
            const Duration(hours: 19, minutes: 0).inMilliseconds,
        imagePath: 'assets/dummy_dinner_2.png',
        foodName: 'Souper (Saumon et riz)',
        portionInGrams: 450.0,
        calories: 700.0,
        totalFat: 40.0,
        saturatedFat: 6.0,
        transFat: 0.0,
        cholesterol: 100.0,
        sodium: 300.0,
        potassium: 700.0,
        totalCarbohydrates: 50.0,
        dietaryFiber: 4.0,
        sugar: 0.0,
        protein: 50.0,
      ),
      NutritionalFactsEntry(
        timestamp:
            yesterdayStart +
            const Duration(hours: 21, minutes: 15).inMilliseconds,
        imagePath: 'assets/dummy_snack.png',
        foodName: 'Collation (Barre chocolatée)',
        portionInGrams: 100.0,
        calories: 400.0,
        totalFat: 20.0,
        saturatedFat: 10.0,
        transFat: 0.0,
        cholesterol: 10.0,
        sodium: 100.0,
        potassium: 50.0,
        totalCarbohydrates: 50.0,
        dietaryFiber: 2.0,
        sugar: 35.0,
        protein: 5.0,
      ),
    ];

    // --- Données pour il y a 2 JOURS (Journée complète, objectif respecté) ---
    final twoDaysAgoEntries = [
      NutritionalFactsEntry(
        timestamp:
            twoDaysAgoStart +
            const Duration(hours: 9, minutes: 0).inMilliseconds,
        imagePath: 'assets/dummy_bf_3.png',
        foodName: 'Petit Déjeuner (Gruau)',
        portionInGrams: 350.0,
        calories: 400.0,
        totalFat: 8.0,
        saturatedFat: 1.0,
        transFat: 0.0,
        cholesterol: 0.0,
        sodium: 50.0,
        potassium: 300.0,
        totalCarbohydrates: 65.0,
        dietaryFiber: 8.0,
        sugar: 15.0,
        protein: 15.0,
      ),
      NutritionalFactsEntry(
        timestamp:
            twoDaysAgoStart +
            const Duration(hours: 13, minutes: 0).inMilliseconds,
        imagePath: 'assets/dummy_lunch_3.png',
        foodName: 'Dîner (Soupe et pain)',
        portionInGrams: 450.0,
        calories: 450.0,
        totalFat: 15.0,
        saturatedFat: 4.0,
        transFat: 0.0,
        cholesterol: 50.0,
        sodium: 600.0,
        potassium: 400.0,
        totalCarbohydrates: 55.0,
        dietaryFiber: 5.0,
        sugar: 10.0,
        protein: 15.0,
      ),
      NutritionalFactsEntry(
        timestamp:
            twoDaysAgoStart +
            const Duration(hours: 19, minutes: 30).inMilliseconds,
        imagePath: 'assets/dummy_dinner_3.png',
        foodName: 'Souper (Poulet au curry)',
        portionInGrams: 600.0,
        calories: 850.0,
        totalFat: 40.0,
        saturatedFat: 10.0,
        transFat: 0.0,
        cholesterol: 100.0,
        sodium: 600.0,
        potassium: 300.0,
        totalCarbohydrates: 70.0,
        dietaryFiber: 5.0,
        sugar: 5.0,
        protein: 55.0,
      ),
    ];

    final allEntries = [
      ...twoDaysAgoEntries,
      ...yesterdayEntries,
      ...todayEntries,
    ];

    await _insertDummyEntries(allEntries);
    print(
      "[DB] Base de données initialisée avec ${allEntries.length} entrées fictives.",
    );
  }

  // Fonction privée utilitaire pour exécuter une requête de base et convertir le résultat
  Future<List<NutritionalFactsEntry>> _queryEntries({
    String? where,
    List<Object?>? whereArgs,
  }) async {
    return _withDatabase((db) async {
      // Exécute la requête avec les paramètres optionnels
      final List<Map<String, dynamic>> maps = await db.query(
        tableName,
        where: where,
        whereArgs: whereArgs,
        orderBy: '$columnTimestamp DESC', // Garde l'ordre par défaut
      );

      // Convertit la liste des maps en List<NutritionalFactsEntry>
      return List.generate(
        maps.length,
        (i) => NutritionalFactsEntry.fromMap(maps[i]),
      );
    });
  }
}
