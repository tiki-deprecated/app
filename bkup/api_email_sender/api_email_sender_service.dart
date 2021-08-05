/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:sqflite_sqlcipher/sqlite_api.dart';

import '../../lib/src/slices/api_email_sender/model/api_email_sender_model.dart';
import 'repository/api_email_sender_repository.dart';

class ApiEmailSenderService {
  final ApiEmailSenderRepository _repository;

  ApiEmailSenderService({required Database database})
      : this._repository = ApiEmailSenderRepository(database);

  Future<ApiEmailSenderModel> createOrUpdate(
      ApiMessageFetchedModel fetchedModel) async {
    var senderData = fetchedModel.senderData;
    var sender = ApiEmailSenderModel.fromMap(senderData);
    var getSender = await _repository.getByEmail(sender.email);
    if (getSender != null) {
      sender.senderId = getSender.senderId;
      if (sender.emailSince != null) {
        sender.emailSince = getSender.emailSince! < sender.emailSince!
            ? getSender.emailSince
            : sender.emailSince;
      }
      _repository.update(sender);
    }
    return _repository.insert(sender);
  }

  Future<List<ApiEmailSenderModel>> getSendersForCards() async {
    List<List<String>> params = [
      ['unsubscribed', "=", 0.toString()],
      ['ignore_until', "<", (DateTime.now().millisecondsSinceEpoch).toString()]
    ];
    return await _repository.getByParams(params);
  }

  Future<ApiEmailSenderModel?> getById(int? senderId) async {
    if (senderId == null) return null;
    var sender = await _repository.getById(senderId);
    return sender;
  }

  Future<void> markAsUnsubscribed(ApiEmailSenderModel sender) async {
    sender.unsubscribed = 1;
    sender.ignoreUntil =
        (DateTime.now().add(Duration(days: 60)).millisecondsSinceEpoch).round();
    _repository.update(sender);
  }

  Future<void> markAsKeeped(ApiEmailSenderModel sender) async {
    sender.unsubscribed = 0;
    sender.ignoreUntil =
        (DateTime.now().add(Duration(days: 60)).millisecondsSinceEpoch).round();
    _repository.update(sender);
  }
}
