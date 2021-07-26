import 'dart:math';

import 'package:app/src/slices/api_message/model/api_message_fetched_model.dart';
import 'package:app/src/slices/api_message/model/api_message_model.dart';
import 'package:app/src/slices/api_message/repository/api_message_repository.dart';
import 'package:app/src/slices/decision_card_spam/model/decision_card_spam_model.dart';

class ApiMessageService {
  save(ApiMessageFetchedModel fetchedModel) async {
    var message = ApiMessageModel.fromFetchedMessage(fetchedModel);
    var getMessage = await ApiMessageRepository().get(message);
    if (getMessage.length == 0) return ApiMessageRepository().insert(message);
  }

  getMessageDataForCards(List<int> senderIds) async {
    Map<int, Map<String, dynamic>> messsagesData = {};
    senderIds.forEach((sender) async {
      List<List<String>> params = [
        ['sender_id', '=', sender.toString()]
      ];
      var messages = await ApiMessageRepository().getByParams(params);
      DecisionCardSpamFrequency frequency = calculateFrequency(messages);
      var openRate = calculateOpenRate(messages);
      messsagesData[sender] = {'frequency': frequency, 'openRate': openRate};
    });
  }

  DecisionCardSpamFrequency calculateFrequency(List<ApiMessageModel> messages) {
    const secsInDay = 86400;
    const secsInWeek = 86400 * 7;
    const secsInMonth = 86400 * 30;
    int daily = 0;
    int weekly = 0;
    int monthly = 0;
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
      return DecisionCardSpamFrequency.daily;
    } else if (maxFrequency == weekly) {
      return DecisionCardSpamFrequency.weekly;
    } else {
      return DecisionCardSpamFrequency.monthly;
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
//
// this.logoUrl,
// required this.companyName,

// ,
// this.securityScore,
// this.sensitivityScore,
// this.hackingScore,
// required this.senderId,
