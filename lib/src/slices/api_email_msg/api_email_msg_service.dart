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

  Future<ApiEmailMsgModel> upsert(ApiEmailMsgModel message) async {
    ApiEmailMsgModel? dbModel = await _repository.getByExtMessageIdAndSenderId(
        message.extMessageId!, message.sender!.senderId!);
    if (dbModel != null) {
      message.messageId = dbModel.messageId;
      return _repository.update(message);
    } else
      return _repository.insert(message);
  }

  Future<Map<int, Map<String, dynamic>>> getMessageDataForCards(
      List<int> senderIds) async {
    Map<int, Map<String, dynamic>> messagesData = {};
    for (int senderId in senderIds) {
      List<ApiEmailMsgModel> messages =
          await _repository.getBySenderId(senderId);
      messagesData[senderId] = {
        'frequency': _calculateFrequency(messages),
        'openRate': _calculateOpenRate(messages)
      };
    }
    return messagesData;
  }

  String _calculateFrequency(List<ApiEmailMsgModel> messages) {
    const secsInDay = 86400;
    const secsInWeek = 86400 * 7;
    int daily = 0;
    int weekly = 0;
    int monthly = 0;
    if (messages.length == 1) return "monthly";
    for (int i = messages.length - 2; i >= 0; i--) {
      var message = messages[i];
      var previous = messages[i + 1];
      num diff = (message.receivedDate!.millisecondsSinceEpoch -
              previous.receivedDate!.millisecondsSinceEpoch) /
          1000;
      if (diff <= secsInDay) {
        daily++;
      } else if (diff <= secsInWeek) {
        weekly++;
      } else if (diff > secsInWeek) {
        monthly++;
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
