/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:flutter/widgets.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../api_app_data/api_app_data_key.dart';
import '../api_app_data/api_app_data_service.dart';
import '../api_app_data/model/api_app_data_model.dart';
import '../api_company/api_company_service.dart';
import '../api_company/model/api_company_model_local.dart';
import '../api_email_msg/api_email_msg_service.dart';
import '../api_email_msg/model/api_email_msg_model.dart';
import '../api_email_sender/api_email_sender_service.dart';
import '../api_email_sender/model/api_email_sender_model.dart';
import '../api_google/api_google_service.dart';
import 'model/data_bkg_model.dart';

class DataBkgService extends ChangeNotifier {
  final DataBkgModel model = DataBkgModel();
  final ApiCompanyService _apiCompanyService;
  final ApiEmailMsgService _apiEmailMsgService;
  final ApiEmailSenderService _apiEmailSenderService;
  final ApiGoogleService _apiGoogleService;
  final ApiAppDataService _apiAppDataService;

  DataBkgService(
      {required ApiGoogleService apiGoogleService,
      required ApiCompanyService apiCompanyService,
      required ApiEmailMsgService apiEmailMsgService,
      required ApiEmailSenderService apiEmailSenderService,
      required ApiAppDataService apiAppDataService})
      : this._apiGoogleService = apiGoogleService,
        this._apiCompanyService = apiCompanyService,
        this._apiEmailMsgService = apiEmailMsgService,
        this._apiEmailSenderService = apiEmailSenderService,
        this._apiAppDataService = apiAppDataService {
    checkGmail();
  }

  Future<void> checkGmail({bool fetchAll = false, bool force = false}) async {
    GoogleSignInAccount? googleAccount =
        await _apiGoogleService.getConnectedUser();
    ApiAppDataModel? appDataGmailLastRun =
        await _apiAppDataService.getByKey(ApiAppDataKey.gmailLastFetch);
    DateTime? gmailLastRun;
    if (appDataGmailLastRun != null)
      gmailLastRun = DateTime.fromMillisecondsSinceEpoch(
          int.parse(appDataGmailLastRun.value));
    else {
      fetchAll = true;
      force = true;
    }
    if (googleAccount != null &&
        (force == true ||
            gmailLastRun == null ||
            DateTime.now()
                .subtract(Duration(days: 0 /*1*/))
                .isAfter(gmailLastRun))) {
      DateTime run = DateTime.now();
      await _checkGmailFetchList(fetchAll: fetchAll, lastChecked: gmailLastRun);
      await _apiAppDataService.save(
          ApiAppDataKey.gmailLastFetch, run.millisecondsSinceEpoch.toString());
    }
  }

  Future<void> _checkGmailFetchList(
      {bool fetchAll = false, DateTime? lastChecked}) async {
    Set<String> messages;
    if (fetchAll)
      messages = await _apiGoogleService.gmailFetch();
    else {
      int? secondsSinceEpoch = lastChecked != null
          ? (lastChecked.millisecondsSinceEpoch / 1000).floor()
          : null;
      messages = await _apiGoogleService.gmailFetch(
          query: secondsSinceEpoch != null
              ? "after:" + secondsSinceEpoch.toString()
              : null);
    }
    List<String> known =
        (await _apiEmailMsgService.getByExtMessageIds(messages.toList()))
            .map((message) => message.extMessageId!)
            .toList();
    Set<String> unknown =
        messages.where((message) => !known.contains(message)).toSet();
    return _checkGmailFetchMessage(unknown);
  }

  Future<void> _checkGmailFetchMessage(Set<String> messages) async {
    Set<String> processed = Set();
    for (String messageId in messages) {
      ApiEmailMsgModel? message = await _apiGoogleService.gmailFetchMessage(
          messageId,
          format: "metadata",
          headers: ["List-unsubscribe"]);
      if (message?.extMessageId != null) processed.add(message!.extMessageId!);
      if (message?.sender?.email != null &&
          message?.sender?.unsubscribeMailTo != null) {
        ApiEmailSenderModel? sender =
            await _apiEmailSenderService.getByEmail(message!.sender!.email!);
        if (sender != null) {
          await _saveSender(sender);
          await _apiEmailMsgService.upsert(message);
          notifyListeners();
        } else {
          Set<ApiEmailMsgModel> senderMessages =
              await _checkGmailNewSender(message.sender!.email!);
          Set<String> senderMessageIds =
              senderMessages.map((message) => message.extMessageId!).toSet();
          Set<String> newMessages = messages
              .where((message) =>
                  !senderMessageIds.contains(message) &&
                  !processed.contains(message))
              .toSet();
          return _checkGmailFetchMessage(newMessages);
        }
      }
    }
  }

  Future<Set<ApiEmailMsgModel>> _checkGmailNewSender(String email) async {
    Set<String> messageIds =
        await _apiGoogleService.gmailFetch(query: 'from:' + email);
    Set<ApiEmailMsgModel> messages = Set();
    for (String messageId in messageIds) {
      ApiEmailMsgModel? message = await _apiGoogleService.gmailFetchMessage(
          messageId,
          format: "metadata",
          headers: ["List-unsubscribe"]);
      if (message?.sender?.email != null &&
          message?.sender?.unsubscribeMailTo != null) messages.add(message!);
    }
    DateTime first = DateTime.now();
    messages.forEach((message) {
      if (message.receivedDate != null && message.receivedDate!.isBefore(first))
        first = message.receivedDate!;
    });
    ApiEmailSenderModel sender = messages.first.sender!;
    sender.emailSince = first;
    ApiEmailSenderModel? inserted = await _saveSender(sender);
    if (inserted != null) {
      for (ApiEmailMsgModel message in messages) {
        message.sender = inserted;
        await _apiEmailMsgService.upsert(message);
      }
      notifyListeners();
    }
    return messages;
  }

  Future<ApiEmailSenderModel?> _saveSender(ApiEmailSenderModel sender) async {
    if (sender.email != null) {
      ApiCompanyModelLocal? company =
          await _apiCompanyService.upsert(domainFromEmail(sender.email!));
      if (company != null) {
        sender.company = company;
        ApiEmailSenderModel saved = await _apiEmailSenderService.upsert(sender);
        return saved;
      }
    }
  }

  String domainFromEmail(String email) {
    List<String> atSplit = email.split('@');
    List<String> periodSplit = atSplit[atSplit.length - 1].split('.');
    return periodSplit[periodSplit.length - 2] +
        "." +
        periodSplit[periodSplit.length - 1];
  }
}
