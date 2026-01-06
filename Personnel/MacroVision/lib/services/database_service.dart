import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:async';
import 'package:intl/intl.dart';
import 'package:macro_vision/models/nutritional_facts_entry.dart';
import 'package:macro_vision/helpers/helpers.dart';

class DailySummary {
  final String dayName;
  final double calories;
  DailySummary({required this.dayName, required this.calories});
}

class DatabaseService {
  static final DatabaseService _instance = DatabaseService._internal();
  factory DatabaseService() => _instance;
  DatabaseService._internal();

  static Database? _database;
  static const String _dbName = 'macro_vision.db';
  static const String _oldDbName = 'macro_vision_history.db';
  static const int _dbVersion = 2;

  final String tableName = 'analysis_history';
  // Columns
  final String colId = 'id';
  final String colTimestamp = 'timestamp';
  final String colImagePath = 'imagePath';
  final String colName = 'foodName';
  final String colPortionInGrams = 'portionInGrams';
  final String colCalories = 'calories';
  final String colTotalFat = 'totalFat';
  final String colSaturatedFat = 'saturatedFat';
  final String colTransFat = 'transFat';
  final String colCholesterol = 'cholesterol';
  final String colSodium = 'sodium';
  final String colPotassium = 'potassium';
  final String colTotalCarbohydrates = 'totalCarbohydrates';
  final String colDietaryFiber = 'dietaryFiber';
  final String colSugar = 'sugar';
  final String colProtein = 'protein';

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  Future<T> _withDatabase<T>(Future<T> Function(Database db) action) async {
    final db = await database;
    return await action(db);
  }

  // --- Init & Migration ---

