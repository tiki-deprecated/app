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
  String?
      account; //TODO move this to account id as a FK & should have a "to" email field
  DateTime? created;
  DateTime? modified;

  ApiEmailMsgModel(
      {this.messageId,
      this.extMessageId,
      this.sender,
      this.receivedDate,
      this.openedDate,
      this.account,
      this.modified,
      this.created});

  ApiEmailMsgModel.fromJson(Map<String, dynamic>? json) {
    if (json != null) {
      this.messageId = json['message_id'];
      this.extMessageId = json['ext_message_id'];
      this.sender = ApiEmailSenderModel.fromJson(json['sender']);
      this.account = json['account'];
      if (json['received_date_epoch'] != null)
        this.receivedDate =
            DateTime.fromMillisecondsSinceEpoch(json['received_date_epoch']);
      if (json['opened_date_epoch'] != null)
        this.openedDate =
            DateTime.fromMillisecondsSinceEpoch(json['opened_date_epoch']);
      if (json['modified_epoch'] != null)
        this.modified =
            DateTime.fromMillisecondsSinceEpoch(json['modified_epoch']);
      if (json['created_epoch'] != null)
        this.created =
            DateTime.fromMillisecondsSinceEpoch(json['created_epoch']);
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'message_id': messageId,
      'ext_message_id': extMessageId,
      'sender_id': sender?.senderId,
      'received_date_epoch': receivedDate?.millisecondsSinceEpoch,
      'opened_date_epoch': openedDate?.millisecondsSinceEpoch,
      'account': account,
      'modified_epoch': modified?.millisecondsSinceEpoch,
      'created_epoch': created?.millisecondsSinceEpoch
    };
  }

  @override
  String toString() {
    return 'ApiEmailMsgModel{messageId: $messageId, extMessageId: $extMessageId, sender: $sender, receivedDate: $receivedDate, openedDate: $openedDate, account: $account}';
  }
}
