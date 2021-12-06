/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import '../model/data_fetch_model_msg.dart';
import 'package:logging/logging.dart';
import 'package:sqflite_sqlcipher/sqflite.dart';

class DataFetchMsgRepository {
  final _log = Logger('DataFetchMsgRepository');
  static const String _table = 'data_fetch_message';
  final Database _database;

  DataFetchMsgRepository(this._database);

  Future<DataFetchModelMsg> insert(DataFetchModelMsg message) async {
    int id = await _database.insert(_table, message.toMap());
    _log.finest("Insert #" + id.toString());
    message.data_fetch_message_id = id;
    return message;
  }

  Future<DataFetchModelMsg?> getByExtMessageIdAndAccount(
      String extMessageId, String account) async {
    final List<Map<String, Object?>> rows = await _select(
        where: 'ext_message_id = ? AND account = ?',
        whereArgs: [extMessageId, account]);
    if (rows.isEmpty) return null;
    return DataFetchModelMsg.fromMap(rows[0]);
  }

  Future<List<Map<String, Object?>>> _select(
      {String? where, List<Object?>? whereArgs}) async {
    List<Map<String, Object?>> rows = await _database.rawQuery(
        'SELECT data_fetch_message.data_fetch_message_id AS \'message@message_id\', '
                'data_fetch_message.ext_message_id AS \'message@ext_message_id\', '
                'data_fetch_message.account AS \'message@account\'' +
            (where != null ? 'WHERE ' + where : ''),
        whereArgs);
    if (rows.isEmpty) return List.empty();
    return rows.map((row) {
      Map<String, Object?> messageMap = Map();
      row.entries.forEach((element) {
        if (element.key.contains('data_fetch_message@'))
          messageMap[element.key.replaceFirst('data_fetch_message@', '')] = element.value;
      });
      return messageMap;
    }).toList();
  }

  Future<List<DataFetchModelMsg>> getByAccount(String account) async {
    final List<Map<String, Object?>> rows =
        await _select(where: 'account = ?', whereArgs: [account]);
    if (rows.isEmpty) return List.empty();
    return rows.map((row) => DataFetchModelMsg.fromMap(row)).toList();
  }

  Future<void> delete(DataFetchModelMsg message) async {
    await _database.delete(_table,
        where: 'data_fetch_message_id = ?', whereArgs: [message.data_fetch_message_id]);
  }

  Future<void> saveList(List<DataFetchModelMsg> messages) async {
    messages.forEach((message) async {
      await insert(message);
    });
  }
}
