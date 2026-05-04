import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as path;

class DbUtil {
  static const String _databaseName = 'tarefas_app.db';
  static const int _databaseVersion = 1;

  DbUtil._privateConstructor();
  static final DbUtil instance = DbUtil._privateConstructor();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final localBanco = path.join(dbPath, _databaseName);

    return await openDatabase(
      localBanco,
      version: _databaseVersion,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE tarefas (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        titulo TEXT NOT NULL,
        descricao TEXT NOT NULL,
        dataPrevista TEXT NOT NULL,
        importante INTEGER NOT NULL,
        realizada INTEGER NOT NULL,
        categoria TEXT NOT NULL
      )
    ''');
  }
}