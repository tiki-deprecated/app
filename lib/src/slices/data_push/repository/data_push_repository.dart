/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:sqflite_sqlcipher/sqlite_api.dart';

import '../model/data_push_model.dart';

class DataPushRepository {
  static const String _table = 'data_push_queue';
  final Database _database;

  DataPushRepository(this._database);

  Future<void> insert(List<DataPushModel> data) async {
    StringBuffer query = new StringBuffer();
    query.write('INSERT INTO ' +
        _table +
        '(from_type, from_value, to_type, to_value, fingerprint, created_epoch) VALUES ');
    for (DataPushModel d in data) {
      query.write('(');
      query.write(
          (d.fromType != null ? "\"" + d.fromType! + "\"" : "null") + ",");
      query.write(
          (d.fromValue != null ? "\"" + d.fromValue! + "\"" : "null") + ",");
      query.write((d.toType != null ? "\"" + d.toType! + "\"" : "null") + ",");
      query
          .write((d.toValue != null ? "\"" + d.toValue! + "\"" : "null") + ",");
      query.write(
          (d.fingerprint != null ? "\"" + d.fingerprint! + "\"" : "null") +
              ",");
      query.write((DateTime.now().millisecondsSinceEpoch));
      query.write('),');
    }
    await _database.rawInsert(query.toString().substring(0, query.length - 1));
  }

  Future<List<DataPushModel>> getAll({int offset = 0, int limit = 1000}) async {
    List<Map<String, Object?>> rows = await _database.query(_table,
        columns: [
          'queue_id',
          'from_type',
          'from_value',
          'to_type',
          'to_value',
          'fingerprint',
          'created_epoch'
        ],
        offset: 0,
        limit: limit);
    if (rows.isEmpty)
      return List.empty();
    else
      return rows.map((row) => DataPushModel.fromMap(row)).toList();
  }

  Future<int> getSize() async {
    List<Map<String, Object?>> rows =
        await _database.rawQuery("SELECT count(*) as count FROM " + _table);
    if (rows.isNotEmpty) {
      int? count = rows[0]["count"] as int?;
      return count ?? 0;
    }
    return 0;
  }

  Future<void> deleteByIds(List<int> ids) async {
    StringBuffer whereBuf = new StringBuffer();
    whereBuf.write('queue_id IN (');
    for (int id in ids) whereBuf.write(id.toString() + ",");
    String where = whereBuf.toString().substring(0, whereBuf.length - 1) + ')';
    _database.delete(_table, where: where);
  }

//get all
  //delete by ids
  //get length
  //add
}
