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
    ApiEmailMsgModel? dbModel = await _repository.getByExtMessageIdAndAccount(
        message.extMessageId!, message.account!);
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

  Future<List<ApiEmailMsgModel>> getByExtMessageIds(
          List<String> extMessageIds) async =>
      _repository.getByExtMessageIds(extMessageIds);

  Future<bool> deleteAll() async {
    await _repository.deleteAll();
    return true;
  }
}
