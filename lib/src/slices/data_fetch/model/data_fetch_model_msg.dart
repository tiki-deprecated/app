/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

class DataFetchModelMsg {
  int? messageId;
  String? extMessageId;
  String? account;

  DataFetchModelMsg(
      {this.messageId,
      this.extMessageId,
      this.account
      });

  DataFetchModelMsg.fromMap(Map<String, dynamic> map) {
    this.messageId = map['message_id'];
    this.extMessageId = map['ext_message_id'];
    this.account = map['account'];
  }

  Map<String, dynamic> toMap() {
    return {
      'message_id': messageId,
      'ext_message_id': extMessageId,
      'account': account,
    };
  }

  @override
  String toString() {
    return 'DataFetchModelMsg{messageId: $messageId, extMessageId: $extMessageId, account: $account}';
  }
}
