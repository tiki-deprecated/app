import 'dart:async';

import 'package:app/src/slices/api_user/api_user_service.dart';
import 'package:app/src/slices/api_user/model/api_user_model.dart';
import 'package:async/async.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:sqflite_sqlcipher/sqflite.dart';

/// The SQLite conector
///
/// The SQLite conector with singleton architecture. To initialize the database,
/// just call TikiDatabase.instance.database.
class ApiSqliteRepository {
  /// Internal empty constructor
  ApiSqliteRepository._internal();

  /// The database singleton.
  static final ApiSqliteRepository _tikiDatabase =
      new ApiSqliteRepository._internal();

  /// The database singleton instance getter.
  static ApiSqliteRepository get instance => _tikiDatabase;

  /// The internal [Database].
  static Database? _db;

  /// [AsynMemoizer]
  final _initDBMemoizer = AsyncMemoizer<Database>();

  /// The public [Database] getter.
  Future<Database> get database async {
    if (_db != null) return _db!;

    _db = await _initDBMemoizer.runOnce(() async {
      return await _initDB();
    });

    return _db!;
  }

  /// Initializes the [Database].
  Future<Database> _initDB() async {
    print('initializing db');
    String databasePath = await getDatabasesPath();
    ApiUserModel user = await ApiUserService(FlutterSecureStorage()).get();
    return await openDatabase(databasePath + "/tiki.db",
        password: user.keys!.dataPrivateKey,
        version: 2,
        onCreate: onCreate,
        onUpgrade: onUpgrade);
  }

  /// Database creation hook.
  static FutureOr<void> onCreate(Database db, int version) async {
    print('creating db');
    await db.execute('''
            create table app_data (
              id integer primary key autoincrement,
              key text not null,
              value text not null)
            ''');
    await db.execute('''
            create table sender (
              id integer primary key autoincrement,
              key text not null,
              value text not null)
            ''');
    await db.execute('''
            create table company (
              id integer primary key autoincrement,
              key text not null,
              value text not null)
            ''');
    await db.execute('''
            create table message (
              id integer primary key autoincrement,
              key text not null,
              value text not null)
            ''');
    await db.execute('''
            create table app_data (
              id integer primary key autoincrement,
              key text not null,
              value text not null)
            ''');
  }

  FutureOr<void> onUpgrade(Database db, int oldVersion, int newVersion) {
    if (oldVersion <= 1) {}
  }
}
