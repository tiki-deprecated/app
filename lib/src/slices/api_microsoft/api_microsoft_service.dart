/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:http/http.dart';
import 'package:httpp/httpp.dart';
import 'package:tiki_kv/tiki_kv.dart';

import '../../config/config_sentry.dart';
import '../api_oauth/api_oauth_interface_provider.dart';
import '../api_oauth/api_oauth_service.dart';
import '../api_oauth/model/api_oauth_model_account.dart';
import '../data_fetch/data_fetch_interface_email.dart';
import '../data_fetch/data_fetch_interface_provider.dart';
import 'api_microsoft_service_email.dart';

class ApiMicrosoftService
    implements ApiOAuthInterfaceProvider, DataFetchInterfaceProvider {
  final ApiOAuthService _apiAuthService;
  final ApiMicrosoftServiceEmail _apiMicrosoftServiceEmail;

  ApiMicrosoftService(
      {required ApiOAuthService apiAuthService,
      required TikiKv tikiKv,
      required Httpp httpp})
      : _apiAuthService = apiAuthService,
        _apiMicrosoftServiceEmail = ApiMicrosoftServiceEmail(httpp);

  @override
  DataFetchInterfaceEmail? get email => _apiMicrosoftServiceEmail;

  @override
  Future<bool> isConnected(ApiOAuthModelAccount account) async =>
      (await _apiAuthService.getUserInfo(account)) != null;

  @override
  Future<Response> revokeToken(ApiOAuthModelAccount account) async =>
      await ConfigSentry.http.post(Uri.parse(
          'https://oauth2.googleapis.com/v1.0/me/revokeSignInSessions'));
}
