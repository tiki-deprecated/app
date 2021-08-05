/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

class ApiEmailMsgModel {
  int? messageId;
  String? extMessageId;
  int? senderId;
  int? receivedDate;
  int? openedDate;
  String? account;

  ApiEmailMsgModel({
    this.messageId,
    this.extMessageId,
    this.senderId,
    this.receivedDate,
    this.openedDate,
    this.account,
  });

  ApiEmailMsgModel.fromMap(Map<String, dynamic> map)
      : messageId = map['message_id'],
        extMessageId = map['ext_message_id'],
        senderId = map['sender_id'],
        receivedDate = map['received_date'],
        openedDate = map['opened_date'],
        account = map['account'];

  Map<String, dynamic> toMap() {
    return {
      'message_id': messageId,
      'ext_message_id': extMessageId,
      'sender_id': senderId,
      'received_date': receivedDate,
      'opened_date': openedDate,
      'account': account,
    };
  }

  @override
  String toString() {
    return 'ApiEmailMsgModel{messageId: $messageId, extMessageId: $extMessageId, senderId: $senderId, receivedDate: $receivedDate, openedDate: $openedDate, account: $account}';
  }
}
