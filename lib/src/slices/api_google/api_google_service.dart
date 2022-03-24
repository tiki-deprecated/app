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
import 'api_google_service_email.dart';

class ApiGoogleService
    implements ApiOAuthInterfaceProvider, DataFetchInterfaceProvider {
  final ApiOAuthService _apiAuthService;
  final ApiGoogleServiceEmail _apiGoogleServiceEmail;

  ApiGoogleService(
      {required ApiOAuthService apiAuthService,
      required TikiKv tikiKv,
      required Httpp httpp})
      : _apiAuthService = apiAuthService,
        _apiGoogleServiceEmail = ApiGoogleServiceEmail(httpp);

  @override
  DataFetchInterfaceEmail? get email => _apiGoogleServiceEmail;

  @override
  Future<bool> isConnected(ApiOAuthModelAccount account) async {
    return (await _apiAuthService.getUserInfo(account)) != null;
  }

  @override
  Future<Response> revokeToken(ApiOAuthModelAccount account) async {
    Response rsp = await ConfigSentry.http.post(Uri.parse(
        'https://oauth2.googleapis.com/revoke?token=' + account.accessToken!));
    return rsp;
  }
}
