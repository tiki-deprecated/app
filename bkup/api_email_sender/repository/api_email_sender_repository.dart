/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:sqflite_sqlcipher/sqflite.dart';

import '../../../lib/src/slices/api_email_sender/model/api_email_sender_model.dart';

class ApiEmailSenderRepository {
  static const String _table = 'sender';
  final Database _database;

  ApiEmailSenderRepository(this._database);

  Future<ApiEmailSenderModel> insert(ApiEmailSenderModel sender) async {
    int senderId = await _database.insert(_table, sender.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    sender.senderId = senderId;
    return sender;
  }

  Future<List<ApiEmailSenderModel>> get(ApiEmailSenderModel subject,
      {keepNull: false}) async {
    var subjectMap = subject.toMap();
    if (!keepNull) subjectMap.removeWhere((key, value) => value == null);
    String where = subjectMap.keys.join(' = ? AND ') + " = ?";
    List<String?> whereArgs = subjectMap.values
        .map((entry) => entry != null ? "'${entry.toString()}'" : 'NULL')
        .toList();
    final List<Map<String, Object?>> mappedSenders =
        await _database.query(_table, where: where, whereArgs: whereArgs);
    return List.generate(mappedSenders.length,
        (i) => ApiEmailSenderModel.fromMap(mappedSenders[i]));
  }

  Future<List<ApiEmailSenderModel>> getAll() async {
    final List<Map<String, dynamic>> allMapped = await _database.query(_table);
    return List.generate(
        allMapped.length, (i) => ApiEmailSenderModel.fromMap(allMapped[i]));
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

  Future<void> delete(int id) async {
    await _database.delete(
      _table,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

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
    final List<Map<String, Object?>> mappedSenders =
        await _database.query(_table, where: where, whereArgs: whereArgs);
    return List.generate(mappedSenders.length,
        (i) => ApiEmailSenderModel.fromMap(mappedSenders[i]));
  }

  Future<ApiEmailSenderModel> getById(int id) async {
    final List<Map<String, Object?>> mappedCompanies =
        await _database.query(_table, where: "sender_id = ?", whereArgs: [id]);
    return List.generate(mappedCompanies.length,
        (i) => ApiEmailSenderModel.fromMap(mappedCompanies[i])).first;
  }

  Future<ApiEmailSenderModel?> getByEmail(String email) async {
    final List<Map<String, Object?>> mappedCompanies =
        await _database.query(_table, where: "email = ?", whereArgs: [email]);
    final sender = List.generate(mappedCompanies.length,
        (i) => ApiEmailSenderModel.fromMap(mappedCompanies[i]));
    return sender.length == 0 ? null : sender.first;
  }
}
