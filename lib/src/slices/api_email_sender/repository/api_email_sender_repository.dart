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
    sender.updated_epoch = DateTime.now().millisecondsSinceEpoch;
    return sender;
  }

  Future<ApiEmailSenderModel> update(ApiEmailSenderModel sender) async {
    sender.updated_epoch = DateTime.now().millisecondsSinceEpoch;
    await _database.update(
      _table,
      sender.toMap(),
      where: 'sender_id = ?',
      whereArgs: [sender.senderId],
    );
    return sender;
  }

  Future<ApiEmailSenderModel?> getById(int id) async {
    final List<Map<String, Object?>> rows =
        await _select(where: "sender_id = ?", whereArgs: [id]);
    if (rows.isEmpty) return null;
    return ApiEmailSenderModel.fromMap(rows[0]);
  }

  Future<List<ApiEmailSenderModel>> getByUnsubscribedAndIgnoreUntilBefore(
      bool unsubscribed, DateTime beforeDate) async {
    final List<Map<String, Object?>> rows = await _select(
        where: 'unsubscribed_bool = ? AND ignore_until_epoch < ?',
        whereArgs: [
          unsubscribed == true ? 1 : 0,
          beforeDate.millisecondsSinceEpoch
        ]);
    if (rows.isEmpty) return List.empty();
    return rows.map((row) => ApiEmailSenderModel.fromMap(row)).toList();
  }

  Future<ApiEmailSenderModel?> getByEmail(String email) async {
    final List<Map<String, Object?>> rows =
        await _select(where: "email = ?", whereArgs: [email]);
    if (rows.isEmpty) return null;
    return ApiEmailSenderModel.fromMap(rows[0]);
  }

  Future<List<Map<String, Object?>>> _select(
      {String? where, List<Object?>? whereArgs}) async {
    List<Map<String, Object?>> rows = await _database.rawQuery(
        'SELECT sender.sender_id AS \'sender@sender_id\', '
                'sender.name AS \'sender@name\', sender.email AS \'sender@email\', '
                'sender.category AS \'sender@category\', '
                'sender.unsubscribe_mail_to AS \'sender@unsubscribe_mail_to\', '
                'sender.email_since_epoch AS \'sender@email_since_epoch\', '
                'sender.ignore_until_epoch AS \'sender@ignore_until_epoch\', '
                'sender.unsubscribed_bool AS \'sender@unsubscribed_bool\', '
                'company.company_id AS \'company@company_id\', '
                'company.logo AS \'company@logo\', '
                'company.security_score AS \'company@security_score\', '
                'company.breach_score AS \'company@breach_score\', '
                'company.sensitivity_score AS \'company@sensitivity_score\', '
                'company.domain AS \'company@domain\' '
                'FROM sender AS sender '
                'INNER JOIN company AS company '
                'ON company.company_id = sender.company_id ' +
            (where != null ? 'WHERE ' + where : ''),
        whereArgs);
    if (rows.isEmpty) return List.empty();
    return rows.map((row) {
      Map<String, Object?> senderMap = Map();
      Map<String, Object?> companyMap = Map();
      row.entries.forEach((element) {
        if (element.key.contains('sender@'))
          senderMap[element.key.replaceFirst('sender@', '')] = element.value;
        else if (element.key.contains('company@'))
          companyMap[element.key.replaceFirst('company@', '')] = element.value;
      });
      senderMap['company'] = companyMap;
      return senderMap;
    }).toList();
  }
}
