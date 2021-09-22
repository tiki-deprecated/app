/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:logging/logging.dart';

import '../api_app_data/api_app_data_service.dart';
import '../api_company/api_company_service.dart';
import '../api_email_msg/api_email_msg_service.dart';
import '../api_email_msg/model/api_email_msg_model.dart';
import '../api_email_sender/api_email_sender_service.dart';
import '../api_email_sender/model/api_email_sender_model.dart';
import '../api_oauth/api_oauth_service.dart';
import '../api_oauth/model/api_oauth_model_account.dart';
import '../data_bkg/data_bkg_service.dart';
import '../decision_card_spam/ui/decision_card_spam_layout.dart';
import 'decision_card_spam_controller.dart';
import 'model/decision_card_spam_model.dart';

class DecisionCardSpamService extends ChangeNotifier {
  final _log = Logger('DecisionCardSpamService');
  late final DecisionCardSpamController controller;
  final ApiEmailSenderService _apiEmailSenderService;
  final ApiEmailMsgService _apiEmailMsgService;
  final ApiCompanyService _apiCompanyService;
  final ApiOAuthService _apiAuthService;

  final DataBkgService _dataBkgService;

  DecisionCardSpamService(
      {required ApiEmailSenderService apiEmailSenderService,
      required ApiEmailMsgService apiEmailMsgService,
      required ApiAppDataService apiAppDataService,
      required ApiCompanyService apiCompanyService,
      required ApiOAuthService apiAuthService,
      required DataBkgService dataBkgService})
      : this._apiEmailMsgService = apiEmailMsgService,
        this._apiEmailSenderService = apiEmailSenderService,
        this._apiCompanyService = apiCompanyService,
        this._apiAuthService = apiAuthService,
        this._dataBkgService = dataBkgService {
    controller = DecisionCardSpamController(this);
  }

  Future<List<DecisionCardSpamLayout>?> getCards() async {
    List<ApiEmailSenderModel> senders =
        await _apiEmailSenderService.getUnsubscribed();

    List<int> senderIds = List.empty(growable: true);
    for (ApiEmailSenderModel sender in senders) {
      if (sender.senderId != null) senderIds.add(sender.senderId!);
      if (sender.company?.domain != null &&
          sender.company?.securityScore == null) {
        _apiCompanyService
            .upsert(sender.company!.domain!)
            .then((value) => notifyListeners());
      }
    }

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
          openRate: _calculateOpenRate(msgs),
          securityScore: msgs[0].sender?.company?.securityScore,
          sensitivityScore: msgs[0].sender?.company?.sensitivityScore,
          hackingScore: msgs[0].sender?.company?.breachScore,
          senderId: senderId,
          senderEmail: msgs[0].sender?.email,
          totalEmails: msgs.length,
          sinceYear: msgs[0].sender?.emailSince?.year.toString(),
        ));
      }
    }
    return spamModels
        .map((spamModel) => DecisionCardSpamLayout(this, spamModel))
        .toList();
  }

  Future<void> unsubscribeFromSpam(BuildContext context, int senderId) async {
    ApiEmailSenderModel? sender =
        await _apiEmailSenderService.getById(senderId);
    if (sender != null) {
      ApiOAuthModelAccount account =
          (await _apiAuthService.getAccountById(sender.accountId!))!;
      String? mailTo = sender.unsubscribeMailTo;
      if (mailTo != null) {
        String list = sender.name ?? sender.email!;
        await _apiEmailSenderService.markAsUnsubscribed(sender);
        bool unsubscribed = false;
        try {
          unsubscribed =
              await _dataBkgService.email.unsubscribe(account, mailTo, list);
          _log.finest(
              mailTo + ' unsubscribed status: ' + unsubscribed.toString());
        } catch (e) {
          _log.warning('Failed to unsubscribe from: ' + mailTo, e);
        }
      }
    }
  }

  Future<void> keepReceiving(BuildContext context, int senderId) async {
    ApiEmailSenderModel? sender =
        await _apiEmailSenderService.getById(senderId);
    if (sender != null) {
      await _apiEmailSenderService.markAsKept(sender);
    }
  }

  String _calculateFrequency(List<ApiEmailMsgModel> messages) {
    const int secsInDay = 86400;
    const int secsInWeek = 604800;
    const int secsInMonth = 2629746;

    if (messages.length == 1) return "once";

    messages.sort((a, b) => a.receivedDate!.isBefore(b.receivedDate!) ? -1 : 1);
    List<Duration> freq = [];
    for (int i = 0; i < messages.length - 1; i++) {
      freq.add(
          messages[i].receivedDate!.difference(messages[i + 1].receivedDate!));
    }
    double avgSeconds = 0;
    freq.map((f) => f.inSeconds).forEach((f) => avgSeconds += f);
    avgSeconds = (avgSeconds / freq.length).abs();

    if (avgSeconds <= secsInDay)
      return "daily";
    else if (avgSeconds <= secsInWeek)
      return "weekly";
    else if (avgSeconds <= secsInMonth)
      return "monthly";
    else if (avgSeconds <= secsInMonth * 3)
      return "quarterly";
    else if (avgSeconds <= secsInMonth * 6)
      return "semiannually";
    else
      return "annually";
  }

  double _calculateOpenRate(List<ApiEmailMsgModel> messages) {
    int opened = 0;
    int total = messages.length;
    messages.forEach((message) {
      if (message.openedDate != null) opened++;
    });
    return opened / total;
  }
}
