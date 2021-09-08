/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:flutter/widgets.dart';
import 'package:logging/logging.dart';

import '../api_app_data/api_app_data_key.dart';
import '../api_app_data/api_app_data_service.dart';
import '../api_app_data/model/api_app_data_model.dart';
import '../api_auth_service/api_auth_service.dart';
import '../api_auth_service/model/api_auth_service_account_model.dart';
import '../api_company/api_company_service.dart';
import '../api_email_msg/api_email_msg_service.dart';
import '../api_email_sender/api_email_sender_service.dart';
import '../api_google/api_google_service_email.dart';
import '../api_microsoft/api_microsoft_service_email.dart';
import 'data_bkg_service_email.dart';
import 'data_bkg_service_provider.dart';
import 'data_bkg_sv_email_prov.dart';
import 'model/data_bkg_provider_name.dart';

class DataBkgService extends ChangeNotifier {
  final _log = Logger('DataBkgService');
  final ApiAuthService _apiAuthService;
  List<ApiAuthServiceAccountModel> _accounts =
      List<ApiAuthServiceAccountModel>.empty(growable: true);

  final ApiAppDataService _apiAppDataService;

  ApiCompanyService _apiCompanyService;
  ApiEmailSenderService _apiEmailSenderService;
  ApiEmailMsgService _apiEmailMsgService;

  DataBkgService(
      {required ApiAuthService apiAuthService,
      required ApiAppDataService apiAppDataService,
      required ApiCompanyService apiCompanyService,
      required ApiEmailSenderService apiEmailSenderService,
      required ApiEmailMsgService apiEmailMsgService})
      : this._apiAuthService = apiAuthService,
        this._apiAppDataService = apiAppDataService,
        this._apiCompanyService = apiCompanyService,
        this._apiEmailSenderService = apiEmailSenderService,
        this._apiEmailMsgService = apiEmailMsgService {
    getExistingAccounts().then((_) => fetchAllData());
  }

  Future<void> getExistingAccounts() async {
    _accounts = await _apiAuthService.getAllAccounts();
  }

  fetchAllData() async {
    _log.fine("fetch all data started");
    int startIndex = await _getStartIndex();
    for (int i = startIndex; i < _accounts.length; i++) {
      ApiAuthServiceAccountModel account = _accounts[i];
      await _fetchData(account);
      await _apiAppDataService.save(
          ApiAppDataKey.dataBkgLastAccount, i.toString());
    }
  }

  _fetchData(ApiAuthServiceAccountModel account) async {
    DataBkgServiceProvInterface? provider = _getProvider(account);
    if (provider != null) {
      _log.fine("fetch data for " +
          (provider.account.provider as DataBkgProviderName).value!);
      if (provider is DataBkgSvEmailProvInterface) {
        _log.fine("fetch email data for " + provider.account.email!);
        await _fetchEmail(provider);
      }
    }
  }

  addAccount(ApiAuthServiceAccountModel account) {
    _accounts.add(account);
    _fetchData(account);
  }

  Future<void> _fetchEmail(DataBkgServiceProvInterface provider) async {
    DataBkgServiceEmail dataBkgServiceEmail = DataBkgServiceEmail(
        this._apiAuthService,
        provider as DataBkgSvEmailProvInterface,
        this._apiCompanyService,
        this._apiEmailSenderService,
        this._apiEmailMsgService,
        this._apiAppDataService);
    await dataBkgServiceEmail.checkEmail();
  }

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
    ApiAppDataModel? lastFetchAccount =
        await _apiAppDataService.getByKey(ApiAppDataKey.dataBkgLastAccount);
    int currentFetchAccount =
        lastFetchAccount != null ? int.parse(lastFetchAccount.value) + 1 : 0;
    return currentFetchAccount;
  }
}
