/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'model/api_oauth_model_account.dart';

abstract class ApiOAuthInterfaceProvider {
  logIn(ApiOAuthModelAccount account);

  logOut(ApiOAuthModelAccount account);

  isConnected(ApiOAuthModelAccount account);
}
