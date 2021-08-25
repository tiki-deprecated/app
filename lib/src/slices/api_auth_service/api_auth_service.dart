import 'package:flutter_appauth/flutter_appauth.dart';

import 'model/api_auth_service_account_model.dart';
import 'model/api_auth_service_provider_model.dart';
import 'repository/api_auth_service_repository.dart';

class ApiAuthService {
  final FlutterAppAuth _appAuth;
  final ApiAuthServiceRepository _apiAuthServiceRepository;

  ApiAuthService()
      : _appAuth = FlutterAppAuth(),
        _apiAuthServiceRepository = ApiAuthServiceRepository();

  Future<AuthorizationTokenResponse?> authorizeAndExchangeCode(
      {required String providerName, List<String>? scopes}) async {
    ApiAuthServiceProviderModel provider = getProvider(providerName);
    AuthorizationServiceConfiguration authConfig =
        AuthorizationServiceConfiguration(
            provider.authorizationEndpoint, provider.tokenEndpoint);
    List<String> requestedScopes = scopes ?? List.empty(growable: false);
    return await _appAuth.authorizeAndExchangeCode(
      AuthorizationTokenRequest(provider.clientId, provider.redirectUri,
          serviceConfiguration: authConfig, scopes: requestedScopes),
    );
  }

  Future<TokenResponse?> refreshToken(
      ApiAuthServiceAccountModel account) async {
    ApiAuthServiceProviderModel provider =
        _apiAuthServiceRepository.providers[account.provider];
    return await _appAuth.token(TokenRequest(
        provider.clientId, provider.redirectUri,
        discoveryUrl: provider.discoveryUrl,
        refreshToken: account.refreshToken,
        scopes: account.scopes));
  }

  ApiAuthServiceProviderModel getProvider(String provider) {
    return _apiAuthServiceRepository.providers[provider];
  }
}
