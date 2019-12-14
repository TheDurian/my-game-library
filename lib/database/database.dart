import 'dart:async';

import 'package:listr/models/game.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class GameDatabase {
  static final GameDatabase _instance = GameDatabase._();
  static Database _database;

  GameDatabase._();

  factory GameDatabase() => _instance;

  Future<Database> get db async {
    if (_database != null) return _database;
    _database = await init();
    return _database;
  }

  Future<Database> init() async {
    String path = await getDatabasesPath();
    path = join(path, 'game_entry_database.db');
    var database = openDatabase(path, version:1, onCreate: _onCreate, onUpgrade: _onUpgrade);
    return database;
  }

  void _onCreate(Database db, int version) {
    db.execute('''
      CREATE TABLE Game(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        ownedStatus TEXT,
        edition TEXT,
        price REAL,
        platform TEXT,
        playStatus TEXT,
        dateOfLastCompletion INTEGER,
        playtime INTEGER,
        notes TEXT
      )
    ''');
    print("Database was created");
  }

  void _onUpgrade(Database db, int oldVersion, int newVersion) {
    //Run migration according to database version
  }

  Future<int> addGame(Game game) async {
    var client = await db;
    return client.insert('Game', game.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<Game> fetchGame(int id) async {
    var client = await db;
    final Future<List<Map<String,dynamic>>> futureMaps = client.query('Game',where: 'id = ?', whereArgs: [id]);
    var maps = await futureMaps;
    if (maps.length != 0) return Game.fromDb(maps.first);
    return null;
  }

  Future<List<Game>> fetchAll() async {
    var client = await db;
    var res = await client.query('Game');
    if (res.isNotEmpty) {
      var games = res.map((game) => Game.fromDb(game)).toList();
      return games;
    }
    return [];
  }

  Future<int> updateGame(Game game) async {
    var client = await db;
    return client.update('Game', game.toMap(),
        where: 'id = ?', whereArgs: [game.id], conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> removeGame(int id) async {
    var client = await db;
    return client.delete('Game', where: 'id = ?', whereArgs: [id]);
  }

  Future closeDb() async {
    var client = await db;
    client.close();
  }


}