/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:logging/logging.dart';
import 'package:sqflite_sqlcipher/sqflite.dart';

import '../model/api_email_msg_model.dart';

class ApiEmailMsgRepository {
  final _log = Logger('ApiEmailMsgRepository');
  static const String _table = 'message';
  static const String _upsertQuery = 'INSERT OR REPLACE INTO $_table '
      '(message_id, ext_message_id, sender_email, received_date_epoch, opened_date_epoch, to_email, created_epoch, modified_epoch) '
      'VALUES('
      '(SELECT message_id '
      'FROM $_table '
      'WHERE ext_message_id = ?1 AND to_email = ?5), '
      '?1, ?2, ?3, ?4, ?5, '
      '(SELECT IFNULL('
      '(SELECT created_epoch '
      'FROM $_table '
      'WHERE ext_message_id = ?1 AND to_email = ?5), '
      'strftime(\'%s\', \'now\') * 1000)), '
      'strftime(\'%s\', \'now\') * 1000)';

  final Database _database;

  ApiEmailMsgRepository(this._database);

  Future<ApiEmailMsgModel> insert(ApiEmailMsgModel message) async {
    DateTime now = DateTime.now();
    message.modified = now;
    message.created = now;
    int id = await _database.insert(_table, message.toJson());
    _log.finest("Insert #" + id.toString());
    message.messageId = id;
    return message;
  }

  Future<ApiEmailMsgModel> update(ApiEmailMsgModel message) async {
    message.modified = DateTime.now();
    await _database.update(
      _table,
      message.toJson(),
      where: 'message_id = ?',
      whereArgs: [message.messageId],
    );
    _log.finest("update #" + message.messageId.toString());
    return message;
  }

  Future<int> batchUpsert(List<ApiEmailMsgModel> messages) async {
    if (messages.length > 0) {
      Batch batch = _database.batch();
      messages.forEach((data) => batch.rawInsert(
            _upsertQuery,
            [
              data.extMessageId,
              data.sender?.email,
              data.receivedDate?.millisecondsSinceEpoch,
              data.openedDate?.millisecondsSinceEpoch,
              data.toEmail
            ],
          ));
      List res = await batch.commit(continueOnError: true);
      return res.length;
    } else
      return 0;
  }

  Future<ApiEmailMsgModel> upsert(ApiEmailMsgModel data) async {
    int id = await _database.rawInsert(_upsertQuery, [
      data.extMessageId,
      data.sender?.email,
      data.receivedDate?.millisecondsSinceEpoch,
      data.openedDate?.millisecondsSinceEpoch,
      data.toEmail
    ]);
    data.messageId = id;
    return data;
  }

  Future<ApiEmailMsgModel?> getByExtMessageIdAndTo(
      String extMessageId, String toEmail) async {
    final List<Map<String, Object?>> rows = await _select(
        where: 'ext_message_id = ? AND to_email = ?',
        whereArgs: [extMessageId, toEmail]);
    if (rows.isEmpty) return null;
    return ApiEmailMsgModel.fromJson(rows[0]);
  }

  Future<List<ApiEmailMsgModel>> getByExtMessageIds(
      List<String> extMessageIds) async {
    final List<Map<String, Object?>> rows = await _select(
        where: 'ext_message_id IN (' +
            extMessageIds.map((s) => '\'' + s + '\'').join(", ") +
            ')');
    if (rows.isEmpty) return List.empty();
    return rows.map((row) => ApiEmailMsgModel.fromJson(row)).toList();
  }

  Future<List<ApiEmailMsgModel>> getBySenderEmail(String email) async {
    final List<Map<String, Object?>> rows =
        await _select(where: 'sender.email = ?', whereArgs: [email]);
    if (rows.isEmpty) return List.empty();
    return rows.map((row) => ApiEmailMsgModel.fromJson(row)).toList();
  }

  Future<List<Map<String, Object?>>> _select(
      {String? where, List<Object?>? whereArgs}) async {
    List<Map<String, Object?>> rows = await _database.rawQuery(
        'SELECT message.message_id AS \'message@message_id\', '
                'message.ext_message_id AS \'message@ext_message_id\', '
                'message.to_email AS \'message@to_email\', '
                'message.received_date_epoch AS \'message@received_date_epoch\', '
                'message.opened_date_epoch AS \'message@opened_date_epoch\', '
                'message.created_epoch AS \'message@created_epoch\', '
                'message.modified_epoch AS \'message@modified_epoch\', '
                'sender.sender_id AS \'sender@sender_id\', '
                'sender.name AS \'sender@name\', '
                'message.sender_email AS \'sender@email\', '
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
                'sender.company_domain AS \'company@domain\', '
                'company.created_epoch AS \'company@created_epoch\', '
                'company.modified_epoch AS \'company@modified_epoch\' '
                'FROM message AS message '
                'LEFT JOIN sender AS sender '
                'ON sender.email = message.sender_email '
                'LEFT JOIN company AS company '
                'ON company.domain = sender.company_domain ' +
            (where != null ? 'WHERE ' + where : ''),
        whereArgs);
    if (rows.isEmpty) return List.empty();
    return rows.map((row) {
      Map<String, Object?> messageMap = Map();
      Map<String, Object?> senderMap = Map();
      Map<String, Object?> companyMap = Map();
      row.entries.forEach((element) {
        if (element.key.contains('message@'))
          messageMap[element.key.replaceFirst('message@', '')] = element.value;
        else if (element.key.contains('sender@'))
          senderMap[element.key.replaceFirst('sender@', '')] = element.value;
        else if (element.key.contains('company@'))
          companyMap[element.key.replaceFirst('company@', '')] = element.value;
      });
      senderMap['company'] = companyMap;
      messageMap['sender'] = senderMap;
      return messageMap;
    }).toList();
  }

  Future<List<ApiEmailMsgModel>> getByTo(String toEmail) async {
    final List<Map<String, Object?>> rows =
        await _select(where: 'to_email = ?', whereArgs: [toEmail]);
    if (rows.isEmpty) return List.empty();
    return rows.map((row) => ApiEmailMsgModel.fromJson(row)).toList();
  }

  Future<void> delete(ApiEmailMsgModel message) async {
    await _database.delete(_table,
        where: 'message_id = ?', whereArgs: [message.messageId]);
  }

  Future<List<ApiEmailMsgModel>> getByNullSender() async {
    final List<Map<String, Object?>> rows =
        await _select(where: 'sender is NULL');
    if (rows.isEmpty) return List.empty();
    return rows.map((row) => ApiEmailMsgModel.fromJson(row)).toList();
  }
}
