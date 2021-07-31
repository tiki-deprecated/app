import 'dart:math';

import 'package:app/src/slices/api_message/model/api_message_fetched_model.dart';
import 'package:app/src/slices/api_message/model/api_message_model.dart';
import 'package:app/src/slices/api_message/repository/api_message_repository.dart';

class ApiMessageService {
  save(ApiMessageFetchedModel fetchedModel) async {
    var message = ApiMessageModel.fromFetchedMessage(fetchedModel);
    var getMessage = await ApiMessageRepository().get(message);
    if (getMessage.length == 0) return ApiMessageRepository().insert(message);
  }

  Future<Map<int, Map<String, dynamic>>> getMessageDataForCards(
      List<int> senderIds) async {
    Map<int, Map<String, dynamic>> messagesData = {};
    for (int i = 0; i < senderIds.length; i++) {
      var sender = senderIds[i];
      List<List<String>> params = [
        ['sender_id', '=', sender.toString()]
      ];
      var messages = await ApiMessageRepository().getByParams(params);
      String frequency = calculateFrequency(messages);
      var openRate = calculateOpenRate(messages);
      messagesData[sender] = {'frequency': frequency, 'openRate': openRate};
    }
    return messagesData;
  }

  String calculateFrequency(List<ApiMessageModel> messages) {
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

  calculateOpenRate(List<ApiMessageModel> messages) {
    int opened = 0;
    int total = messages.length;
    messages.forEach((message) {
      if (message.openedDate != null) opened++;
    });
    return opened / total;
  }
}
