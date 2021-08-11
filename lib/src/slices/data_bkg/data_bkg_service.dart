/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/slices/api_email_sender/model/api_email_sender_model.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../api_app_data/api_app_data_key.dart';
import '../api_app_data/api_app_data_service.dart';
import '../api_app_data/model/api_app_data_model.dart';
import '../api_company/api_company_service.dart';
import '../api_company/model/api_company_model_local.dart';
import '../api_email_msg/api_email_msg_service.dart';
import '../api_email_msg/model/api_email_msg_model.dart';
import '../api_email_sender/api_email_sender_service.dart';
import '../api_google/api_google_service.dart';
import '../data_bkg/model/data_bkg_model_page.dart';
import 'model/data_bkg_model.dart';

class DataBkgService extends ChangeNotifier {
  final DataBkgModel model = DataBkgModel();
  final ApiCompanyService _apiCompanyService;
  final ApiEmailMsgService _apiEmailMsgService;
  final ApiEmailSenderService _apiEmailSenderService;
  final ApiGoogleService _apiGoogleService;
  final ApiAppDataService _apiAppDataService;
  ApiAppDataModel? appDataGmailLastRun;

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
    checkEmail();
  }

  /// Checks email data from GmailApi
  Future<void> checkEmail() async {
    GoogleSignInAccount? googleAccount =
        await _apiGoogleService.getConnectedUser();
    ApiAppDataModel? appDataGmailLastRun =
        await _apiAppDataService.getByKey(ApiAppDataKey.gmailLastFetch);
    DateTime? gmailLastRun = appDataGmailLastRun != null
        ? DateTime.fromMillisecondsSinceEpoch(
            int.parse(appDataGmailLastRun.value))
        : null;
    if (googleAccount != null &&
        (gmailLastRun == null ||
            DateTime.now().subtract(Duration(days: 0)).isAfter(gmailLastRun))) {
      await Future.wait([fetchNewEmailsFromKnownSenders(), fetchNewSenders()]);
      _apiAppDataService.save(ApiAppDataKey.fetchGmailLastRun,
          DateTime.now().millisecondsSinceEpoch.toString());
    }
  }


  /// Fetch new emails from known senders.
  Future<void> fetchNewEmailsFromKnownSenders() async {
    List<ApiEmailSenderModel> senders = await _apiEmailSenderService.getKnown();
    String knownSenders =
        senders.map((sender) => "from: ${sender.email})").join(" AND ");
    num lastRun = appDataGmailLastRun?.value != null
        ? num.parse(appDataGmailLastRun!.value) / 1000
        : 0;
    String sinceQuery = "after: $lastRun";
    List<ApiEmailMsgModel> messages = await fetchEmail(
        maxResults: 10, batch: 10, query: "$knownSenders AND $sinceQuery");
    await _saveAllMessagesData(messages);
    notifyListeners();
  }

  /// Fetch new senders.
  Future<void> fetchNewSenders() async {
    List<ApiEmailSenderModel> senders = await _apiEmailSenderService.getAll();
    String knownSenders =
        senders.map((sender) => "-from: ${sender.email})").join(" AND ");
    List<ApiEmailMsgModel> messages =
        await fetchEmail(batch: 10, maxResults: 10, query: "$knownSenders");
    if (messages.isNotEmpty) {
      ApiEmailSenderModel? sender = messages[0].sender;
      if (sender != null) {
        await fetchAndSaveAllEmailsFromSender(sender);
      }
    }
  }

  /// Fetch emails from Gmail Api and save sender, company and message data.
  Future<List<ApiEmailMsgModel>> fetchEmail(
      {int maxResults: 10, int batch: 10, query: "", pageToken}) async {
    DataBkgModelPage<ApiEmailMsgModel>? page;
    List<ApiEmailMsgModel> emails = List.empty();
    for (int i = 0; i < batch; i++) {
      page = await _apiGoogleService.gmailFetch(
          unsubscribeOnly: true,
          maxResults: maxResults,
          pageToken: page?.next ?? pageToken,
          query: query);
      if (page.data != null) {
        emails.addAll(page.data!);
      }
    }
    return emails;
  }

  /// Save the data of each email in a list.
  Future<void> _saveAllMessagesData(List<ApiEmailMsgModel> messages) async {
    List<Future> saveList = [];
    for (int i = 0; i < messages.length; i++) {
      ApiEmailMsgModel message = messages[i];
      saveList.add(_saveMessageData(message));
    }
    await Future.wait(saveList);
  }

  /// Save sender, company and message data.
  Future<void> _saveMessageData(message,
      {bool forceSenderUpdate = false}) async {
    if (message.sender?.email != null) {
      ApiEmailSenderModel? messageSender =
          await _apiEmailSenderService.getByEmail(message.sender!.email!);
      if (forceSenderUpdate ||
          DateTime.fromMillisecondsSinceEpoch(messageSender!.updatedEpoch!)
              .isBefore(DateTime.now().subtract(Duration(days: 30)))) {
        ApiCompanyModelLocal? company = await _apiCompanyService
            .upsert(domainFromEmail(message.sender!.email!));
        if (company != null) {
          message.sender!.company = company;
          await _apiEmailSenderService.upsert(message.sender!);
        }
      }
      _apiEmailMsgService.upsert(message);
    }
  }

  /// Fetch all emails from sender and save data.
  Future<void> fetchAndSaveAllEmailsFromSender(
      ApiEmailSenderModel sender) async {
    DataBkgModelPage<ApiEmailMsgModel>? page;
    List<ApiEmailMsgModel> messages = List.empty();
    String query = "from : ${sender.email}";
    do {
      page = await _apiGoogleService.gmailFetch(
          unsubscribeOnly: true,
          maxResults: 10,
          pageToken: page?.next,
          query: query);
      if (page.data != null) {
        messages.addAll(page.data!);
      }
    } while (page.next != null);
    await _saveAllMessagesData(messages);
    if (page.data != null) {
      int since = _apiEmailMsgService.getSinceYear(page.data!);
      _apiEmailSenderService.saveSinceYear(sender, since);
    }
    notifyListeners();
  }

  String domainFromEmail(String email) {
    List<String> atSplit = email.split('@');
    List<String> periodSplit = atSplit[atSplit.length - 1].split('.');
    return periodSplit[periodSplit.length - 2] +
        "." +
        periodSplit[periodSplit.length - 1];
  }
}
