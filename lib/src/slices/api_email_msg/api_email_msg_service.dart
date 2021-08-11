/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:sqflite_sqlcipher/sqlite_api.dart';

import 'model/api_email_msg_model.dart';
import 'repository/api_email_msg_repository.dart';

class ApiEmailMsgService {
  final ApiEmailMsgRepository _repository;

  ApiEmailMsgService({required Database database})
      : this._repository = ApiEmailMsgRepository(database);

  Future<ApiEmailMsgModel> upsert(ApiEmailMsgModel message) async {
    ApiEmailMsgModel? dbModel = await _repository.getByExtMessageIdAndSenderId(
        message.extMessageId!, message.sender!.senderId!);
    message.messageId = dbModel?.messageId;
    return dbModel == null
        ? _repository.insert(message)
        : _repository.update(message);
  }

  Future<Map<int, List<ApiEmailMsgModel>>> getBySenders(
      List<int> senderIds) async {
    Map<int, List<ApiEmailMsgModel>> rsp = {};
    for (int senderId in senderIds) {
      List<ApiEmailMsgModel> messages =
          await _repository.getBySenderId(senderId);
      rsp[senderId] = messages;
    }
    return rsp;
  }

  double calculateOpenRate(List<ApiEmailMsgModel> messages) {
    int opened = 0;
    int total = messages.length;
    messages.forEach((message) {
      if (message.openedDate != null) opened++;
    });
    return opened / total;
  }

  int getSinceYear(List<ApiEmailMsgModel> messages) {
    DateTime since = DateTime.now();
    messages.forEach((message) {
      if (message.receivedDate!.isBefore(since)) since = message.receivedDate!;
    });
    return since.year;
  }
}
