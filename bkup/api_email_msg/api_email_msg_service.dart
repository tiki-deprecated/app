/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'dart:math';

import 'package:sqflite_sqlcipher/sqlite_api.dart';

import 'model/api_email_msg_model.dart';
import 'repository/api_email_msg_repository.dart';

class ApiEmailMsgService {
  final ApiEmailMsgRepository _repository;

  ApiEmailMsgService({required Database database})
      : this._repository = ApiEmailMsgRepository(database);

  save(ApiEmailMsgModel model) async {
    var getMessage = await _repository.get(model);
    if (getMessage.length == 0) return _repository.insert(model);
  }

  Future<Map<int, Map<String, dynamic>>> getMessageDataForCards(
      List<int> senderIds) async {
    Map<int, Map<String, dynamic>> messagesData = {};
    for (int i = 0; i < senderIds.length; i++) {
      var sender = senderIds[i];
      List<List<String>> params = [
        ['sender_id', '=', sender.toString()]
      ];
      var messages = await _repository.getByParams(params);
      String frequency = _calculateFrequency(messages);
      var openRate = _calculateOpenRate(messages);
      messagesData[sender] = {'frequency': frequency, 'openRate': openRate};
    }
    return messagesData;
  }

  String _calculateFrequency(List<ApiEmailMsgModel> messages) {
    const secsInDay = 86400;
    const secsInWeek = 86400 * 7;
    const secsInMonth = 86400 * 30;
    int daily = 0;
    int weekly = 0;
    int monthly = 0;
    if (messages.length == 1) return "monthly";
    for (int i = 1; i < messages.length; i++) {
      var message = messages[i];
      var previous = messages[i - 1];
      int diff = message.receivedDate! - previous.receivedDate!;
      if (diff < secsInDay) {
        daily++;
      } else if (diff < secsInWeek) {
        monthly++;
      } else if (diff > secsInMonth) {
        weekly++;
      }
    }
    int maxFrequency = [daily, weekly, monthly].reduce(max);
    if (maxFrequency == daily) {
      return "daily";
    } else if (maxFrequency == weekly) {
      return "weekly";
    } else {
      return "monthly";
    }
  }

  _calculateOpenRate(List<ApiEmailMsgModel> messages) {
    int opened = 0;
    int total = messages.length;
    messages.forEach((message) {
      if (message.openedDate != null) opened++;
    });
    return opened / total;
  }
}
