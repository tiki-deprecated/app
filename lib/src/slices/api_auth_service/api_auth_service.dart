import 'package:flutter_appauth/flutter_appauth.dart';

import 'model/api_auth_service_provider_model.dart';

class ApiAuthService {
  final FlutterAppAuth appAuth;

  ApiAuthService() : appAuth = FlutterAppAuth();

  Future<AuthorizationTokenResponse?> authorizeAndExchangeCode(
      {required ApiAuthServiceProviderModel provider,
      List<String>? scopes}) async {
    AuthorizationServiceConfiguration authConfig =
        AuthorizationServiceConfiguration(
            provider.authorizationEndpoint, provider.tokenEndpoint);
    List<String> requestedScopes = scopes ?? List.empty(growable: false);
    return await appAuth.authorizeAndExchangeCode(
      AuthorizationTokenRequest(provider.clientId, provider.redirectUrl,
          serviceConfiguration: authConfig, scopes: requestedScopes),
    );
  }

  Future<TokenResponse?> refreshToken() async {
    return await appAuth.token(TokenRequest('<client_id>', '<redirect_url>',
        discoveryUrl: '<discovery_url>',
        refreshToken: '<refresh_token>',
        scopes: ['openid', 'profile', 'email', 'offline_access', 'api']));
  }
}
