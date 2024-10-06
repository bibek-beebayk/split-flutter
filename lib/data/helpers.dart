import "package:path/path.dart";
import "package:sqflite/sqflite.dart";

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;

  DatabaseHelper._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), "events.db");
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
        CREATE TABLE events (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          title TEXT NOT NULL,
          description TEXT NOT NULL,
          date TEXT NOT NULL 
        )
        ''');
  }

  Future<int> insertEvent(Map<String, dynamic> event) async {
    final db = await database;
    return await db.insert("events", event);
  }

  Future<List<Map<String, dynamic>>> getEvents() async {
    final db = await database;
    return await db.query("events", orderBy: "id DESC");
  }

  Future<int> deleteEvent(int id) async {
    final db = await database;
    return await db.delete("events", where: "id=?", whereArgs: [id]);
  }
}
