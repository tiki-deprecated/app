/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:sqflite_sqlcipher/sqlite_api.dart';

import '../api_oauth/model/api_oauth_model_account.dart';
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
    message.created = dbModel?.created;
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

  Future<List<ApiEmailMsgModel>> getByAccount(
      ApiOAuthModelAccount account) async {
    return await _repository.getByAccount(account.email!);
  }

  Future<void> deleteList(List<ApiEmailMsgModel> messages) async {
    for (int i = 0; i < messages.length; i++) {
      ApiEmailMsgModel message = messages[i];
      await _repository.delete(message);
    }
  }

  // TODO saveList
  Future<void> saveList(List<ApiEmailMsgModel> messages) async {
    throw UnimplementedError();
  }

  // TODO delete
  Future<void> delete(ApiEmailMsgModel message) async {
    throw UnimplementedError();
  }

  // TODO getUnfetchedMessages
  Future<List<ApiEmailMsgModel>> getUnfetchedMessages() async {
    throw UnimplementedError();
  }
}
