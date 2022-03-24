/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:sqflite_sqlcipher/sqlite_api.dart';
import 'package:tiki_kv/tiki_kv.dart';

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

  final Set<int> _indexMutex = {};

  DataFetchService(
      {required ApiOAuthService apiAuthService,
      required TikiKv tikiKv,
      required ApiCompanyService apiCompanyService,
      required ApiEmailSenderService apiEmailSenderService,
      required ApiEmailMsgService apiEmailMsgService,
      required ApiKnowledgeService apiKnowledgeService,
      required DataPushService dataPushService,
      required Database database})
      : _dataPushService = dataPushService {
    email = DataFetchServiceEmail(
        apiAuthService: apiAuthService,
        tikiKv: tikiKv,
        apiEmailMsgService: apiEmailMsgService,
        apiEmailSenderService: apiEmailSenderService,
        apiCompanyService: apiCompanyService,
        dataPushService: _dataPushService,
        database: database,
        notifyListeners: notifyListeners);
  }

  Future<void> asyncIndex(ApiOAuthModelAccount account) async {
    if (!_indexMutex.contains(account.accountId!)) {
      _indexMutex.add(account.accountId!);
      _log.fine(
          'DataFetchService async index for account ${account.accountId}');
      Future f1 = email.asyncIndex(account);
      Future f2 = email.asyncProcess(account);
      await Future.wait([f1, f2]);
      _indexMutex.remove(account.accountId!);
    }
  }
}
