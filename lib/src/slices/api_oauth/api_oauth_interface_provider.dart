/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'model/api_oauth_model_account.dart';

abstract class ApiOAuthInterfaceProvider {
  Future<void> revokeToken(ApiOAuthModelAccount account);

  Future<bool> isConnected(ApiOAuthModelAccount account);
}
