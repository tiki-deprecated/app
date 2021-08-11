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
import '../api_email_msg/api_email_msg_service.dart';
import '../api_email_msg/model/api_email_msg_model.dart';
import '../api_email_sender/api_email_sender_service.dart';
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

  // pass flag that says all otherwise only since last fetch (after:2004/04/16)
  // grab a batch of emails from gmail
  // loop
  // if we have the sender in the db, upsert the message
  // if we don't have the sender in the db, fetch all the messages for the sender, then add em all

  Future<void> checkGmail({bool fetchAll = false, bool force = false}) async {
    GoogleSignInAccount? googleAccount =
        await _apiGoogleService.getConnectedUser();
    ApiAppDataModel? appDataGmailLastRun =
        await _apiAppDataService.getByKey(ApiAppDataKey.gmailLastFetch);
    DateTime? gmailLastRun = appDataGmailLastRun != null
        ? DateTime.fromMillisecondsSinceEpoch(
            int.parse(appDataGmailLastRun.value))
        : null;
    if (googleAccount != null &&
        (force == true ||
            gmailLastRun == null ||
            DateTime.now()
                .subtract(Duration(days: 0 /*1*/))
                .isAfter(gmailLastRun)))
      return _checkGmailFetch(fetchAll: fetchAll, lastChecked: gmailLastRun);
  }

  _checkGmailFetch({bool fetchAll = false, DateTime? lastChecked}) async {
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
    for (String messageId in messages) {
      ApiEmailMsgModel? msg = await _apiGoogleService.gmailFetchMessage(
          messageId,
          format: "metadata",
          headers: ["List-unsubscribe"]);
      //do we have the sender? if so, upset message. if not, go get sender info
    }
  }

  /*
  DataBkgModelPage<ApiEmailMsgModel>? page;
      for (int i = 0; i < 10; i++) {
        page = await _apiGoogleService.gmailFetch(
            unsubscribeOnly: true, maxResults: 10, pageToken: page?.next);
        if (page.data != null) {
          for (ApiEmailMsgModel message in page.data!) {
            if (message.sender?.email != null) {
              ApiCompanyModelLocal? company = await _apiCompanyService
                  .upsert(domainFromEmail(message.sender!.email!));
              if (company != null) {
                message.sender!.company = company;
                await _apiEmailSenderService.upsert(message.sender!);
                await _apiEmailMsgService.upsert(message);
              }
            }
          }
          _apiAppDataService.save(ApiAppDataKey.gmailLastFetch,
              DateTime.now().millisecondsSinceEpoch.toString());
          notifyListeners();
        }
      }
    }
   */

  String domainFromEmail(String email) {
    List<String> atSplit = email.split('@');
    List<String> periodSplit = atSplit[atSplit.length - 1].split('.');
    return periodSplit[periodSplit.length - 2] +
        "." +
        periodSplit[periodSplit.length - 1];
  }
}
