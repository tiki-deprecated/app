import 'dart:convert';

import 'package:flutter_appauth/flutter_appauth.dart';
import 'package:http/http.dart';
import 'package:sqflite_sqlcipher/sqflite.dart';

import '../../config/config_sentry.dart';
import '../../utils/api/helper_api_headers.dart';
import '../../utils/api/helper_api_utils.dart';
import '../api_app_data/api_app_data_service.dart';
import '../api_google/api_google_service_email.dart';
import '../api_microsoft/api_microsoft_service_email.dart';
import 'model/api_auth_service_account_model.dart';
import 'model/api_auth_service_provider_model.dart';
import 'model/api_auth_sv_provider_interface.dart';
import 'repository/api_auth_service_repository.dart';

class ApiAuthService {
  final FlutterAppAuth _appAuth;
  final ApiAuthServiceRepository _apiAuthServiceRepository;
  final ApiAppDataService _apiAppDataService;

  ApiAuthService(
      {required Database database,
      required ApiAppDataService apiAppDataService})
      : _appAuth = FlutterAppAuth(),
        _apiAuthServiceRepository = ApiAuthServiceRepository(database),
        _apiAppDataService = apiAppDataService;

  Future<ApiAuthServiceProviderModel?> _getProvider(providerName) async =>
      _apiAuthServiceRepository.getProvider(providerName);

  Future<AuthorizationTokenResponse?> authorizeAndExchangeCode(
      {required String providerName}) async {
    ApiAuthServiceProviderModel? provider = await _getProvider(providerName);
    AuthorizationServiceConfiguration authConfig =
        AuthorizationServiceConfiguration(
            provider!.authorizationEndpoint, provider.tokenEndpoint);
    List<String> providerScopes = provider.scopes;
    return await _appAuth.authorizeAndExchangeCode(
      AuthorizationTokenRequest(provider.clientId, provider.redirectUri,
          serviceConfiguration: authConfig, scopes: providerScopes),
    );
  }

  Future<TokenResponse?> refreshToken(
      ApiAuthServiceAccountModel account) async {
    try {
      ApiAuthServiceProviderModel? provider =
          await _getProvider(account.provider!);
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

  Future<ApiAuthServiceAccountModel?> getAccount(
      String provider, String username) async {
    return await _apiAuthServiceRepository.getByProviderAndUsername(
        provider, username);
  }

  Future<List<ApiAuthServiceAccountModel>> getAccountsByProvider(
      String provider) async {
    return await _apiAuthServiceRepository.getByProvider(provider);
  }

  Future<ApiAuthServiceAccountModel?> upsert(
      ApiAuthServiceAccountModel account) async {
    String providerName = account.provider!;
    ApiAuthServiceAccountModel? dbAccount =
        account.provider != null && account.username != null
            ? await _apiAuthServiceRepository.getByProviderAndUsername(
                providerName, account.username!)
            : null;
    if (dbAccount != null) {
      account.accountId = dbAccount.accountId;
      return _apiAuthServiceRepository.update(account);
    }
    return _apiAuthServiceRepository.insert(account);
  }

  Future<dynamic> proxy(Future<dynamic> Function() request,
      ApiAuthServiceAccountModel account) async {
    Response rsp = await request();
    if (HelperApiUtils.isUnauthorized(rsp.statusCode)) {
      await refreshToken(account);
      rsp = await request();
    }
    return rsp;
  }

  Future<Map?> getUserInfo(
      ApiAuthServiceAccountModel apiAuthServiceAccountModel) async {
    ApiAuthServiceProviderModel? providerModel =
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

  Future<void> signOut(
      ApiAuthServiceAccountModel apiAuthServiceAccountModel) async {
    await _apiAuthServiceRepository.delete(apiAuthServiceAccountModel);
  }

  Future<void> signOutAccounts() async {
    List<ApiAuthServiceAccountModel> accounts = await this.getAllAccounts();
    accounts.forEach((account) async {
      ApiAuthServiceProviderInterface? provider = getProvider(account);
      if (provider != null) {
        provider.logOut(account);
      }
    });
  }

  Future<List<ApiAuthServiceAccountModel>> getAllAccounts() async {
    return await _apiAuthServiceRepository.getAll();
  }

  Future<ApiAuthServiceAccountModel?> getAccountById(int accountId) async {
    return await _apiAuthServiceRepository.getById(accountId);
  }

  Future<ApiAuthServiceAccountModel?> linkAccount(String providerName) async {
    ApiAuthServiceAccountModel? account;
    AuthorizationTokenResponse? tokenResponse =
        await this.authorizeAndExchangeCode(providerName: providerName);
    if (tokenResponse != null) {
      ApiAuthServiceAccountModel apiAuthServiceAccountModel =
          ApiAuthServiceAccountModel(
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
    return _apiAuthServiceRepository.providers!.keys
        .map((el) => el as String)
        .toList();
  }

  ApiAuthServiceProviderInterface? getProvider(
      ApiAuthServiceAccountModel account) {
    switch (account.provider) {
      case "google":
        return ApiGoogleServiceEmail(
            account: account,
            apiAppDataService: _apiAppDataService,
            apiAuthService: this);
      case "microsoft":
        return ApiMicrosoftServiceEmail(
            account: account,
            apiAppDataService: _apiAppDataService,
            apiAuthService: this);
      default:
        return null;
    }
  }
}
