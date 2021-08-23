/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:flutter/widgets.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:logging/logging.dart';

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
import 'model/data_bkg_model_page.dart';

class DataBkgService extends ChangeNotifier {
  final _log = Logger('DataBkgService');
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
    _log.fine('Gmail fetch starting on: ' + DateTime.now().toIso8601String());
    GoogleSignInAccount? googleAccount =
        await _apiGoogleService.getConnectedUser();
    ApiAppDataModel? appDataGmailLastFetch =
        await _apiAppDataService.getByKey(ApiAppDataKey.gmailLastFetch);
    DateTime? gmailLastFetch;
    if (appDataGmailLastFetch != null)
      gmailLastFetch = DateTime.fromMillisecondsSinceEpoch(
          int.parse(appDataGmailLastFetch.value));
    else {
      fetchAll = true;
      force = true;
    }
    if (googleAccount != null &&
        (force == true ||
            gmailLastFetch == null ||
            DateTime.now()
                .subtract(Duration(days: 1))
                .isAfter(gmailLastFetch))) {
      DateTime run = DateTime.now();
      ApiAppDataModel? savedActiveCategory =
          await _apiAppDataService.getByKey(ApiAppDataKey.gmailCategory);
      String activeCategory = savedActiveCategory?.value ?? '';
      int categoryStartIndex = activeCategory.isEmpty
          ? 0
          : model.gmailCategoryList.indexOf(activeCategory);
      for (int i = categoryStartIndex;
          i < model.gmailCategoryList.length;
          i++) {
        String category = model.gmailCategoryList[i];
        await _apiAppDataService.save(ApiAppDataKey.gmailCategory, category);
        await _checkGmailFetchList(
            fetchAll: fetchAll,
            lastChecked: gmailLastFetch,
            gmailCategory: category);
      }
      await _apiAppDataService.save(
          ApiAppDataKey.gmailCategory, model.gmailCategoryList[0]);
      await _apiAppDataService.save(
          ApiAppDataKey.gmailLastFetch, run.millisecondsSinceEpoch.toString());
      await _apiAppDataService.save(ApiAppDataKey.gmailLastPage, '');
      _log.fine(
          'Gmail fetch completed on: ' + DateTime.now().toIso8601String());
    }
  }

  Future<void> _checkGmailFetchList(
      {bool fetchAll = false,
      DateTime? lastChecked,
      String gmailCategory = ''}) async {
    String? page;
    String query = '';
    if (!fetchAll) {
      int? secondsSinceEpoch = lastChecked != null
          ? (lastChecked.millisecondsSinceEpoch / 1000).floor()
          : null;
      query = secondsSinceEpoch != null
          ? "after:" + secondsSinceEpoch.toString()
          : '';
    }
    if (gmailCategory != 'none') {
      query += gmailCategory.isNotEmpty ? " label: $gmailCategory" : '';
    } else {
      query += "NOT " + model.gmailCategoryList.join("AND NOT");
    }
    ApiAppDataModel? appDataGmailLastPage =
        await _apiAppDataService.getByKey(ApiAppDataKey.gmailLastPage);
    page = appDataGmailLastPage?.value;
    return _checkGmailFetchListPage(query: query, page: page);
  }

  Future<void> _checkGmailFetchListPage({String? page, String? query}) async {
    DataBkgModelPage<String> res = await _apiGoogleService.gmailFetch(
        query: query, page: page, maxResults: 5);
    if (res.data != null) {
      List<String> known =
          (await _apiEmailMsgService.getByExtMessageIds(res.data!))
              .map((message) => message.extMessageId!)
              .toList();
      List<String> unknown =
          res.data!.where((message) => !known.contains(message)).toList();
      await _checkGmailFetchMessage(unknown);
    }
    if (res.next != null) {
      await _apiAppDataService.save(ApiAppDataKey.gmailLastPage, res.next);
      return _checkGmailFetchListPage(page: res.next, query: query);
    }
  }

  Future<void> _checkGmailFetchMessage(List<String> messages) async {
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
          _log.fine('Sender upsert: ' + (sender.company?.domain ?? ''));
          notifyListeners();
        } else {
          Set<ApiEmailMsgModel> senderMessages =
              await _checkGmailNewSender(message.sender!.email!);
          Set<String> senderMessageIds =
              senderMessages.map((message) => message.extMessageId!).toSet();
          List<String> newMessages = messages
              .where((message) =>
                  !senderMessageIds.contains(message) &&
                  !processed.contains(message))
              .toList();
          return _checkGmailFetchMessage(newMessages);
        }
      }
    }
  }

  Future<Set<ApiEmailMsgModel>> _checkGmailNewSender(String email) async {
    List<String> messageIds = await _checkGmailNewSenderPage(
        email: email, messages: List.empty(growable: true));
    Set<ApiEmailMsgModel> messages = Set();
    DateTime first = DateTime.now();
    for (String messageId in messageIds) {
      ApiEmailMsgModel? message = await _apiGoogleService.gmailFetchMessage(
          messageId,
          format: "metadata",
          headers: ["List-unsubscribe"]);
      if (message?.sender?.email != null &&
          message?.sender?.unsubscribeMailTo != null) {
        messages.add(message!);
        if (message.receivedDate != null &&
            message.receivedDate!.isBefore(first))
          first = message.receivedDate!;
      }
    }
    ApiEmailSenderModel sender = messages.first.sender!;
    sender.emailSince = first;
    ApiEmailSenderModel? inserted = await _saveSender(sender);
    if (inserted != null) {
      for (ApiEmailMsgModel message in messages) {
        message.sender = inserted;
        await _apiEmailMsgService.upsert(message);
      }
      _log.fine('Sender upsert: ' + (sender.company?.domain ?? ''));
      notifyListeners();
    }
    return messages;
  }

  Future<List<String>> _checkGmailNewSenderPage(
      {required String email,
      String? page,
      required List<String> messages}) async {
    DataBkgModelPage<String> res =
        await _apiGoogleService.gmailFetch(query: 'from:' + email, page: page);
    if (res.data != null) messages.addAll(res.data!);
    if (res.next != null)
      return _checkGmailNewSenderPage(
          email: email, page: res.next, messages: messages);
    else
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
