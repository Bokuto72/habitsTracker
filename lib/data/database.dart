import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseManager{
  static const dbName = "tracker.db";
  static const databaseVersion = 1;

  // DB tables;
  static const tableUsers = "users";
  static const tableTasks = "tasks";
  static const tableCategories = "categories";
  static const tableUserRewards = "user_rewards";
  static const tableRewards = "rewards";
  static const tableAgenda = "agenda";

  DatabaseManager._privateConstructor();
  static final DatabaseManager instance = DatabaseManager._privateConstructor();

  static Database? _database;
  Future<Database> get database async => _database ??= await _initDatabase();
  Future<Database?> get database1 async {
    if (_database == null) {
      _database = await _initDatabase();
    }
    return _database;
  }

  _initDatabase() async {
    String path = join(await getDatabasesPath(), dbName);
    return await openDatabase(path,
        version: databaseVersion, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE $tableUsers (
            id INTEGER PRIMARY KEY,
            pseudo VARCHAR(50) NOT NULL,
            level INTEGER NOT NULL,
            xp INTEGER NOT NULL,
            health INTEGER NOT NULL 
          )
          ''');
    await db.execute('''
          CREATE TABLE $tableTasks (
            id INTEGER PRIMARY KEY,
            label VARCHAR(250) NOT NULL,
            id_category INTEGER FOREIGN KEY REFERENCES $tableCategories (id)
          )
          ''');
    await db.execute('''
          CREATE TABLE $tableCategories (
            id INTEGER PRIMARY KEY,
            name VARCHAR(50) NOT NULL,
            color VARCHAR(7) NOT NULL,
          )
          ''');
    await db.execute('''
          CREATE TABLE $tableUserRewards (
            id INTEGER,
            PRIMARY KEY (id),
            FOREIGN KEY (id) REFERENCES $tableRewards (id)
          ''');
    await db.execute('''
          CREATE TABLE $tableRewards (
            id INTEGER PRIMARY KEY,
            value INTEGER NOT NULL,
            name VARCHAR(50) NOT NULL
          ''');
    await db.execute('''
          CREATE TABLE $tableAgenda (
            id INTEGER,
            PRIMARY KEY (id),
            FOREIGN KEY (id) REFERENCES $tableTasks (id)
          ''');
  }

  //======
  // CRUD
  //======

  // CREATE
  Future<int> insert(String tableName, Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.insert(tableName, row);
  }

  // READ (all rows)
  Future<List<Map<String, dynamic>>> queryAllRows(String tableName) async {
    Database db = await instance.database;
    return await db.query(tableName);
  }

  // READ (row count)
  Future<int> queryRowCount(String tableName) async {
    Database db = await instance.database;
    return Sqflite.firstIntValue(await db.rawQuery('SELECT COUNT(*) FROM $tableName')) ?? 0;
  }

  // UPDATE
  Future<int> update(String tableName, Map<String, dynamic> row) async {
    Database db = await instance.database;
    int id = row['id'];
    return await db.update(tableName, row, where: 'id = ?', whereArgs: [id]);
  }

  // DELETE
  Future<int> delete(String tableName, int id) async {
    Database db = await instance.database;
    return await db.delete(tableName, where: 'id = ?', whereArgs: [id]);
  }
}