// lib/services/database_service.dart

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

  DatabaseService._internal();

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
        return db.execute(
          '''
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
          ''',
        );
      },
    );
  }

  Future<int> insertEntry(NutritionalFactsEntry entry) async {
    final db = await database;
    return await db.insert(tableName, entry.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<int> deleteEntry(int id) async {
    final db = await database;
    return await db.delete(
      tableName,
      where: '$columnId = ?',
      whereArgs: [id],
    );
  }

  Future<List<NutritionalFactsEntry>> getHistory() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      tableName,
      orderBy: '$columnTimestamp DESC', 
    );
    return List.generate(maps.length, (i) {
      return NutritionalFactsEntry.fromMap(maps[i]);
    });
  }

  Future<List<NutritionalFactsEntry>> getHistoryForDay(int startTimestamp) async {
    final db = await database;
    return await db.query(
      tableName,
      where: '$columnTimestamp >= ?',
      whereArgs: [startTimestamp],
    ).then((maps) {
      return List.generate(maps.length, (i) => NutritionalFactsEntry.fromMap(maps[i]));
    });
  }

  Future<List<DailySummary>> getWeeklySummary() async {
    final db = await database;
    final sevenDaysAgo = DateTime.now().subtract(const Duration(days: 7));
    final startTimestamp = DateTime(sevenDaysAgo.year, sevenDaysAgo.month, sevenDaysAgo.day).millisecondsSinceEpoch;

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
      summaryMap[row['day'] as String] = (row['totalCalories'] as num).toDouble();
    }
    
    List<DailySummary> weeklySummary = [];
    final now = DateTime.now();
    for (int i = 6; i >= 0; i--) {
      final date = now.subtract(Duration(days: i));
      final dateString = DateFormat('yyyy-MM-dd').format(date);
      final dayName = DateFormat('E', 'fr').format(date);
      
      weeklySummary.add(
        DailySummary(
          dayName: dayName,
          calories: summaryMap[dateString] ?? 0.0,
        ),
      );
    }

    return weeklySummary.reversed.toList();
  }
}