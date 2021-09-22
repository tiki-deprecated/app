/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:flutter/widgets.dart';
import 'package:logging/logging.dart';

import '../api_app_data/api_app_data_key.dart';
import '../api_app_data/api_app_data_service.dart';
import '../api_app_data/model/api_app_data_model.dart';
import '../api_company/api_company_service.dart';
import '../api_email_msg/api_email_msg_service.dart';
import '../api_email_sender/api_email_sender_service.dart';
import '../api_oauth/api_oauth_service.dart';
import '../api_oauth/model/api_oauth_model_account.dart';
import 'data_bkg_interface_provider.dart';
import 'data_bkg_service_email.dart';

class DataBkgService extends ChangeNotifier {
  final _log = Logger('DataBkgService');
  final ApiAppDataService _apiAppDataService;
  final ApiOAuthService _apiAuthService;
  late final DataBkgServiceEmail email;

  DataBkgService(
      {required ApiOAuthService apiAuthService,
      required ApiAppDataService apiAppDataService,
      required ApiCompanyService apiCompanyService,
      required ApiEmailSenderService apiEmailSenderService,
      required ApiEmailMsgService apiEmailMsgService})
      : this._apiAppDataService = apiAppDataService,
        this._apiAuthService = apiAuthService,
        this.email = DataBkgServiceEmail(
            apiAuthService: apiAuthService,
            apiAppDataService: apiAppDataService,
            apiCompanyService: apiCompanyService,
            apiEmailSenderService: apiEmailSenderService,
            apiEmailMsgService: apiEmailMsgService);

  Future<void> index(List<ApiOAuthModelAccount> accounts) async {
    _log.fine("fetch all data started");
    int startIndex = await _getStartIndex();
    for (int i = startIndex; i < accounts.length; i++) {
      ApiOAuthModelAccount account = accounts[i];
      await fetchData(account);
      await _apiAppDataService.save(
          ApiAppDataKey.dataBkgLastAccount, i.toString());
    }
    notifyListeners();
  }

  Future<void> fetchData(ApiOAuthModelAccount account) async {
    DataBkgInterfaceProvider? provider =
        _apiAuthService.getProvider(account) as DataBkgInterfaceProvider?;
    if (provider != null) {
      _log.fine("fetch data for " + account.provider!);
      if (provider.emailProvider != null) {
        _log.fine("fetch email data for " + account.email!);
        await _fetchEmail(account);
      }
    }
    notifyListeners();
  }

  Future<int> _getStartIndex() async {
    List<ApiOAuthModelAccount> accounts =
        await _apiAuthService.getAllAccounts();
    ApiAppDataModel? lastFetchAccount =
        await _apiAppDataService.getByKey(ApiAppDataKey.dataBkgLastAccount);
    int currentFetchAccount = lastFetchAccount != null &&
            int.parse(lastFetchAccount.value) >= accounts.length - 1
        ? int.parse(lastFetchAccount.value) + 1
        : 0;
    _log.fine("last fetched account $lastFetchAccount");
    return currentFetchAccount;
  }

  Future<void> _fetchEmail(ApiOAuthModelAccount account) async {
    await email.index(account);
    await _apiAppDataService.save(ApiAppDataKey.bkgSvEmailLastFetch,
        DateTime.now().millisecondsSinceEpoch.toString());
    await _apiAppDataService.save(ApiAppDataKey.gmailPage, '');
  }
}
