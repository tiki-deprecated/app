/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/slices/api_app_data/api_app_data_service.dart';
import 'package:flutter/widgets.dart';
import 'package:logging/logging.dart';

import '../api_auth_service/api_auth_service.dart';
import '../api_auth_service/model/api_auth_service_account_model.dart';
import '../api_google/api_google_service_email.dart';
import '../api_microsoft/api_microsoft_service_email.dart';
import 'data_bkg_service_provider.dart';
import 'data_bkg_sv_email_prov.dart';
import 'model/data_bkg_model.dart';
import 'model/data_bkg_provider_name.dart';

class DataBkgService extends ChangeNotifier {
  final _log = Logger('DataBkgService');
  final DataBkgModel model = DataBkgModel();
  final ApiAuthService _apiAuthService;
  List<ApiAuthServiceAccountModel> _accounts =
      List<ApiAuthServiceAccountModel>.empty(growable: true);

  final ApiAppDataService _apiAppDataService;

  DataBkgService(
      {required ApiAuthService apiAuthService,
      required ApiAppDataService apiAppDataService})
      : this._apiAuthService = apiAuthService,
        this._apiAppDataService = apiAppDataService {
    getExistingAccounts().then((_) => fetchAllData());
  }

  Future<void> getExistingAccounts() async {
    _accounts = await _apiAuthService.getAllAccounts();
  }

  fetchAllData() async {
    int startIndex = await _getStartIndex();
    for (int i = startIndex; i < _accounts.length; i++) {
      ApiAuthServiceAccountModel account = _accounts[i];
      await _fetchData(account);
    }
  }

  _fetchData(ApiAuthServiceAccountModel account) async {
    DataBkgServiceProvInterface? provider = _getProvider(account);
    if (provider != null) {
      if (provider is DataBkgSvEmailProvInterface) {
        await _fetchEmail(provider);
      }
    }
  }

  addAccount(ApiAuthServiceAccountModel account) {
    _accounts.add(account);
    _fetchData(account);
  }

  Future<void> _fetchEmail(DataBkgServiceProvInterface provider) async {}

  DataBkgServiceProvInterface? _getProvider(
      ApiAuthServiceAccountModel account) {
    switch (account.provider) {
      case DataBkgProviderName.google:
        return ApiGoogleServiceEmail(
            account: account,
            apiAppDataService: _apiAppDataService,
            apiAuthService: _apiAuthService);
      case DataBkgProviderName.microsoft:
        return ApiMicrosoftServiceEmail(account, _apiAuthService);
      default:
        return null;
    }
  }

  Future<int> _getStartIndex() async {
    // TODO implement
    return 0;
  }
}
