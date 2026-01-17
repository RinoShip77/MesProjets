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
  static const int _dbVersion = 3;
  // static const int _dbVersion = 2;
  // static const int _dbVersion = 1;

  // --- Column Names ---
  //region Meal table
  static const String _tblMeal = 'meal_history';
  static const String _colMealId = 'id';
  static const String _colMealTimestamp = 'timestamp';
  static const String _colMealCals = 'calories';
  //endregion

  //region Water table
  static const String _tblWater = 'water_history';
  static const String _colWaterId = 'id';
  static const String _colWaterTimestamp = 'timestamp';
  static const String _colWaterQuantity = 'quantity';
  //endregion

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
    debugPrint('✨ Creating new Database structure...');

    // 1. Create Meal history
    await db.execute('''
      CREATE TABLE $_tblMeal (
        $_colMealId INTEGER PRIMARY KEY AUTOINCREMENT,
        $_colMealTimestamp INTEGER NOT NULL,
        imagePath TEXT NOT NULL,
        foodName TEXT NOT NULL,
        portionInGrams REAL NOT NULL,
        $_colMealCals REAL NOT NULL,
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

    // 2. Create Water history
    await db.execute('''
      CREATE TABLE $_tblWater (
        $_colWaterId INTEGER PRIMARY KEY AUTOINCREMENT,
        $_colWaterTimestamp INTEGER NOT NULL,
        $_colWaterQuantity INTEGER NOT NULL,
        UNIQUE($_colWaterTimestamp)
      )
    ''');
  }

  /// Handles schema updates.
  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    debugPrint('🛠️ Upgrading Database from $oldVersion to $newVersion...');

    // V2 Migration: Add portionInGrams column
    if (oldVersion < 2) {
      await db.execute(
        'ALTER TABLE $_tblMeal ADD COLUMN portionInGrams REAL DEFAULT 0.0',
      );
    }

    // V3 Migration: Add water tracking table & rename meal table
    if (oldVersion < 3) {
      // 1. Rename 'analysis_history' -> 'meal_history'
      try {
        // We check if the old table exists by trying to rename it.
        await db.execute('ALTER TABLE analysis_history RENAME TO $_tblMeal');
        debugPrint('✅ Table renamed to meal_history');
      } catch (e) {
        // If this fails, it might be because the table was already renamed
        // or didn't exist. We proceed safely.
        debugPrint('⚠️ Rename skipped (Target table might already exist): $e');
      }

      // 2. Create Water Table
      await db.execute('''
        CREATE TABLE $_tblWater (
          $_colWaterId INTEGER PRIMARY KEY AUTOINCREMENT,
          $_colWaterTimestamp INTEGER NOT NULL,
          $_colWaterQuantity INTEGER NOT NULL,
          UNIQUE($_colWaterTimestamp)
        )
      ''');
    }
  }

  // ===========================================================================
  // 3. CRUD OPERATIONS (MEAL HELPERS)
  // ===========================================================================

  /// Fetches all entries, ordered by most recent first.
  Future<List<NutritionalFactsEntry>> getHistory() =>
      _queryEntries(orderBy: '$_colMealTimestamp DESC');

  /// Fetches entries from a specific day.
  Future<List<NutritionalFactsEntry>> getHistoryForDay(int startTimestamp) {
    // 1. Calculate the end of the day (start + 24 hours)
    // We use 86400000 ms (24 * 60 * 60 * 1000)
    final int endTimestamp = startTimestamp + 86400000;

    // 2. Add the Upper Bound to the query
    return _queryEntries(
      where: '$_colMealTimestamp >= ? AND $_colMealTimestamp < ?',
      args: [startTimestamp, endTimestamp],
    );
  }

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
        _tblMeal,
        entry.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      ),
    );
  }

  /// Updates an existing entry.
  Future<int> updateEntry(NutritionalFactsEntry entry) async {
    // Apply the same guardrail
    if (entry.foodName.toLowerCase().contains('not food detected')) {
      return -1;
    }

    return _withDatabase(
      (db) => db.update(
        _tblMeal,
        entry.toMap(),
        where: '$_colMealId = ?',
        whereArgs: [entry.id],
      ),
    );
  }

  /// Deletes an entry by ID.
  Future<int> deleteEntry(int id) => _withDatabase(
    (db) => db.delete(_tblMeal, where: '$_colMealId = ?', whereArgs: [id]),
  );

  // ===========================================================================
  // 3. CRUD OPERATIONS (WATER HELPERS)
  // ===========================================================================

  /// Fetches water intake for a specific day (by timestamp).
  Future<int> getWaterIntake(int dateTimestamp) async {
    return _withDatabase((db) async {
      final List<Map<String, dynamic>> maps = await db.query(
        _tblWater,
        where: '$_colWaterTimestamp = ?',
        whereArgs: [dateTimestamp],
      );

      if (maps.isNotEmpty) {
        return maps.first[_colWaterQuantity] as int;
      }
      return 0;
    });
  }

  /// Sets water intake for a specific day (by timestamp).
  Future<void> setWaterIntake(int dateTimestamp, int quantity) async {
    await _withDatabase((db) async {
      await db.insert(_tblWater, {
        _colWaterTimestamp: dateTimestamp,
        _colWaterQuantity: quantity,
      }, conflictAlgorithm: ConflictAlgorithm.replace);
    });
  }

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
          strftime('%Y-%m-%d', $_colMealTimestamp / 1000, 'unixepoch', 'localtime') as day,
          SUM($_colMealCals) as totalCalories
        FROM $_tblMeal
        WHERE $_colMealTimestamp >= ?
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
        _tblMeal,
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

  /// Debug utility: Prints all table names in the database.
  Future<void> debugPrintTables() async {
    await _withDatabase((db) async {
      // Query the sqlite_master table which holds the schema
      final tables = await db.rawQuery(
        "SELECT name FROM sqlite_master WHERE type='table'",
      );

      debugPrint('📂 CURRENT TABLES IN DB:');
      for (var t in tables) {
        debugPrint(" - ${t['name']}");
      }
    });
  }

  /// Seeds the database with dummy data for testing purposes.
  Future<void> seedDatabaseForTesting() async {
    final now = DateTime.now();
    final startOfDay = DateTime(
      now.year,
      now.month,
      now.day,
    ).millisecondsSinceEpoch;
    final endOfDay = DateTime(
      now.year,
      now.month,
      now.day,
      23,
      59,
      59,
    ).millisecondsSinceEpoch;

    await _withDatabase((db) async {
      final count = Sqflite.firstIntValue(
        await db.rawQuery(
          'SELECT COUNT(*) FROM $_tblMeal WHERE $_colMealTimestamp >= ? AND $_colMealTimestamp <= ?',
          [startOfDay, endOfDay],
        ),
      );
      return (count ?? 0) == 0;
    });

    debugPrint('[DB] Seeding dummy data...');
    final entries = getMockDatabaseEntries(); // Get data from helper

    await _withDatabase((db) async {
      final batch = db.batch(); // Use batch for performance
      for (var entry in entries) {
        batch.insert(
          _tblMeal,
          entry.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
      }
      await batch.commit(noResult: true);
    });
  }
}
