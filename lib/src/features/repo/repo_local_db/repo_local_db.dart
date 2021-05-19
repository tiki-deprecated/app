import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:async/async.dart';

class TikiDatabase {
  static final TikiDatabase? _tikiDatabase = new TikiDatabase._internal();
  TikiDatabase._internal();
  static TikiDatabase? get instance => _tikiDatabase;

  static Database? _db;
  final _initDBMemoizer = AsyncMemoizer<Database>();

  Future<Database?> get database async {
    if (_db != null)
      return _db;

    _db = await _initDBMemoizer.runOnce(() async {
      return await _initDB();
    });

    return _db;
  }

  Future<Database> _initDB() async {
    print('initializing db');
    String databasePath = await getDatabasesPath();
    return await openDatabase(databasePath + "/tiki.db", version: 1, onCreate: onCreate);
  }


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