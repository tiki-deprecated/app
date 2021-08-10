/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

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

  DataBkgService({required ApiGoogleService apiGoogleService,
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

  Future<void> checkEmail() async {
    GoogleSignInAccount? googleAccount =
    await _apiGoogleService.getConnectedUser();
    appDataGmailLastRun =
    await _apiAppDataService.getByKey(ApiAppDataKey.fetchGmailLastRun);
    DateTime? gmailLastRun = appDataGmailLastRun != null
        ? DateTime.fromMillisecondsSinceEpoch(
        int.parse(appDataGmailLastRun!.value))
        : null;
    if (googleAccount != null &&
        (gmailLastRun == null ||
            DateTime.now().subtract(Duration(days: 0)).isAfter(gmailLastRun))) {
      Future.wait([
        fetchEachPendingSender(),
        fetchNewEmailsFromKnownSenders(),
        fetchNewSenders()
      ]);
      _apiAppDataService.save(ApiAppDataKey.fetchGmailLastRun,
          DateTime.now()
        .millisecondsSinceEpoch
        .toString());
    }
  }


  /// Fetch all emails from each sender.
  Future<void> fetchEachPendingSender() async {
    List<ApiEmailSenderModel> senders = await _apiEmailSenderService
        .getPending();
    for (int i = 0; i < senders.length; i++) {
      ApiEmailSenderModel sender = senders[i];
      String? pageToken = sender.lastPageToken;
      String senderQuery = "from: ${sender.email}";
      fetchAndSaveAllEmailFromSender(
          query: "$senderQuery", pageToken: pageToken);
    }
  }

  /// Fetch new emails from known senders.
  Future<void> fetchNewEmailsFromKnownSenders() async {
    List<ApiEmailSenderModel> senders = await _apiEmailSenderService.getKnown();
    String knownSenders = senders.map((sender) => "from: ${sender.email})")
        .join(" AND ");
    num lastRun = appDataGmailLastRun?.value != null ?
    num.parse(appDataGmailLastRun!.value) / 1000 :
    0;
    String sinceQuery = "after: $lastRun";
    await fetchEmailAndSaveData(
        maxResults: 10, batch: 10, query: "$knownSenders AND $sinceQuery");
  }

  /// Fetch at least one email from a new sender.
  Future<void> fetchNewSenders() async {
    List<ApiEmailSenderModel> senders = await _apiEmailSenderService.getAll();
    String knownSenders = senders.map((sender) => "-from: ${sender.email})")
        .join(" AND ");
    await fetchEmailAndSaveData(
        batch: 10, maxResults: 10, query: "$knownSenders");
  }


  /// Fetch emails from Gmail Api and save sender, company and message data.
  Future<List<ApiEmailMsgModel>?> fetchEmailAndSaveData(
      {int maxResults: 10, int batch: 10, query: "", pageToken}) async {
    DataBkgModelPage<ApiEmailMsgModel>? page;
    for (int i = 0; i < batch; i++) {
      _apiGoogleService.gmailFetch(
          unsubscribeOnly: true,
          maxResults: maxResults,
          pageToken: page?.next ?? pageToken,
          query: query
      ).then((page) {
        if (page.data != null) {
          _saveAllMessagesData(page.data!);
        }
      });
    }
  }

  /// Save the data of each email in a list.
  Future<void> _saveAllMessagesData(List<ApiEmailMsgModel> messages) async {
    List<Future> saveList = [];
    for (int i = 0; i < messages.length; i++) {
      ApiEmailMsgModel message = messages[i];
      saveList.add(_saveMessageData(message));
    }
    Future.wait(saveList);
  }

  /// Get domain from Email.
  String domainFromEmail(String email) {
    List<String> atSplit = email.split('@');
    List<String> periodSplit = atSplit[atSplit.length - 1].split('.');
    return periodSplit[periodSplit.length - 2] +
        "." +
        periodSplit[periodSplit.length - 1];
  }

  /// Save sender, company and message data.
  Future<void> _saveMessageData(message,
      {bool forceSenderUpdate = false}) async {
    if (message.sender?.email != null) {
      ApiEmailSenderModel? messageSender = await _apiEmailSenderService
          .getByEmail(message.sender!.email!);
      if (forceSenderUpdate || DateTime.fromMillisecondsSinceEpoch(messageSender!.updatedEpoch!)
              .isBefore(DateTime.now().subtract(Duration(days: 30)))) {
        ApiCompanyModelLocal? company = await _apiCompanyService.upsert(
            domainFromEmail(message.sender!.email!));
        if (company != null) {
          message.sender!.company = company;
          await _apiEmailSenderService.upsert(message.sender!);
        }
      }
      _apiEmailMsgService.upsert(message);
    }
  }

  /// Fetch all emails from sender and save data.
  void fetchAndSaveAllEmailFromSender(
      {required String query, String? pageToken}) {
    DataBkgModelPage<ApiEmailMsgModel>? page;
    do {
      _apiGoogleService.gmailFetch(
          unsubscribeOnly: true,
          maxResults: 10,
          pageToken: page?.next ?? pageToken,
              query: query)
          .then((page) {
        if (page.data != null) {
          _saveAllMessagesData(page.data!).then(
              (_) => _saveSenderLastPage(page.next, page.data![0].sender!));
        }
      });
    } while (page?.next != null);
  }

  _saveSenderLastPage(String pageToken, ApiEmailSenderModel sender) {
    sender.lastPageToken = pageToken;
    _apiEmailSenderService.upsert(sender);
  }
}

