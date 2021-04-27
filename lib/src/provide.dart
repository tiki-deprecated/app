/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:flutter/widgets.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'features/repo_api_bouncer_otp/repo_api_bouncer_otp_provider.dart';
import 'features/repo_local_ss_keys/repo_local_ss_keys_provider.dart';
import 'features/repo_local_ss_token/repo_local_ss_token_provider.dart';
import 'features/repo_local_ss_user/repo_local_ss_user_provider.dart';

class Provide {
  static Widget chain(Widget child) {
    return _repos(child);
  }

  static Widget _repos(Widget child) {
    final FlutterSecureStorage secureStorage = FlutterSecureStorage();
    return RepoLocalSsUserProvider(
        secureStorage: secureStorage,
        child: RepoLocalSsKeysProvider(
            secureStorage: secureStorage,
            child: RepoLocalSsTokenProvider(
                secureStorage: secureStorage,
                child: RepoApiBouncerOtpProvider(child: child))));
  }
}
