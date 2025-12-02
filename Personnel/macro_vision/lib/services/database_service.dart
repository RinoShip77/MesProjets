import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:async';

import 'package:macro_vision/models/nutritional_facts_entry.dart';

class DatabaseService {
  static final DatabaseService _instance = DatabaseService._internal();
  factory DatabaseService() => _instance;
  static Database? _database;

  DatabaseService._internal();

  // Nom de la table et des colonnes
  final String tableName = 'analysis_history';
  final String columnId = 'id';
  final String columnTimestamp = 'timestamp';
  final String columnName = 'foodName';
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

  Future<Database> _initDB() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, 'macro_vision_history.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        // Création de la table 'analysis_history'
        return db.execute('''
          CREATE TABLE $tableName(
            $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
            $columnTimestamp INTEGER,
            $columnName TEXT,
            $columnCalories REAL,
            $columnTotalFat REAL,
            $columnSaturatedFat REAL,
            $columnTransFat REAL,
            $columnCholesterol REAL,
            $columnSodium REAL,
            $columnPotassium REAL,
            $columnTotalCarbohydrates REAL,
            $columnDietaryFiber REAL,
            $columnSugar REAL,
            $columnProtein REAL,
            $columnImagePath TEXT
          )
          ''');
      },
    );
  }

  // --- Opérations de Base de Données ---

  Future<int> insertEntry(NutritionalFactsEntry entry) async {
    final db = await database;
    return await db.insert(
      tableName,
      entry.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<NutritionalFactsEntry>> getHistory() async {
    final db = await database;
    // Récupérer les résultats, triés par date la plus récente
    final List<Map<String, dynamic>> maps = await db.query(
      tableName,
      orderBy: '$columnTimestamp DESC',
    );

    return List.generate(maps.length, (i) {
      return NutritionalFactsEntry.fromMap(maps[i]);
    });
  }

  Future<int> deleteEntry(int id) async {
    final db = await database;
    return await db.delete(tableName, where: '$columnId = ?', whereArgs: [id]);
  }
}
