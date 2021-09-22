/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'dart:convert';

import 'package:flutter_appauth/flutter_appauth.dart';
import 'package:http/http.dart';
import 'package:sqflite_sqlcipher/sqflite.dart';

import '../../config/config_sentry.dart';
import '../../utils/api/helper_api_headers.dart';
import '../../utils/api/helper_api_utils.dart';
import '../api_app_data/api_app_data_service.dart';
import '../api_google/api_google_service.dart';
import 'api_oauth_interface_provider.dart';
import 'model/api_oauth_model_account.dart';
import 'model/api_oauth_model_provider.dart';
import 'repository/api_oauth_repository_account.dart';
import 'repository/api_oauth_repository_provider.dart';

class ApiOAuthService {
  final FlutterAppAuth _appAuth;
  final ApiOAuthRepositoryAccount _apiAuthRepositoryAccount;
  final ApiOAuthRepositoryProvider _apiAuthRepositoryProvider;
  final ApiAppDataService _apiAppDataService;

  ApiOAuthService(
      {required Database database,
      required ApiAppDataService apiAppDataService})
      : _appAuth = FlutterAppAuth(),
        _apiAuthRepositoryAccount = ApiOAuthRepositoryAccount(database),
        _apiAuthRepositoryProvider = ApiOAuthRepositoryProvider(),
        _apiAppDataService = apiAppDataService;

  Future<ApiOAuthModelProvider?> _getProvider(providerName) async =>
      _apiAuthRepositoryProvider.getProvider(providerName);

  Future<AuthorizationTokenResponse?> authorizeAndExchangeCode(
      {required String providerName}) async {
    ApiOAuthModelProvider? provider = await _getProvider(providerName);
    AuthorizationServiceConfiguration authConfig =
        AuthorizationServiceConfiguration(
            provider!.authorizationEndpoint, provider.tokenEndpoint);
    List<String> providerScopes = provider.scopes;
    return await _appAuth.authorizeAndExchangeCode(
      AuthorizationTokenRequest(provider.clientId, provider.redirectUri,
          serviceConfiguration: authConfig, scopes: providerScopes),
    );
  }

  Future<TokenResponse?> refreshToken(ApiOAuthModelAccount account) async {
    try {
      ApiOAuthModelProvider? provider = await _getProvider(account.provider!);
      return await _appAuth.token(TokenRequest(
          provider!.clientId, provider.redirectUri,
          discoveryUrl: provider.discoveryUrl,
          refreshToken: account.refreshToken,
          scopes: provider.scopes));
    } catch (e) {
      print(e.toString());
      account.shouldReconnect = 1;
    }
  }

  Future<ApiOAuthModelAccount?> getAccount(
      String provider, String username) async {
    return await _apiAuthRepositoryAccount.getByProviderAndUsername(
        provider, username);
  }

  Future<List<ApiOAuthModelAccount>> getAccountsByProvider(
      String provider) async {
    return await _apiAuthRepositoryAccount.getByProvider(provider);
  }

  Future<ApiOAuthModelAccount?> upsert(ApiOAuthModelAccount account) async {
    String providerName = account.provider!;
    ApiOAuthModelAccount? dbAccount =
        account.provider != null && account.username != null
            ? await _apiAuthRepositoryAccount.getByProviderAndUsername(
                providerName, account.username!)
            : null;
    if (dbAccount != null) {
      account.accountId = dbAccount.accountId;
      return _apiAuthRepositoryAccount.update(account);
    }
    return _apiAuthRepositoryAccount.insert(account);
  }

  Future<dynamic> proxy(
      Future<dynamic> Function() request, ApiOAuthModelAccount account) async {
    Response rsp = await request();
    if (HelperApiUtils.isUnauthorized(rsp.statusCode)) {
      await refreshToken(account);
      rsp = await request();
    }
    return rsp;
  }

  Future<Map?> getUserInfo(
      ApiOAuthModelAccount apiAuthServiceAccountModel) async {
    ApiOAuthModelProvider? providerModel =
        await this._getProvider(apiAuthServiceAccountModel.provider);
    if (providerModel != null) {
      Response rsp = await proxy(
          () => ConfigSentry.http.get(Uri.parse(providerModel.userInfoEndpoint),
              headers:
                  HelperApiHeaders(auth: apiAuthServiceAccountModel.accessToken)
                      .header),
          apiAuthServiceAccountModel);
      if (HelperApiUtils.is2xx(rsp.statusCode)) {
        return jsonDecode(rsp.body);
      }
    }
    return null;
  }

  Future<void> signOut(ApiOAuthModelAccount apiAuthServiceAccountModel) async {
    await _apiAuthRepositoryAccount.delete(apiAuthServiceAccountModel);
  }

  Future<void> signOutAccounts() async {
    List<ApiOAuthModelAccount> accounts = await this.getAllAccounts();
    accounts.forEach((account) async {
      ApiOAuthInterfaceProvider? provider = getProvider(account);
      if (provider != null) {
        provider.logOut(account);
      }
    });
  }

  Future<List<ApiOAuthModelAccount>> getAllAccounts() async {
    return await _apiAuthRepositoryAccount.getAll();
  }

  Future<ApiOAuthModelAccount?> getAccountById(int accountId) async {
    return await _apiAuthRepositoryAccount.getById(accountId);
  }

  Future<ApiOAuthModelAccount?> linkAccount(String providerName) async {
    ApiOAuthModelAccount? account;
    AuthorizationTokenResponse? tokenResponse =
        await this.authorizeAndExchangeCode(providerName: providerName);
    if (tokenResponse != null) {
      ApiOAuthModelAccount apiAuthServiceAccountModel = ApiOAuthModelAccount(
          provider: providerName,
          accessToken: tokenResponse.accessToken,
          accessTokenExpiration: tokenResponse
              .accessTokenExpirationDateTime?.millisecondsSinceEpoch,
          refreshToken: tokenResponse.refreshToken,
          shouldReconnect: 0);
      Map? userInfo = await this.getUserInfo(apiAuthServiceAccountModel);
      if (userInfo != null) {
        apiAuthServiceAccountModel.displayName = userInfo['name'];
        apiAuthServiceAccountModel.username = userInfo['id'];
        apiAuthServiceAccountModel.email = userInfo['email'];
        account = await this.upsert(apiAuthServiceAccountModel);
        return account;
      }
    }
    return null;
  }

  List<String> getProviders() {
    return _apiAuthRepositoryProvider.providers!.keys
        .map((el) => el as String)
        .toList();
  }

  ApiOAuthInterfaceProvider? getProvider(ApiOAuthModelAccount account) {
    switch (account.provider) {
      case "google":
        return ApiGoogleService(
            apiAppDataService: _apiAppDataService, apiAuthService: this);
      default:
        return null;
    }
  }
}
