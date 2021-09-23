/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:flutter/widgets.dart';
import 'package:logging/logging.dart';

import '../api_app_data/api_app_data_service.dart';
import '../api_company/api_company_service.dart';
import '../api_email_msg/api_email_msg_service.dart';
import '../api_email_sender/api_email_sender_service.dart';
import '../api_oauth/api_oauth_service.dart';
import '../api_oauth/model/api_oauth_model_account.dart';
import 'data_bkg_service_email.dart';

class DataBkgService extends ChangeNotifier {
  final _log = Logger('DataBkgService');
  late final DataBkgServiceEmail email;

  DataBkgService(
      {required ApiOAuthService apiAuthService,
      required ApiAppDataService apiAppDataService,
      required ApiCompanyService apiCompanyService,
      required ApiEmailSenderService apiEmailSenderService,
      required ApiEmailMsgService apiEmailMsgService}) {
    this.email = DataBkgServiceEmail(
        apiAuthService: apiAuthService,
        apiAppDataService: apiAppDataService,
        apiEmailMsgService: apiEmailMsgService,
        apiEmailSenderService: apiEmailSenderService,
        apiCompanyService: apiCompanyService,
        notifyListeners: notifyListeners);
  }

  Future<void> index(ApiOAuthModelAccount account) async {
    _log.fine('DataBkgService index');
    await email.index(account);
    notifyListeners();
  }
}
