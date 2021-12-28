/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:sqflite_sqlcipher/sqflite.dart';

import '../model/api_email_sender_model.dart';

class ApiEmailSenderRepository {
  static const String _table = 'sender';
  static const String _upsertQuery = 'INSERT OR REPLACE INTO $_table '
      '(sender_id, name, email, category, unsubscribe_mail_to, ignore_until_epoch, email_since_epoch, unsubscribed_bool, created_epoch, modified_epoch) '
      'VALUES('
      '(SELECT sender_id '
      'FROM $_table '
      'WHERE email = ?2), '
      '?1, ?2, ?3, ?4, ?5, ?6, ?7,'
      '(SELECT IFNULL('
      '(SELECT created_epoch '
      'FROM $_table '
      'WHERE email = ?2), '
      'strftime(\'%s\', \'now\') * 1000)), '
      'strftime(\'%s\', \'now\') * 1000)';

  final Database _database;

  ApiEmailSenderRepository(this._database);

  Future<ApiEmailSenderModel> insert(ApiEmailSenderModel sender) async {
    DateTime now = DateTime.now();
    sender.modified = now;
    sender.created = now;
    int id = await _database.insert(_table, sender.toJson());
    sender.senderId = id;
    return sender;
  }

  Future<ApiEmailSenderModel> update(ApiEmailSenderModel sender) async {
    sender.modified = DateTime.now();
    await _database.update(
      _table,
      sender.toJson(),
      where: 'sender_id = ?',
      whereArgs: [sender.senderId],
    );
    return sender;
  }

  Future<int> batchUpsert(List<ApiEmailSenderModel> senders) async {
    if (senders.length > 0) {
      Batch batch = _database.batch();
      senders.forEach((data) => batch.rawInsert(
            _upsertQuery,
            [
              data.name,
              data.email,
              data.category,
              data.unsubscribeMailTo,
              data.ignoreUntil?.millisecondsSinceEpoch,
              data.emailSince?.millisecondsSinceEpoch,
              data.unsubscribed
            ],
          ));
      List res = await batch.commit(continueOnError: true);
      return res.length;
    } else
      return 0;
  }

  Future<ApiEmailSenderModel> upsert(ApiEmailSenderModel data) async {
    int id = await _database.rawInsert(_upsertQuery, [
      data.name,
      data.email,
      data.category,
      data.unsubscribeMailTo,
      data.ignoreUntil?.millisecondsSinceEpoch,
      data.emailSince?.millisecondsSinceEpoch,
      data.unsubscribed
    ]);
    data.senderId = id;
    return data;
  }

  Future<ApiEmailSenderModel?> getById(int id) async {
    final List<Map<String, Object?>> rows =
        await _select(where: "sender_id = ?", whereArgs: [id]);
    if (rows.isEmpty) return null;
    return ApiEmailSenderModel.fromJson(rows[0]);
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
    return rows.map((row) => ApiEmailSenderModel.fromJson(row)).toList();
  }

  Future<ApiEmailSenderModel?> getByEmail(String email) async {
    final List<Map<String, Object?>> rows =
        await _select(where: "email = ?", whereArgs: [email]);
    if (rows.isEmpty) return null;
    return ApiEmailSenderModel.fromJson(rows[0]);
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
                'sender.created_epoch AS \'sender@created_epoch\', '
                'sender.modified_epoch AS \'sender@modified_epoch\', '
                'company.company_id AS \'company@company_id\', '
                'company.logo AS \'company@logo\', '
                'company.security_score AS \'company@security_score\', '
                'company.breach_score AS \'company@breach_score\', '
                'company.sensitivity_score AS \'company@sensitivity_score\', '
                'company.domain AS \'company@domain\', '
                'company.created_epoch AS \'company@created_epoch\', '
                'company.modified_epoch AS \'company@modified_epoch\' '
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

  Future<void> delete(ApiEmailSenderModel sender) async {
    await _database
        .delete(_table, where: 'sender_id = ?', whereArgs: [sender.senderId]);
  }
}
