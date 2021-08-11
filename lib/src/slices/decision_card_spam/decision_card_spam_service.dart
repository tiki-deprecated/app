/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

//import 'package:app/src/slices/api_unsubscribe_spam/api_unsubscribe_spam_service.dart';
import 'dart:math';

import 'package:app/src/slices/api_google/api_google_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../api_app_data/api_app_data_key.dart';
import '../api_app_data/api_app_data_service.dart';
import '../api_email_msg/api_email_msg_service.dart';
import '../api_email_msg/model/api_email_msg_model.dart';
import '../api_email_sender/api_email_sender_service.dart';
import '../api_email_sender/model/api_email_sender_model.dart';
import '../decision_card_spam/ui/decision_card_spam_layout.dart';
import 'decision_card_spam_controller.dart';
import 'model/decision_card_spam_model.dart';

class DecisionCardSpamService extends ChangeNotifier {
  late final DecisionCardSpamController controller;
  final ApiEmailSenderService _apiEmailSenderService;
  final ApiEmailMsgService _apiEmailMsgService;
  final ApiAppDataService _apiAppDataService;
  final ApiGoogleService _apiGoogleService;

  DecisionCardSpamService(
      {required ApiEmailSenderService apiEmailSenderService,
      required ApiEmailMsgService apiEmailMsgService,
      required ApiAppDataService apiAppDataService,
      required ApiGoogleService apiGoogleService})
      : this._apiAppDataService = apiAppDataService,
        this._apiEmailMsgService = apiEmailMsgService,
        this._apiEmailSenderService = apiEmailSenderService,
        this._apiGoogleService = apiGoogleService {
    controller = DecisionCardSpamController(this);
  }

  Future<List<DecisionCardSpamLayout>?> getCards() async {
    List<ApiEmailSenderModel> senders =
        await _apiEmailSenderService.getUnsubscribed();
    List<int> senderIds = senders
        .skipWhile((sender) => sender.senderId == null)
        .map((sender) => sender.senderId!)
        .toList();
    Map<int, List<ApiEmailMsgModel>> messages =
        await _apiEmailMsgService.getBySenders(senderIds);
    List<DecisionCardSpamModel> spamModels = [];
    for (int senderId in senderIds) {
      List<ApiEmailMsgModel>? msgs = messages[senderId];
      if (msgs != null && msgs.isNotEmpty) {
        spamModels.add(DecisionCardSpamModel(
          logoUrl: msgs[0].sender?.company?.logo,
          category: msgs[0].sender?.category,
          companyName: msgs[0].sender?.name,
          frequency: _calculateFrequency(msgs),
          openRate: _apiEmailMsgService.calculateOpenRate(msgs),
          securityScore: msgs[0].sender?.company?.securityScore,
          sensitivityScore: msgs[0].sender?.company?.sensitivityScore,
          hackingScore: msgs[0].sender?.company?.breachScore,
          senderId: senderId,
          senderEmail: msgs[0].sender?.email,
          totalEmails: msgs.length,
          sinceYear: _apiEmailMsgService.getSinceYear(msgs).toString(),
        ));
      }
    }
    _apiAppDataService.save(ApiAppDataKey.spamCardsLastRun,
        DateTime.now().millisecondsSinceEpoch.toString());
    return spamModels
        .map((spamModel) => DecisionCardSpamLayout(this, spamModel))
        .toList();
  }

  unsubscribeFromSpam(BuildContext context, int senderId) async {
    ApiEmailSenderModel? sender =
        await _apiEmailSenderService.getById(senderId);
    if (sender != null) {
      String? mailTo = sender.unsubscribeMailTo;
      if (mailTo != null) {
        bool unsubscribed = await _apiGoogleService.unsubscribe(mailTo);
        if (unsubscribed) _apiEmailSenderService.markAsUnsubscribed(sender);
      }
    }
  }

  keepReceiving(BuildContext context, int senderId) async {
    ApiEmailSenderModel? sender =
        await _apiEmailSenderService.getById(senderId);
    if (sender != null) {
      _apiEmailSenderService.markAsKept(sender);
    }
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
}
