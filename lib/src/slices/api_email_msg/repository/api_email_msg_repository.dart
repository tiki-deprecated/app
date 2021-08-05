/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:sqflite_sqlcipher/sqflite.dart';

import '../model/api_email_msg_model.dart';

class ApiEmailMsgRepository {
  static const String _table = 'message';
  final Database _database;

  ApiEmailMsgRepository(this._database);

  Future<ApiEmailMsgModel> insert(ApiEmailMsgModel message) async {
    int id = await _database.insert(_table, message.toMap());
    message.messageId = id;
    return message;
  }

  Future<List<ApiEmailMsgModel>> get(ApiEmailMsgModel subject) async {
    var subjectMap = subject.toMap();
    String where = subjectMap.keys.join(' = ? AND ') + "= ?";
    List<String?> whereArgs = subjectMap.values
        .map((entry) => entry != null ? "${entry.toString()}" : 'NULL')
        .toList();
    final List<Map<String, Object?>> rows =
        await _database.query(_table, where: where, whereArgs: whereArgs);
    if (rows.isEmpty) return List.empty();
    return rows.map((row) => ApiEmailMsgModel.fromMap(row)).toList();
  }

  Future<List<ApiEmailMsgModel>> getByParams(List<List<String?>> params) async {
    String where = '';
    List<String?> whereArgs = [];
    List<String?> whereParams = [];
    if (params.isNotEmpty) {
      params.forEach((param) {
        if (param[0] != null && param[1] != null) {
          whereParams.add(param[0]! + ' ' + param[1]! + ' ?');
          whereArgs.add(param[2] != null ? "${param[2].toString()}" : 'NULL');
        }
      });
      where = whereParams.join(' AND ');
    }
    final List<Map<String, Object?>> rows =
        await _database.query(_table, where: where, whereArgs: whereArgs);
    if (rows.isEmpty) return List.empty();
    return rows.map((row) => ApiEmailMsgModel.fromMap(row)).toList();
  }
}
