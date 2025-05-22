import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DbHelper {
  static final DbHelper _instance = DbHelper._internal();
  factory DbHelper() => _instance;
  DbHelper._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'app_database.db');

    return await openDatabase(
      path,
      version: 3, // Increment version to 3 for the new schema
      onCreate: (db, version) async {
        await db.execute(
          'CREATE TABLE users(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, email TEXT UNIQUE, password TEXT, isLoggedIn INTEGER DEFAULT 0)',
        );
        await db.execute(
          'CREATE TABLE reports(id INTEGER PRIMARY KEY AUTOINCREMENT, note TEXT, eventDate TEXT)',
        );
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        if (oldVersion < 3) {
          // Add the `name` column to the `users` table
          await db.execute('ALTER TABLE users ADD COLUMN name TEXT');
        }
      },
    );
  }

  // Insert user with name, email, and password
  Future<void> insertUser(String name, String email, String password) async {
    final db = await database;
    await db.insert(
      'users',
      {'name': name, 'email': email, 'password': password},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Map<String, dynamic>>> getUsers() async {
    final db = await database;
    return await db
        .query('users'); // Replace 'users' with your actual table name
  }

  Future<Map<String, dynamic>?> getUser(String email) async {
    final db = await database;
    final result = await db.query(
      'users',
      where: 'email = ?',
      whereArgs: [email],
    );
    return result.isNotEmpty ? result.first : null;
  }

  Future<void> deleteUser(String email) async {
    final db = await database;
    await db.delete(
      'users',
      where: 'email = ?',
      whereArgs: [email],
    );
  }

  Future<void> updatedLoginStatus(String email, int isLoggedIn) async {
    final db = await database;
    await db.update(
      'users',
      {'isLoggedIn': isLoggedIn},
      where: 'email = ?',
      whereArgs: [email],
    );
  }

  Future<String?> getLoggedInUser() async {
    final db = await database;
    final result = await db.query(
      'users',
      where: 'isLoggedIn = ?',
      whereArgs: [1],
    );
    return result.isNotEmpty ? result.first['email'] as String? : null;
  }

  Future<void> insertReport(String note, DateTime eventDate) async {
    final db = await database;
    await db.insert(
      'reports',
      {'note': note, 'eventDate': eventDate.toIso8601String()},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Map<String, dynamic>>> getReports() async {
    final db = await database;
    return await db.query('reports');
  }

  Future<List<DateTime>> getUniqueEventDates() async {
    final db = await database;
    final result = await db.rawQuery('SELECT DISTINCT eventDate FROM reports');
    return result
        .map((row) => DateTime.parse(row['eventDate'] as String))
        .toList();
  }

  Future<void> deleteReportsByDate(DateTime date) async {
    final db = await database;
    await db.delete(
      'reports',
      where: 'eventDate = ? ',
      whereArgs: [date.toIso8601String()],
    );
  }

  Future<void> deleteReports(int id) async {
    final db = await database;
    await db.delete('reports', where: 'id = ?', whereArgs: [id]);
  }
}
