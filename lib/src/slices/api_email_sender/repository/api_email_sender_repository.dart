/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:sqflite_sqlcipher/sqflite.dart';

import '../model/api_email_sender_model.dart';

class ApiEmailSenderRepository {
  static const String _table = 'sender';
  final Database _database;

  ApiEmailSenderRepository(this._database);

  Future<ApiEmailSenderModel> insert(ApiEmailSenderModel sender) async {
    int id = await _database.insert(_table, sender.toMap());
    sender.senderId = id;
    return sender;
  }

  Future<ApiEmailSenderModel> update(ApiEmailSenderModel sender) async {
    await _database.update(
      _table,
      sender.toMap(),
      where: 'sender_id = ?',
      whereArgs: [sender.senderId],
    );
    return sender;
  }

  //todo clean this up to be explicit
  Future<List<ApiEmailSenderModel>> getByParams(
      List<List<String?>> params) async {
    String where = '';
    List<String?> whereArgs = [];
    List<String?> whereParams = [];
    if (params.isNotEmpty) {
      params.forEach((param) {
        if (param[0] != null && param[1] != null) {
          whereParams.add(param[0]! + ' ' + param[1]! + ' ?');
          whereArgs.add(param[2] != null ? "${param[2]}" : 'NULL');
        }
      });
      where = whereParams.join(' AND ');
    }
    final List<Map<String, Object?>> rows =
        await _database.query(_table, where: where, whereArgs: whereArgs);
    if (rows.isEmpty) return List.empty();
    return rows.map((row) => ApiEmailSenderModel.fromMap(row)).toList();
  }

  Future<ApiEmailSenderModel?> getById(int id) async {
    final List<Map<String, Object?>> rows =
        await _database.query(_table, where: "sender_id = ?", whereArgs: [id]);
    if (rows.isEmpty) return null;
    return ApiEmailSenderModel.fromMap(rows[0]);
  }

  Future<ApiEmailSenderModel?> getByEmail(String email) async {
    final List<Map<String, Object?>> rows =
        await _database.query(_table, where: "email = ?", whereArgs: [email]);
    if (rows.isEmpty) return null;
    return ApiEmailSenderModel.fromMap(rows[0]);
  }
}
