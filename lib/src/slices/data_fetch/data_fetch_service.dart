/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:flutter/widgets.dart';
import 'package:logging/logging.dart';
import 'package:sqflite_sqlcipher/sqlite_api.dart';

import '../api_app_data/api_app_data_service.dart';
import '../api_company/api_company_service.dart';
import '../api_email_msg/api_email_msg_service.dart';
import '../api_email_sender/api_email_sender_service.dart';
import '../api_knowledge/api_knowledge_service.dart';
import '../api_oauth/api_oauth_service.dart';
import '../api_oauth/model/api_oauth_model_account.dart';
import '../data_push/data_push_service.dart';
import 'data_fetch_service_email.dart';

class DataFetchService extends ChangeNotifier {
  final _log = Logger('DataFetchService');
  final DataPushService _dataPushService;
  late final DataFetchServiceEmail email;

  DataFetchService(
      {required ApiOAuthService apiAuthService,
      required ApiAppDataService apiAppDataService,
      required ApiCompanyService apiCompanyService,
      required ApiEmailSenderService apiEmailSenderService,
      required ApiEmailMsgService apiEmailMsgService,
      required ApiKnowledgeService apiKnowledgeService,
      required DataPushService dataPushService,
      required Database database})
      : this._dataPushService = dataPushService {
    this.email = DataFetchServiceEmail(
        apiAuthService: apiAuthService,
        apiAppDataService: apiAppDataService,
        apiEmailMsgService: apiEmailMsgService,
        apiEmailSenderService: apiEmailSenderService,
        apiCompanyService: apiCompanyService,
        dataPushService: _dataPushService,
        database: database,
        notifyListeners: notifyListeners);
  }

  Future<void> asyncIndex(ApiOAuthModelAccount account) async {
    _log.fine('DataFetchService async index');
    email.asyncIndex(account);
  }
}
