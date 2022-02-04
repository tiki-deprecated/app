/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:sqflite_sqlcipher/sqlite_api.dart';

import '../model/data_fetch_model_api.dart';
import '../model/data_fetch_model_last.dart';

class DataFetchRepositoryLast {
  static const String _table = 'data_fetch_last';

  final Database _database;

  DataFetchRepositoryLast(this._database);

  Future<DataFetchModelLast> upsert(DataFetchModelLast data) async {
    int id = await _database.rawInsert(
        'INSERT OR REPLACE INTO $_table '
        '(fetch_id, account_id, api_enum, fetched_epoch) '
        'VALUES('
        '(SELECT fetch_id '
        'FROM $_table '
        'WHERE account_id = ?1 AND api_enum = ?2), '
        '?1, ?2,'
        'strftime(\'%s\', \'now\') * 1000)',
        [data.account!.accountId, data.api?.value]);
    data.fetchId = id;
    return data;
  }

  Future<DataFetchModelLast?> getByAccountIdAndApi(
      int accountId, DataFetchModelApi api) async {
    final List<Map<String, Object?>> rows = await _database.query(_table,
        where: "account_id = ? AND api_enum = ?",
        whereArgs: [accountId, api.value]);
    if (rows.isEmpty) return null;
    return DataFetchModelLast.fromJson(rows[0]);
  }
}
