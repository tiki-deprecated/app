/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:flutter/widgets.dart';
import 'package:flutter_appauth/flutter_appauth.dart';
import 'package:logging/logging.dart';

import '../api_auth_service/api_auth_service.dart';
import '../api_auth_service/model/api_auth_service_account_model.dart';
import 'data_bkg_service_provider.dart';
import 'model/data_bkg_model.dart';
import 'model/data_bkg_provider_name.dart';
import 'model/data_bkg_provider_type.dart';

class DataBkgService extends ChangeNotifier {
  final _log = Logger('DataBkgService');
  final DataBkgModel model = DataBkgModel();
  final ApiAuthService _apiAuthService;
  final Map<DataBkgProviderName,
          Map<DataBkgProviderType, Map<String, DataBkgServiceProvAbstract>>>
      _providers;

  DataBkgService({
    required Map<DataBkgProviderName,
            Map<DataBkgProviderType, Map<String, DataBkgServiceProvAbstract>>>
        providers,
    required ApiAuthService apiAuthService,
  })  : this._providers = providers,
        this._apiAuthService = apiAuthService;

  Future<ApiAuthServiceAccountModel?> linkAccount(
      DataBkgProviderName provider, DataBkgProviderType type) async {
    ApiAuthServiceAccountModel? account;
    String? providerName = provider.value;
    if (providerName != null) {
      AuthorizationTokenResponse? tokenResponse = await _apiAuthService
          .authorizeAndExchangeCode(providerName: providerName);
      if (tokenResponse != null) {
        ApiAuthServiceAccountModel apiAuthServiceAccountModel =
            ApiAuthServiceAccountModel(
                provider: providerName,
                accessToken: tokenResponse.accessToken,
                accessTokenExpiration: tokenResponse
                    .accessTokenExpirationDateTime?.millisecondsSinceEpoch,
                refreshToken: tokenResponse.refreshToken,
                shouldReconnect: 0);
        Map? userInfo =
            await _apiAuthService.getUserInfo(apiAuthServiceAccountModel);
        if (userInfo != null) {
          apiAuthServiceAccountModel.displayName = userInfo['name'];
          apiAuthServiceAccountModel.username = userInfo['id'];
          apiAuthServiceAccountModel.email = userInfo['email'];
          account = await _apiAuthService.upsert(apiAuthServiceAccountModel);
          DataBkgServiceProvAbstract providerService =
              DataBkgServiceProvAbstract(provider, type);
          if (!_providers.containsKey(provider)) _providers[provider] = {};
          if (!_providers[provider]!.containsKey(type))
            _providers[provider]![type] = {};
          _providers[provider]![type]![account!.username!] = providerService;
          return account;
        }
      }
    }
    return null;
  }

  DataBkgServiceProvAbstract? getAccount(
      {required DataBkgProviderName name,
      required DataBkgProviderType type,
      String? accountId}) {
    if (accountExists(name: name, type: type, accountId: accountId)) {
      return accountId == null
          ? _providers[name]![type]?.values.first
          : _providers[name]![type]?[accountId];
    }
    return null;
  }

  Future<void> removeAccount(
      {required DataBkgProviderName name,
      required DataBkgProviderType type,
      String? accountId}) async {
    if (accountExists(name: name, type: type, accountId: accountId)) {
      DataBkgServiceProvAbstract removeProvider =
          getAccount(name: name, type: type, accountId: accountId)!;
      removeProvider.logOut();
      accountId != null
          ? _providers[name]![type]!.remove(accountId)
          : _providers[name]![type]!
              .remove(_providers[name]![type]!.values.first);
      if (_providers[name]![type]!.isEmpty) _providers[name]!.remove(type);
      if (_providers[name]!.isEmpty) _providers.remove(name);
    }
  }

  bool accountExists(
      {required DataBkgProviderName name,
      required DataBkgProviderType type,
      String? accountId}) {
    return _providers.containsKey(name) &&
        _providers[name] != null &&
        _providers[name]!.containsKey(type) &&
        _providers[name]![type] != null &&
        ((accountId != null && _providers[name]![type]!.isNotEmpty) ||
            (_providers[name]![type]!.containsKey(accountId) &&
                _providers[name]![type]![accountId] != null));
  }
}
