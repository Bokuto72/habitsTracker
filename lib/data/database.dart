import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseManager {
  static const dbName = 'tracker.db';
  static const databaseVersion = 1;

  // DB tables;
  static const tableUsers = "users";
  static const tableTasks = "tasks";
  static const tableCategories = "categories";
  static const tableUserRewards = "user_rewards";
  static const tableRewards = "rewards";
  static const tableAgenda = "agenda";

  static final DatabaseManager instance = DatabaseManager._init();

  static Database? _database;

  DatabaseManager._init();

  Future<Database> get database async {
    if(_database != null) {
      return _database!;
    }

    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, dbName);
    print("salut");
    return await openDatabase(
        path,
        version: databaseVersion,
        onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    print("jinbe");
    await db.execute('''
          CREATE TABLE $tableUsers (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            pseudo VARCHAR(50) NOT NULL,
            level INTEGER NOT NULL,
            xp INTEGER NOT NULL,
            health INTEGER NOT NULL
          )
          ''');
    await db.execute('''
          CREATE TABLE $tableCategories (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name VARCHAR(50) NOT NULL,
            color VARCHAR(8) NOT NULL
          )
          ''');
    await db.execute('''
          CREATE TABLE $tableTasks (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            label VARCHAR(250) NOT NULL,
            id_category INTEGER NOT NULL,
            FOREIGN KEY (id) REFERENCES $tableCategories (id)
          )
          ''');
    await db.execute('''
          CREATE TABLE $tableRewards (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            value INTEGER NOT NULL,
            name VARCHAR(50) NOT NULL
          )
          ''');
    await db.execute('''
          CREATE TABLE $tableUserRewards (
            id INTEGER,
            PRIMARY KEY (id),
            FOREIGN KEY (id) REFERENCES $tableRewards (id)
          )
          ''');
    await db.execute('''
          CREATE TABLE $tableAgenda (
            id INTEGER,
            PRIMARY KEY (id),
            FOREIGN KEY (id) REFERENCES $tableTasks (id)
          )
          ''');
  }

  //======
  // CRUD
  //======

  // CREATE
  Future<void> insert(String tableName, Map<String, dynamic> row) async {
    final db = await instance.database;
    await db.insert(tableName, row);
  }

  // READ (all rows)
  Future<List<Map<String, dynamic>>> queryAllRows(String tableName) async {
    final db = await instance.database;
    final List<Map<String, Object?>> maps = await db.query(tableName);
    return maps;
  }

  // READ (row count)
  Future<int> queryRowCount(String tableName) async {
    final db = await instance.database;
    final nbOfRows = Sqflite.firstIntValue(await db.rawQuery('SELECT COUNT(*) FROM $tableName')) ?? 0;
    return nbOfRows;
  }

  // UPDATE
  Future<void> update(String tableName, Map<String, dynamic> row) async {
    final db = await instance.database;
    int id = row['id'];
    await db.update(tableName, row, where: 'id = ?', whereArgs: [id]);
  }

  // DELETE
  Future<int> delete(String tableName, int id) async {
    Database db = await instance.database;
    return await db.delete(tableName, where: 'id = ?', whereArgs: [id]);
  }
}