import 'dart:async';

import 'package:async/async.dart';
import 'package:sqflite/sqflite.dart';

/// The SQLite conector
///
/// The SQLite conector with singleton architecture. To initialize the database,
/// just call TikiDatabase.instance.database.
class DatabaseRepository {
  /// Internal empty constructor
  DatabaseRepository._internal();

  /// The database singleton.
  static final DatabaseRepository? _tikiDatabase =
      new DatabaseRepository._internal();

  /// The database singleton instance getter.
  static DatabaseRepository? get instance => _tikiDatabase;

  /// The internal [Database].
  static Database? _db;

  /// [AsynMemoizer]
  final _initDBMemoizer = AsyncMemoizer<Database>();

  /// The public [Database] getter.
  Future<Database?> get database async {
    if (_db != null) return _db;

    _db = await _initDBMemoizer.runOnce(() async {
      return await _initDB();
    });

    return _db;
  }

  /// Initializes the [Database].
  Future<Database> _initDB() async {
    print('initializing db');
    String databasePath = await getDatabasesPath();
    return await openDatabase(databasePath + "/tiki.db",
        version: 1, onCreate: onCreate);
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
  }
}
