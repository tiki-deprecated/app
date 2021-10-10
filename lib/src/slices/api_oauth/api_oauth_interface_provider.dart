/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:http/http.dart';

import 'model/api_oauth_model_account.dart';

abstract class ApiOAuthInterfaceProvider {
  Future<Response> revokeToken(ApiOAuthModelAccount account);

  Future<bool> isConnected(ApiOAuthModelAccount account);
}
