/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

class DataFetchModelMsg {
  int? data_fetch_message_id;
  String? extMessageId;
  String? account;

  DataFetchModelMsg(
      {this.data_fetch_message_id,
      this.extMessageId,
      this.account
      });

  DataFetchModelMsg.fromMap(Map<String, dynamic> map) {
    this.data_fetch_message_id = map['message_id'];
    this.extMessageId = map['ext_message_id'];
    this.account = map['account'];
  }

  Map<String, dynamic> toMap() {
    return {
      'message_id': data_fetch_message_id,
      'ext_message_id': extMessageId,
      'account': account,
    };
  }

  @override
  String toString() {
    return 'DataFetchModelMsg{messageId: $data_fetch_message_id, extMessageId: $extMessageId, account: $account}';
  }
}
