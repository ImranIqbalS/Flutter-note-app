import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class NotesDatabase {
  static final NotesDatabase instance = NotesDatabase._init();
  static Database? _database;
  NotesDatabase._init();

  Future<Database?> get database async {
    if (_database != null) return _database;
    _database = await _initializeDB('Notes.db');
    return _database;
  }

  Future<Database> _initializeDB(String filepath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filepath);
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
    CREATE TABLE Notes(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      pin BOLLEAN NOT NULL,
      title TEXT NOT NULL, 
      content TEXT NOT NULL,
      createdTime TEXT NOT NULL,
    )
    ''');
  }

  Future<bool?> create() async {
    final db = await instance.database;
    await db!.insert("Notes", {
      "pin": false,
      "title": "this is my title",
      "content": "this is my note content",
      "createdTime": "26 Jan 2018"
    });
    return true;
  }
}
