/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/slices/api_email_sender/model/api_email_sender_model.dart';

class ApiEmailMsgModel {
  int? messageId;
  String? extMessageId;
  ApiEmailSenderModel? sender;
  DateTime? receivedDate;
  DateTime? openedDate;
  String? account;

  ApiEmailMsgModel({
    this.messageId,
    this.extMessageId,
    this.sender,
    this.receivedDate,
    this.openedDate,
    this.account,
  });

  ApiEmailMsgModel.fromMap(Map<String, dynamic> map) {
    this.messageId = map['message_id'];
    this.extMessageId = map['ext_message_id'];
    this.sender = ApiEmailSenderModel.fromMap(map['sender']);
    this.account = map['account'];
    if (map['received_date_epoch'] != null)
      this.receivedDate =
          DateTime.fromMillisecondsSinceEpoch(map['received_date_epoch']);
    if (map['opened_date_epoch'] != null)
      this.openedDate =
          DateTime.fromMillisecondsSinceEpoch(map['opened_date_epoch']);
  }

  Map<String, dynamic> toMap() {
    return {
      'message_id': messageId,
      'ext_message_id': extMessageId,
      'sender_id': sender?.senderId,
      'received_date_epoch': receivedDate?.millisecondsSinceEpoch,
      'opened_date_epoch': openedDate?.millisecondsSinceEpoch,
      'account': account,
    };
  }

  @override
  String toString() {
    return 'ApiEmailMsgModel{messageId: $messageId, extMessageId: $extMessageId, sender: $sender, receivedDate: $receivedDate, openedDate: $openedDate, account: $account}';
  }
}
