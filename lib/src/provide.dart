/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/features/repo_api_bouncer_otp/repo_api_bouncer_otp.dart';
import 'package:app/src/features/repo_local_ss_keys/repo_local_ss_keys.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'features/repo_local_ss_otp/repo_local_ss_otp.dart';
import 'features/repo_local_ss_token/repo_local_ss_token.dart';
import 'features/repo_local_ss_user/repo_local_ss_user.dart';

class Provide {
  static Widget chain(Widget child) {
    return _repos(child);
  }

  static Widget _repos(Widget child) {
    final FlutterSecureStorage secureStorage = FlutterSecureStorage();
    return MultiRepositoryProvider(providers: [
      RepositoryProvider<RepoLocalSsUser>(
        create: (context) => RepoLocalSsUser(secureStorage: secureStorage),
      ),
      RepositoryProvider<RepoLocalSsToken>(
        create: (context) => RepoLocalSsToken(secureStorage: secureStorage),
      ),
      RepositoryProvider<RepoLocalSsKeys>(
        create: (context) => RepoLocalSsKeys(secureStorage: secureStorage),
      ),
      RepositoryProvider<RepoLocalSsOtp>(
        create: (context) => RepoLocalSsOtp(secureStorage: secureStorage),
      ),
      RepositoryProvider<RepoApiBouncerOtp>(
        create: (context) => RepoApiBouncerOtp(),
      ),
    ], child: child);
  }
}
