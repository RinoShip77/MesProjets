import 'dart:io';
import 'dart:async';
import 'package:path/path.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:macro_vision/helpers/helpers.dart';
import 'package:macro_vision/models/nutritional_facts_entry.dart';

/// Lightweight model for daily chart summaries.
class DailySummary {
  final String dayName;
  final double calories;
  DailySummary({required this.dayName, required this.calories});
}

/// Service handling all SQLite database interactions.
class DatabaseService {
  // --- Singleton Pattern ---
  static final DatabaseService _instance = DatabaseService._internal();
  factory DatabaseService() => _instance;
  DatabaseService._internal();

  static Database? _database;

  // --- Constants ---
  static const String _dbName = 'macro_vision.db';
  static const String _oldDbName = 'macro_vision_history.db';
  static const int _dbVersion = 2;
  static const String _table = 'analysis_history';

  // --- Column Names ---
  static const String _colId = 'id';
  static const String _colTimestamp = 'timestamp';
  static const String _colCals = 'calories';
  // final String colId = 'id';
  // final String colTimestamp = 'timestamp';
  // final String colImagePath = 'imagePath';
  // final String colName = 'foodName';
  // final String colPortionInGrams = 'portionInGrams';
  // final String colCalories = 'calories';
  // final String colTotalFat = 'totalFat';
  // final String colSaturatedFat = 'saturatedFat';
  // final String colTransFat = 'transFat';
  // final String colCholesterol = 'cholesterol';
  // final String colSodium = 'sodium';
  // final String colPotassium = 'potassium';
  // final String colTotalCarbohydrates = 'totalCarbohydrates';
  // final String colDietaryFiber = 'dietaryFiber';
  // final String colSugar = 'sugar';
  // final String colProtein = 'protein';
  // (Other columns are inferred via raw queries or model mapping)

  // ===========================================================================
  // 1. DATABASE ACCESS & HELPERS
  // ===========================================================================

  /// Provides a singleton database instance.
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  /// Executes a function with a valid database instance.
  /// This wrapper ensures safety and reduces code repetition.
  Future<T> _withDatabase<T>(Future<T> Function(Database db) action) async {
    final db = await database;
    return await action(db);
  }

  // ===========================================================================
  // 2. INITIALIZATION & MIGRATION
  // ===========================================================================

