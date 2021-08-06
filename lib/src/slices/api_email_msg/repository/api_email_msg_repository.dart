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

  Future<ApiEmailMsgModel> update(ApiEmailMsgModel message) async {
    await _database.update(
      _table,
      message.toMap(),
      where: 'message_id = ?',
      whereArgs: [message.messageId],
    );
    return message;
  }

  Future<ApiEmailMsgModel?> getByExtMessageIdAndSenderId(
      String extMessageId, int senderId) async {
    final List<Map<String, Object?>> rows = await _select(
        where: 'ext_message_id = ? AND sender.sender_id = ?',
        whereArgs: [extMessageId, senderId]);
    if (rows.isEmpty) return null;
    return ApiEmailMsgModel.fromMap(rows[0]);
  }

  Future<List<ApiEmailMsgModel>> getBySenderId(int senderId) async {
    final List<Map<String, Object?>> rows =
        await _select(where: 'sender.sender_id = ?', whereArgs: [senderId]);
    if (rows.isEmpty) return List.empty();
    return rows.map((row) => ApiEmailMsgModel.fromMap(row)).toList();
  }

  Future<List<Map<String, Object?>>> _select(
      {String? where, List<Object?>? whereArgs}) async {
    List<Map<String, Object?>> rows = await _database.rawQuery(
        'SELECT message.message_id AS \'message@message_id\', '
                'message.ext_message_id AS \'message@ext_message_id\', '
                'message.account AS \'message@account\', '
                'message.received_date_epoch AS \'message@received_date_epoch\', '
                'message.opened_date_epoch AS \'message@opened_date_epoch\', '
                'sender.sender_id AS \'sender@sender_id\', '
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
                'FROM message AS message '
                'INNER JOIN sender AS sender '
                'ON sender.sender_id = message.sender_id '
                'INNER JOIN company AS company '
                'ON company.company_id = sender.company_id ' +
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
}
