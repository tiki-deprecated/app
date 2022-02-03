/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:flutter/services.dart';
import 'package:logging/logging.dart';
import 'package:sqflite_sqlcipher/sqflite.dart';

final _log = Logger('DatabaseService');

Future<Database> open(String password,
    {int version = 7, bool drop = false, String dbName = 'tiki_app.db'}) async {
  String databasePath = await getDatabasesPath() + '/' + dbName;
  if (drop) await deleteDatabase(databasePath);
  return await openDatabase(databasePath,
      password: password,
      version: version,
      onConfigure: onConfigure,
      onCreate: onCreate,
      onUpgrade: onUpgrade,
      onDowngrade: onDowngrade,
      onOpen: onOpen);
}

Future<void> onConfigure(Database db) async => _log.fine('configure');

//TODO fix these SQL files
Future<void> onCreate(Database db, int version) async {
  _log.fine('create');
  await _executeScript(db, 'sql_v1');
  await _executeScript(db, 'sql_v2');
  await _executeScript(db, 'sql_v4');
  await _executeScript(db, 'sql_v5');
  await _executeScript(db, 'sql_v6');
  await _executeScript(db, 'sql_v7');
}

Future<void> onUpgrade(Database db, int oldVersion, int newVersion) async {
  _log.fine('upgrade');
  if (oldVersion < 2) await _executeScript(db, 'sql_v2');
  if (oldVersion < 4) await _executeScript(db, 'sql_v4');
  if (oldVersion < 5) await _executeScript(db, 'sql_v5');
  if (oldVersion < 6) await _executeScript(db, 'sql_v6');
  if (oldVersion < 7) await _executeScript(db, 'sql_v7');
}

Future<void> onDowngrade(Database db, int oldVersion, int newVersion) async =>
    _log.severe('database downgrade not supported');

Future<void> onOpen(Database db) async => _log.fine('open');

Future<void> _executeScript(Database db, String name) async {
  String script = await rootBundle.loadString('res/sql/' + name + '.sql');
  List<String> sqlList = script.split(";");
  for (String sqlString in sqlList) {
    String sql = sqlString.trim();
    if (sql.isNotEmpty) await db.execute(sql);
  }
}