  /// Initializes the database, handling migrations if necessary.
  Future<Database> _initDB() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, _dbName);
    final oldPath = join(dbPath, _oldDbName);

    // --- Automatic Migration: Rename old DB file if it exists ---
    if (await databaseExists(oldPath) && !(await databaseExists(path))) {
      debugPrint('[DB] Migration detected. Renaming legacy database file...');
      try {
        await File(oldPath).rename(path);
        debugPrint('[DB] Rename successful(from $oldPath to $path).');
      } catch (e) {
        debugPrint('[DB] Rename failed ($e). Attempting copy...');
        try {
          await File(oldPath).copy(path);
          await File(oldPath).delete();
          debugPrint('[DB] Migrated via copy.');
        } catch (_) {
          debugPrint(
            '[DB] CRITICAL: Copy failed. Opening legacy file as fallback.',
          );
          return openDatabase(
            oldPath,
            version: _dbVersion,
            onCreate: _onCreate,
            onUpgrade: _onUpgrade,
          );
        }
      }
    }

    return openDatabase(
      path,
      version: _dbVersion,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
    );
  }

  /// Handles schema creation.
  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $_table (
        $_colId INTEGER PRIMARY KEY AUTOINCREMENT,
        $_colTimestamp INTEGER NOT NULL,
        imagePath TEXT NOT NULL,
        foodName TEXT NOT NULL,
        portionInGrams REAL NOT NULL,
        $_colCals REAL NOT NULL,
        totalFat REAL NOT NULL,
        saturatedFat REAL NOT NULL,
        transFat REAL NOT NULL,
        cholesterol REAL NOT NULL,
        sodium REAL NOT NULL,
        potassium REAL NOT NULL,
        totalCarbohydrates REAL NOT NULL,
        dietaryFiber REAL NOT NULL,
        sugar REAL NOT NULL,
        protein REAL NOT NULL
      )
    ''');
    // return db.execute('''
    //   CREATE TABLE $tableName (
    //     $colId INTEGER PRIMARY KEY AUTOINCREMENT,
    //     $colTimestamp INTEGER NOT NULL,
    //     $colImagePath TEXT NOT NULL,
    //     $colName TEXT NOT NULL,
    //     $colPortionInGrams REAL NOT NULL,
    //     $colCalories REAL NOT NULL,
    //     $colTotalFat REAL NOT NULL,
    //     $colSaturatedFat REAL NOT NULL,
    //     $colTransFat REAL NOT NULL,
    //     $colCholesterol REAL NOT NULL,
    //     $colSodium REAL NOT NULL,
    //     $colPotassium REAL NOT NULL,
    //     $colTotalCarbohydrates REAL NOT NULL,
    //     $colDietaryFiber REAL NOT NULL,
    //     $colSugar REAL NOT NULL,
    //     $colProtein REAL NOT NULL
    //   )
    //   ''');
  }

  /// Handles schema updates (e.g. adding columns).
  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 2) {
      // V2 Upgrade: Add 'portionInGrams' column
      await db.execute(
        'ALTER TABLE $_table ADD COLUMN portionInGrams REAL DEFAULT 0.0',
      );
    }
  }

  // ===========================================================================
  // 3. CRUD OPERATIONS
  // ===========================================================================

  /// Fetches all entries, ordered by most recent first.
  Future<List<NutritionalFactsEntry>> getHistory() =>
      _queryEntries(orderBy: '$_colTimestamp DESC');

  /// Fetches entries from a specific day.
  Future<List<NutritionalFactsEntry>> getHistoryForDay(int startTimestamp) =>
      _queryEntries(where: '$_colTimestamp >= ?', args: [startTimestamp]);

  /// Inserts a new food entry, but BLOCKS "Not Food" or invalid AI results.
  Future<int> insertEntry(NutritionalFactsEntry entry) async {
    // 1. GUARDRAIL: Check for the specific "Not Food" flag from the AI
    if (entry.foodName.toLowerCase().contains('not food detected')) {
      debugPrint('[DB] Insert skipped: "Not Food Detected" in image.');
      return -1; // Return -1 to indicate skipped operation
    }

    // 2. SAFETY CHECK: Prevent saving "empty" ghosts (all zeros + unknown name)
    // Note: We allow all-zeros if the name is explicit (e.g., "Water" or "Diet Coke")
    if (entry.calories == 0 &&
        entry.protein == 0 &&
        entry.totalCarbohydrates == 0 &&
        entry.totalFat == 0 &&
        (entry.foodName == 'Unknown Product' || entry.foodName.isEmpty)) {
      debugPrint('[DB] Insert skipped: Empty/Invalid nutritional data.');
      return -1;
    }

    // 3. Proceed to Insert if valid
    return _withDatabase(
      (db) => db.insert(
        _table,
        entry.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      ),
    );
  }
  // Future<int> insertEntry(NutritionalFactsEntry entry) => _withDatabase(
  //   (db) => db.insert(
  //     _table,
  //     entry.toMap(),
  //     conflictAlgorithm: ConflictAlgorithm.replace,
  //   ),
  // );

  /// Updates an existing entry.
  Future<int> updateEntry(NutritionalFactsEntry entry) async {
    // Apply the same guardrail
    if (entry.foodName.toLowerCase().contains('not food detected')) {
       return -1; 
    }
      
    return _withDatabase(
      (db) => db.update(
        _table,
        entry.toMap(),
        where: '$_colId = ?',
        whereArgs: [entry.id],
      ),
    );
  }
  // Future<int> updateEntry(NutritionalFactsEntry entry) => _withDatabase(
  //   (db) => db.update(
  //     _table,
  //     entry.toMap(),
  //     where: '$_colId = ?',
  //     whereArgs: [entry.id],
  //   ),
  // );

  /// Deletes an entry by ID.
  Future<int> deleteEntry(int id) => _withDatabase(
    (db) => db.delete(_table, where: '$_colId = ?', whereArgs: [id]),
  );

  // ===========================================================================
  // 4. ANALYTICS & SUMMARIES
  // ===========================================================================

  /// Generates a weekly summary of daily calorie totals.
  Future<List<DailySummary>> getWeeklySummary() async {
    return _withDatabase((db) async {
      final startOfWeek = getStartOfCurrentWeek();
      final startTimestamp = getStartOfDayTimestamp(startOfWeek);

      // SQL Optimization: Group by formatted date string (YYYY-MM-DD)
      final result = await db.rawQuery(
        '''
        SELECT 
          strftime('%Y-%m-%d', $_colTimestamp / 1000, 'unixepoch', 'localtime') as day,
          SUM($_colCals) as totalCalories
        FROM $_table
        WHERE $_colTimestamp >= ?
        GROUP BY day
      ''',
        [startTimestamp],
      );

      // Map results for O(1) access
      final summaryMap = {
        for (var row in result)
          row['day'] as String: (row['totalCalories'] as num).toDouble(),
      };

      // Generate full 7-day list (filling zeros for missing days)
      return List.generate(7, (index) {
        final date = startOfWeek.add(Duration(days: index));
        final dateKey = DateFormat('yyyy-MM-dd').format(date);

        return DailySummary(
          dayName: formatDateForSummary(date), // From helpers.dart
          calories: summaryMap[dateKey] ?? 0.0,
        );
      });
    });
  }

  // ===========================================================================
  // 5. INTERNAL UTILITIES
  // ===========================================================================

  /// Generic query helper with optional filtering and ordering.
  Future<List<NutritionalFactsEntry>> _queryEntries({
    String? where,
    List<Object?>? args,
    String? orderBy,
  }) async {
    return _withDatabase((db) async {
      final maps = await db.query(
        _table,
        where: where,
        whereArgs: args,
        orderBy: orderBy,
      );
      return maps.map(NutritionalFactsEntry.fromMap).toList();
    });
  }

  // ===========================================================================
  // 6. HELPER FOR DEBUGGING & TESTING
  // ===========================================================================

  /// Seeds the database with dummy data for testing purposes.
  Future<void> seedDatabaseForTesting() async {
    final isEmpty = await _withDatabase((db) async {
      final count = Sqflite.firstIntValue(
        await db.rawQuery('SELECT COUNT(*) FROM $_table'),
      );
      return (count ?? 0) == 0;
    });

    if (!isEmpty) {
      debugPrint('[DB] Seed skipped: Data already exists.');
      return;
    }

    debugPrint('[DB] Seeding dummy data...');
    final entries = getMockDatabaseEntries(); // Get data from helper

    await _withDatabase((db) async {
      final batch = db.batch(); // Use batch for performance
      for (var entry in entries) {
        batch.insert(
          _table,
          entry.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
      }
      await batch.commit(noResult: true);
    });
  }
}
