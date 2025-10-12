import 'package:packages/models/log.dart';
import 'package:packages/models/user.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseService{
  static Database? _database;

  Future<Database> get database async {
    if(_database != null) return _database!;
    _database = await initDatabase();
    return _database!;
  }

  Future<Database> initDatabase() async {
    final dir = await getApplicationDocumentsDirectory();
    final path = join(dir.path, 'database.db');
    // await deleteDatabase(path);
    return openDatabase(
      path,
      onCreate: (db, version) async {
        await db.execute('CREATE TABLE logs(id INTEGER PRIMARY KEY, title TEXT, poster TEXT, watched BOOLEAN, liked BOOLEAN, watchlisted BOOLEAN, user TEXT, createdAt TIMESTAMP)');
        await db.execute('CREATE TABLE users(id TEXT PRIMARY KEY, username TEXT, password TEXT, image TEXT)');

      },
      version: 1
    );
  }

  Future<void> insertLog(Log log) async {
    final db = await database;
    await db.insert('logs', log.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> insertUser(User user) async {
    final db = await database;
    await db.insert('users', user.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<Log>> retrieveLogs() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('logs');
    return List.generate(maps.length, (index) {
      return Log.fromMap(maps[index]);
    },);
  }

  Future<List<User>> retrieveUsers() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('users');
    return List.generate(maps.length, (index) {
      return User.fromMap(maps[index]);
    },);
  }

  Future<void> updateLog(Log log) async {
    final db = await database;

    await db.update('logs', log.toMap(), where: 'id = ?', whereArgs: [log.id]);
  }

  Future<void> deleteLog(int id) async {
    final db = await database;

    await db.delete('logs', where: 'id = ?', whereArgs: [id]);
  }
}