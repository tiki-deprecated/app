/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:logging/logging.dart';
import 'package:sqflite_sqlcipher/sqflite.dart';

final _log = Logger('UtilsDatabase');

Future<Database> open(String password,
    {int version = 7, bool drop = false, String dbName = 'tiki_app.db'}) async {
  String databasePath = await getDatabasesPath() + '/' + dbName;
  if (drop) await deleteDatabase(databasePath);
  return await openDatabase(databasePath, password: password, version: version);
}
