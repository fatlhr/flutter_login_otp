import 'dart:async';
import 'dart:io';

import 'package:flutter_login_otp/app/models/user_model.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  final String _dbName = 'my_users.db';
  final String _tableName = 'users';
  static const int _dbVersion = 1;

  // User Table
  static const String _colId = 'id';
  static const String _colUsername = 'username';
  static const String _colEmail = 'email';
  static const String _colPassword = 'password';

  Database? _db;

  Future<Database> database() async {
    if (_db != null) return _db!;
    _db = await _initDatabase();
    return _db!;
  }

  Future _initDatabase() async {
    Directory dir = await getApplicationDocumentsDirectory();
    String path = join(dir.path, _dbName);
    return await openDatabase(path, version: _dbVersion, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $_tableName (
        $_colId INTEGER PRIMARY KEY AUTOINCREMENT,
        $_colUsername TEXT NOT NULL,
        $_colEmail TEXT NOT NULL,
        $_colPassword TEXT NOT NULL
      )
    ''');
  }

  // Insert user
  Future<int> insertUser(UserModel row) async {
    final query = await _db!.insert(_tableName, row.toJson());
    return query;
  }

  // get login
  Future<UserModel?> getLogin(String email, String password) async {
    var res = await _db!.rawQuery("SELECT * FROM $_tableName WHERE $_colEmail = '$email' and $_colPassword = '$password'");

    if (res.isNotEmpty) {
      return UserModel.fromJson(res.first);
    }

    return null;
  }

  // Get all users
  Future<List<UserModel>> getAllUsers() async {
    final query = await _db!.query(_tableName);
    return query.toList().map((e) => UserModel.fromJson(e)).toList();
  }
}
