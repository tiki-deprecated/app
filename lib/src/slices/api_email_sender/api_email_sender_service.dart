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
      : this._repository = ApiEmailSenderRepository(database);

  Future<ApiEmailSenderModel> upsert(ApiEmailSenderModel sender) async {
    ApiEmailSenderModel? dbSender = await _repository.getByEmail(sender.email!);
    if (dbSender != null) {
      sender.senderId = dbSender.senderId;
      if (sender.emailSince != null) {
        sender.emailSince = dbSender.emailSince!.isBefore(sender.emailSince!)
            ? dbSender.emailSince
            : sender.emailSince;
      }
      return _repository.update(sender);
    }
    return _repository.insert(sender);
  }

  Future<List<ApiEmailSenderModel>> getUnsubscribed() async => await _repository
      .getByUnsubscribedAndIgnoreUntilBefore(false, DateTime.now());

  Future<ApiEmailSenderModel?> getById(int senderId) =>
      _repository.getById(senderId);

  Future<void> markAsUnsubscribed(ApiEmailSenderModel sender) async {
    sender.unsubscribed = true;
    sender.ignoreUntil = DateTime.now().add(Duration(days: 60));
    _repository.update(sender);
  }

  Future<void> markAsKept(ApiEmailSenderModel sender) async {
    sender.unsubscribed = false;
    sender.ignoreUntil = DateTime.now().add(Duration(days: 60));
    _repository.update(sender);
  }

  getByEmail(String email) {
    // TODO
  }

  getPending() {
    //TODO
  }

  getKnown() {
    //todo
  }

  getAll() {
    //TODO
  }
}
