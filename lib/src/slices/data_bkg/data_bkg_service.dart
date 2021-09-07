/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'data_bkg_sv_email_prov.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_appauth/flutter_appauth.dart';
import 'package:logging/logging.dart';

import '../api_auth_service/api_auth_service.dart';
import '../api_auth_service/model/api_auth_service_account_model.dart';
import 'model/data_bkg_model.dart';

class DataBkgService extends ChangeNotifier {
  final _log = Logger('DataBkgService');
  final DataBkgModel model = DataBkgModel();
  final ApiAuthService _apiAuthService;
  final Map<String, DataBkgSvEmailProvAbstract> _emailProviders;

  DataBkgService({
    required Map<String, DataBkgSvEmailProvAbstract> emailProviders,
    required ApiAuthService apiAuthService,
  })
      : this._emailProviders = emailProviders,
        this._apiAuthService = apiAuthService;

  Future<ApiAuthServiceAccountModel?> linkAccount(String providerName) async {
    ApiAuthServiceAccountModel? account;
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
        return account;
      }
    }
    // TODO call account specific login routines
    return null;
  }

  DataBkgSvEmailProvAbstract? getAccount(String provider) {
    if (_emailProviders.containsKey(provider)) {
      return _emailProviders[provider];
    }
    return null;
  }

  Future<void> removeAccount(String provider) async {
    if (_emailProviders.containsKey(provider)) {
      DataBkgSvEmailProvAbstract removeProvider = _emailProviders[provider]!;
      removeProvider.logOut();
      _emailProviders.remove(provider)
    }
    return null;
  }
}
