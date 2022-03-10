/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:sqflite_sqlcipher/sqlite_api.dart';

import 'model/api_email_sender_model.dart';
import 'repository/api_email_sender_repository.dart';

class ApiEmailSenderService {
  final ApiEmailSenderRepository _repository;

  ApiEmailSenderService({required Database database})
      : _repository = ApiEmailSenderRepository(database);

  Future<ApiEmailSenderModel> upsert(ApiEmailSenderModel sender) async =>
      await _repository.upsert(sender);

  Future<int> batchUpsert(List<ApiEmailSenderModel> senders) async =>
      await _repository.batchUpsert(senders);

  Future<List<ApiEmailSenderModel>> getUnsubscribed() async => await _repository
      .getByUnsubscribedAndIgnoreUntilBefore(false, DateTime.now());

  Future<ApiEmailSenderModel?> getById(int senderId) =>
      _repository.getById(senderId);

  Future<ApiEmailSenderModel?> getByEmail(String email) =>
      _repository.getByEmail(email);

  Future<void> markAsUnsubscribed(ApiEmailSenderModel sender) async {
    sender.unsubscribed = true;
    sender.ignoreUntil = DateTime.now().add(const Duration(days: 60));
    _repository.update(sender);
  }

  Future<void> markAsKept(ApiEmailSenderModel sender) async {
    sender.unsubscribed = false;
    sender.ignoreUntil = DateTime.now().add(const Duration(days: 60));
    _repository.update(sender);
  }

  Future<void> deleteList(List<ApiEmailSenderModel> senders) async {
    for (int i = 0; i < senders.length; i++) {
      ApiEmailSenderModel sender = senders[i];
      await _repository.delete(sender);
    }
  }
}
