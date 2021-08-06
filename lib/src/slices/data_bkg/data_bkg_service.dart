/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:google_sign_in/google_sign_in.dart';

import '../api_app_data/api_app_data_key.dart';
import '../api_app_data/api_app_data_service.dart';
import '../api_company/api_company_service.dart';
import '../api_company/model/api_company_model_local.dart';
import '../api_email_msg/api_email_msg_service.dart';
import '../api_email_msg/model/api_email_msg_model.dart';
import '../api_email_sender/api_email_sender_service.dart';
import '../api_google/api_google_service.dart';
import '../data_bkg/model/data_bkg_model_page.dart';
import 'model/data_bkg_model.dart';

class DataBkgService {
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
    checkEmail();
  }

  Future<void> checkEmail() async {
    GoogleSignInAccount? googleAccount =
        await _apiGoogleService.getConnectedUser();
    if (googleAccount != null) {
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
          _apiAppDataService.save(ApiAppDataKey.fetchGmailLastRun,
              DateTime.now().millisecondsSinceEpoch.toString());
        }
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
