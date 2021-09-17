/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

// ignore: prefer_relative_imports
import 'package:app/src/slices/info_carousel_card/model/info_carousel_card_model.dart';
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
import 'data_bkg_sv_email_interface.dart';
import 'data_bkg_sv_provider_interface.dart';

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
    loadAccounts().then((_) => index());
  }

  Future<void> loadAccounts() async {
    _accounts = await _apiAuthService.getAllAccounts();
    notifyListeners();
  }

  Future<void> index() async {
    _log.fine("fetch all data started");
    int startIndex = await _getStartIndex();
    for (int i = startIndex; i < _accounts.length; i++) {
      ApiAuthServiceAccountModel account = _accounts[i];
      await _fetchData(account);
      await _apiAppDataService.save(
          ApiAppDataKey.dataBkgLastAccount, i.toString());
    }
    notifyListeners();
  }

  void addAccount(ApiAuthServiceAccountModel account) {
    DataBkgServiceProviderInterface? providerService = _getProvider(account);
    if (providerService != null) {
      providerService.logIn(account);
      _accounts.add(account);
      _fetchData(account);
    }
    notifyListeners();
  }

  Future<void> removeAccount(int accountId) async {
    ApiAuthServiceAccountModel account =
        await _apiAuthService.getAccountById(accountId);
    DataBkgServiceProviderInterface? provider = _getProvider(account);
    if (provider != null) await provider.logOut(account);
    _accounts.removeWhere((account) => account.accountId == accountId);
    notifyListeners();
  }

  List<ApiAuthServiceAccountModel> getAccountList() {
    return _accounts;
  }

  Future<void> signOutAccounts() async {
    _accounts.forEach((account) async {
      DataBkgServiceProviderInterface? provider = await _getProvider(account);
      if (provider != null) {
        provider.logOut(account);
      }
    });
    notifyListeners();
  }

  DataBkgServiceEmail getServiceEmail(ApiAuthServiceAccountModel account) {
    DataBkgServiceEmailInterface provider =
        _getProvider(account) as DataBkgServiceEmailInterface;
    DataBkgServiceEmail dataBkgServiceEmail = DataBkgServiceEmail(
        this._apiAuthService,
        provider,
        this._apiCompanyService,
        this._apiEmailSenderService,
        this._apiEmailMsgService,
        this._apiAppDataService);
    return dataBkgServiceEmail;
  }

  Future<void> _fetchData(ApiAuthServiceAccountModel account) async {
    DataBkgServiceProviderInterface? provider = _getProvider(account);
    if (provider != null) {
      _log.fine("fetch data for " + account.provider!);
      if (provider is DataBkgServiceEmailInterface) {
        _log.fine("fetch email data for " + account.email!);
        await _fetchEmail(provider, account);
      }
    }
    notifyListeners();
  }

  Future<int> _getStartIndex() async {
    ApiAppDataModel? lastFetchAccount =
        await _apiAppDataService.getByKey(ApiAppDataKey.dataBkgLastAccount);
    int currentFetchAccount = lastFetchAccount != null &&
            int.parse(lastFetchAccount.value) >= _accounts.length - 1
        ? int.parse(lastFetchAccount.value) + 1
        : 0;
    _log.fine("last fetched account $lastFetchAccount");
    return currentFetchAccount;
  }

  Future<void> _fetchEmail(DataBkgServiceProviderInterface provider,
      ApiAuthServiceAccountModel account) async {
    DataBkgServiceEmail dataBkgServiceEmail = DataBkgServiceEmail(
        this._apiAuthService,
        provider as DataBkgServiceEmailInterface,
        this._apiCompanyService,
        this._apiEmailSenderService,
        this._apiEmailMsgService,
        this._apiAppDataService);
    await dataBkgServiceEmail.emailFetchList(account);
  }

  DataBkgServiceProviderInterface? _getProvider(
      ApiAuthServiceAccountModel account) {
    switch (account.provider) {
      case "google":
        return ApiGoogleServiceEmail(
            account: account,
            apiAppDataService: _apiAppDataService,
            apiAuthService: _apiAuthService);
      case "microsoft":
        return ApiMicrosoftServiceEmail(account, _apiAuthService);
      default:
        return null;
    }
  }

  Future<List<InfoCarouselCardModel>> getInfoCards(int accountId) async {
    List<ApiAuthServiceAccountModel> accounts =
        _accounts.where((account) => account.accountId == accountId).toList();
    if (accounts.isNotEmpty) {
      ApiAuthServiceAccountModel account = accounts[0];
      DataBkgServiceEmailInterface provider =
          _getProvider(account) as DataBkgServiceEmailInterface;
      return await provider.getInfoCards(account);
    }
    return List<InfoCarouselCardModel>.empty();
  }

  List<ApiAuthServiceAccountModel> getAccountsByProvider(String provider) {
    return _accounts.where((account) => account.provider == provider).toList();
  }
}