  Future<Database> _initDB() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, _dbName);
    final oldPath = join(dbPath, _oldDbName);

    // Migration Logic: Rename old DB if it exists and new one doesn't
    if (await databaseExists(oldPath) && !(await databaseExists(path))) {
      // final oldFile = File(oldPath);
      try {
        await File(oldPath).rename(path);
        debugPrint("DB: Migrated via rename (from $oldPath to $path).");
      } catch (e) {
        try {
          await File(oldPath).copy(path);
          await File(oldPath).delete();
          debugPrint("DB: Migrated via copy.");
        } catch (_) {
          // Critical fail: Fallback to opening old path
          return openDatabase(
            oldPath,
            onCreate: _onCreate,
            onUpgrade: _onUpgrade,
            version: _dbVersion,
          );
        }
      }
    }

    return openDatabase(
      path,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
      version: _dbVersion,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    return db.execute('''
      CREATE TABLE $tableName (
        $colId INTEGER PRIMARY KEY AUTOINCREMENT,
        $colTimestamp INTEGER NOT NULL,
        $colImagePath TEXT NOT NULL,
        $colName TEXT NOT NULL,
        $colPortionInGrams REAL NOT NULL,
        $colCalories REAL NOT NULL,
        $colTotalFat REAL NOT NULL,
        $colSaturatedFat REAL NOT NULL,
        $colTransFat REAL NOT NULL,
        $colCholesterol REAL NOT NULL,
        $colSodium REAL NOT NULL,
        $colPotassium REAL NOT NULL,
        $colTotalCarbohydrates REAL NOT NULL,
        $colDietaryFiber REAL NOT NULL,
        $colSugar REAL NOT NULL,
        $colProtein REAL NOT NULL
      )
      ''');
  }

  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 2) {
      await db.execute(
        'ALTER TABLE $tableName ADD COLUMN $colPortionInGrams REAL DEFAULT 0.0',
      );
    }
  }

  // --- Queries ---

  Future<List<NutritionalFactsEntry>> getHistory() =>
      _queryEntries(orderBy: '$colTimestamp DESC');
  // Future<List<NutritionalFactsEntry>> getHistory() async {
  //   return _queryEntries();
  // }

  Future<List<NutritionalFactsEntry>> getHistoryForDay(int startTimestamp) =>
      _queryEntries(where: '$colTimestamp >= ?', args: [startTimestamp]);
  // Future<List<NutritionalFactsEntry>> getHistoryForDay(
  //   int startTimestamp,
  // ) async {
  //   return _queryEntries(
  //     where: '$colTimestamp >= ?',
  //     whereArgs: [startTimestamp],
  //   );
  // }

  Future<List<DailySummary>> getWeeklySummary() async {
    return _withDatabase((db) async {
      final startOfWeek = getStartOfCurrentWeek();
      final startTimestamp = getStartOfDayTimestamp(startOfWeek);

      // Optimized SQL: Group by formatted date
      final result = await db.rawQuery(
        '''
        SELECT 
          strftime('%Y-%m-%d', $colTimestamp / 1000, 'unixepoch', 'localtime') as day,
          SUM($colCalories) as totalCalories
        FROM $tableName
        WHERE $colTimestamp >= ?
        GROUP BY day
      ''',
        [startTimestamp],
      );

      // Convert SQL Result to Map for O(1) lookup
      final summaryMap = {
        for (var row in result)
          row['day'] as String: (row['totalCalories'] as num).toDouble(),
      };

      // Generate full 7-day list
      return List.generate(7, (index) {
        final date = startOfWeek.add(Duration(days: index));
        final dateKey = DateFormat('yyyy-MM-dd').format(date);
        return DailySummary(
          dayName: formatDateForSummary(date), // From helpers.dart
          calories: summaryMap[dateKey] ?? 0.0,
        );
      });
    });

    // return _withDatabase((db) async {
    //   // 1. CALCULER LE DÉBUT DE LA SEMAINE (LUNDI à 00:00:00)
    //   final startOfWeek = getStartOfCurrentWeek();
    //   final startTimestamp = getStartOfDayTimestamp(startOfWeek);

    //   final List<Map<String, dynamic>> result = await db.rawQuery(
    //     '''
    //   SELECT
    //     strftime('%Y-%m-%d', $colTimestamp / 1000, 'unixepoch', 'localtime') as day,
    //     SUM($colCalories) as totalCalories
    //   FROM $tableName
    //   WHERE $colTimestamp >= ?
    //   GROUP BY day
    //   ORDER BY day ASC
    //   ''',
    //     [startTimestamp],
    //   );

    //   Map<String, double> summaryMap = {};
    //   for (var row in result) {
    //     final String dayKey = row['day'] as String;
    //     final num totalCalNum = row['totalCalories'] as num;
    //     final double totalCal = totalCalNum.toDouble();
    //     summaryMap[dayKey] = totalCal;
    //   }

    //   List<DailySummary> weeklySummary = [];

    //   // 2. GÉNÉRER LES 7 JOURS À PARTIR DU DÉBUT DE LA SEMAINE
    //   // La boucle commence à 0 (Lundi) et va jusqu'à 6 (Dimanche).
    //   for (int i = 0; i < 7; i++) {
    //     // Ajoute i jours au début de la semaine (startOfWeek)
    //     final date = startOfWeek.add(Duration(days: i));
    //     final dateString = DateFormat('yyyy-MM-dd').format(date);

    //     // final dayName = DateFormat('E').format(date);
    //     final dayName = formatDateForSummary(date);

    //     weeklySummary.add(
    //       DailySummary(
    //         dayName: dayName,
    //         calories: summaryMap[dateString] ?? 0.0,
    //       ),
    //     );
    //   }

    //   return weeklySummary;
    // });
  }

  // --- CRUD Operations ---

  Future<int> insertEntry(NutritionalFactsEntry entry) => _withDatabase(
    (db) => db.insert(
      tableName,
      entry.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    ),
  );

  Future<int> updateEntry(NutritionalFactsEntry entry) => _withDatabase(
    (db) => db.update(
      tableName,
      entry.toMap(),
      where: '$colId = ?',
      whereArgs: [entry.id],
    ),
  );

  Future<int> deleteEntry(int id) => _withDatabase(
    (db) => db.delete(tableName, where: '$colId = ?', whereArgs: [id]),
  );

  // --- Helpers ---

  Future<List<NutritionalFactsEntry>> _queryEntries({
    String? where,
    List<Object?>? args,
    String? orderBy,
  }) async {
    return _withDatabase((db) async {
      final maps = await db.query(
        tableName,
        where: where,
        whereArgs: args,
        orderBy: orderBy ?? '$colTimestamp DESC',
      );
      return maps.map((e) => NutritionalFactsEntry.fromMap(e)).toList();
    });
  }

  // --- Seeding (Optimized with Batch) ---

  Future<void> seedDatabaseForTesting() async {
    if (!(await isDatabaseEmpty())) {
      debugPrint("[DB] Skipping seed: DB not empty.");
      return;
    }

    debugPrint("[DB] Seeding dummy data...");
    final entries = _dummyEntries; // Get data from private getter

    await _withDatabase((db) async {
      final batch = db.batch(); // Batch insert is much faster
      for (var entry in entries) {
        batch.insert(
          tableName,
          entry.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
      }
      await batch.commit(noResult: true);
    });
  }

  Future<bool> isDatabaseEmpty() async {
    final db = await database;
    final count = Sqflite.firstIntValue(
      await db.rawQuery(
        "SELECT COUNT(*) FROM $tableName WHERE $colTimestamp >= DATE('now') AND $colTimestamp < DATE('now', '+1 day')",
      ),
    );
    return (count ?? 0) == 0;
  }

  // --- Dummy Data (Moved out of the way) ---

  List<NutritionalFactsEntry> get _dummyEntries {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day).millisecondsSinceEpoch;

    return [
      // Today
      NutritionalFactsEntry(
        timestamp: today + 34200000,
        imagePath: 'assets/dummy_breakfast.png',
        foodName: 'Petit Déjeuner (Omelette)',
        portionInGrams: 250,
        calories: 450,
        totalFat: 25,
        saturatedFat: 8,
        transFat: 0,
        cholesterol: 300,
        sodium: 300,
        potassium: 100,
        totalCarbohydrates: 5,
        dietaryFiber: 1,
        sugar: 3,
        protein: 40,
      ),
      NutritionalFactsEntry(
        timestamp: today + 49500000,
        imagePath: 'assets/dummy_lunch.png',
        foodName: 'Dîner (Salade)',
        portionInGrams: 400,
        calories: 600,
        totalFat: 30,
        saturatedFat: 5,
        transFat: 0,
        cholesterol: 120,
        sodium: 450,
        potassium: 500,
        totalCarbohydrates: 20,
        dietaryFiber: 5,
        sugar: 8,
        protein: 50,
      ),
    ];
  }
}
