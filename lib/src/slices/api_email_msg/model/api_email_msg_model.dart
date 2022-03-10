/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import '../../../utils/json/json_object.dart';
import '../../api_email_sender/model/api_email_sender_model.dart';

class ApiEmailMsgModel extends JsonObject {
  int? messageId;
  String? extMessageId;
  ApiEmailSenderModel? sender;
  DateTime? receivedDate;
  DateTime? openedDate;
  String? toEmail;
  DateTime? created;
  DateTime? modified;

  ApiEmailMsgModel(
      {this.messageId,
      this.extMessageId,
      this.sender,
      this.receivedDate,
      this.openedDate,
      this.toEmail,
      this.modified,
      this.created});

  ApiEmailMsgModel.fromJson(Map<String, dynamic>? json) {
    if (json != null) {
      messageId = json['message_id'];
      extMessageId = json['ext_message_id'];
      sender = ApiEmailSenderModel.fromJson(json['sender']);
      toEmail = json['to_email'];
      if (json['received_date_epoch'] != null) {
        receivedDate =
            DateTime.fromMillisecondsSinceEpoch(json['received_date_epoch']);
      }
      if (json['opened_date_epoch'] != null) {
        openedDate =
            DateTime.fromMillisecondsSinceEpoch(json['opened_date_epoch']);
      }
      if (json['modified_epoch'] != null) {
        modified =
            DateTime.fromMillisecondsSinceEpoch(json['modified_epoch']);
      }
      if (json['created_epoch'] != null) {
        created =
            DateTime.fromMillisecondsSinceEpoch(json['created_epoch']);
      }
    }
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'message_id': messageId,
      'ext_message_id': extMessageId,
      'sender_email': sender?.email,
      'received_date_epoch': receivedDate?.millisecondsSinceEpoch,
      'opened_date_epoch': openedDate?.millisecondsSinceEpoch,
      'to_email': toEmail,
      'modified_epoch': modified?.millisecondsSinceEpoch,
      'created_epoch': created?.millisecondsSinceEpoch
    };
  }

  @override
  String toString() {
    return 'ApiEmailMsgModel{messageId: $messageId, extMessageId: $extMessageId, sender: $sender, receivedDate: $receivedDate, openedDate: $openedDate, toEmail: $toEmail, created: $created, modified: $modified}';
  }

  ApiEmailMsgModel.fromDynamic(dynamic msg) {
    messageId = msg.messageId;
    extMessageId = msg.extMessageId;
    sender = ApiEmailSenderModel.fromDynamic(msg.sender);
    receivedDate = msg.receivedDate;
    openedDate = msg.openedDate;
    toEmail = msg.toEmail;
    modified = msg.modified;
    created = msg.created;
  }
}
