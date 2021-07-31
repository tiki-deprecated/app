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
  get database async {
    if (_db != null) return _db!;
    ApiUserModel user = await ApiUserService(FlutterSecureStorage()).get();
    if (user.keys == null) return _db;
    _db = await _initDBMemoizer.runOnce(() async {
      return await _initDB(user.keys!.signPrivateKey!);
    });

    return _db!;
  }

  /// Initializes the [Database].
  _initDB(String pass) async {
    print('initializing db');
    String databasePath = await getDatabasesPath();
    return await openDatabase(databasePath + "/tiki.db",
        password: pass, version: 2, onCreate: onCreate, onUpgrade: onUpgrade);
  }

  /// Database creation hook.
  static FutureOr<void> onCreate(Database db, int version) async {
    print('creating db');
    v1CreateTables(db);
    v2CreateTables(db);
  }

  FutureOr<void> onUpgrade(Database db, int oldVersion, int newVersion) {
    if (oldVersion <= 1) {
      v2CreateTables(db);
    }
  }

  static void v1CreateTables(Database db) async {
    await db.execute('''create table app_data (
              id integer primary key autoincrement,
              key text not null,
              value text not null)
            ''');
  }

  static void v2CreateTables(Database db) async {
    await db.execute('''create table sender (
              sender_id integer primary key autoincrement,
              company_id ,
              name text,
              email text,
              category text,
              unsubscribe_mail_to text,
              ignore_until integer,
              unsubscribed integer,
              action integer)
            ''');
    await db.execute('''create table company (
              company_id integer primary key autoincrement,
              logo text,
              security_score real,
              breach_score real,
              sensitivity_score real,
              domain text)
            ''');
    await db.execute('''create table message (
              message_id integer primary key autoincrement,
              ext_message_id text,
              sender_id integer,
              received_date integer,
              opened_date integer,
              account text)
            ''');
  }
}
