import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as path;

class DatabaseHelper {
  static final DatabaseHelper _databaseHelper = DatabaseHelper._internal();
  static Database? _database;

  DatabaseHelper._internal();

  factory DatabaseHelper() {
    return _databaseHelper;
  }

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final pathDB = await getDatabasesPath();
    final localDB = path.join(pathDB, 'local_db.db');

    final db = await openDatabase(
      localDB,
      version: 1,
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE notes (id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, content TEXT, createdAt DATETIME)',
        );
      },
    );

    return db;
  }
}
