/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/features/repo/repo_local_ss_current/repo_local_ss_current.dart';
import 'package:app/src/features/repo/repo_local_ss_current/repo_local_ss_current_model.dart';
import 'package:app/src/features/repo/repo_local_ss_keys/repo_local_ss_keys.dart';
import 'package:app/src/features/repo/repo_local_ss_keys/repo_local_ss_keys_model.dart';
import 'package:app/src/features/repo/repo_local_ss_token/repo_local_ss_token.dart';
import 'package:app/src/features/repo/repo_local_ss_token/repo_local_ss_token_model.dart';
import 'package:app/src/features/repo/repo_local_ss_user/repo_local_ss_user.dart';
import 'package:app/src/features/repo/repo_local_ss_user/repo_local_ss_user_model.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class HelperLogIn {
  final RepoLocalSsCurrent _repoLocalSsCurrent;
  final RepoLocalSsUser _repoLocalSsUser;
  final RepoLocalSsKeys _repoLocalSsKeys;
  final RepoLocalSsToken _repoLocalSsToken;

  RepoLocalSsCurrentModel current;
  RepoLocalSsUserModel user;
  RepoLocalSsKeysModel keys;
  RepoLocalSsTokenModel token;

  HelperLogIn(this._repoLocalSsCurrent, this._repoLocalSsUser,
      this._repoLocalSsKeys, this._repoLocalSsToken);

  HelperLogIn.auto(FlutterSecureStorage secureStorage)
      : _repoLocalSsCurrent = RepoLocalSsCurrent(secureStorage: secureStorage),
        _repoLocalSsUser = RepoLocalSsUser(secureStorage: secureStorage),
        _repoLocalSsKeys = RepoLocalSsKeys(secureStorage: secureStorage),
        _repoLocalSsToken = RepoLocalSsToken(secureStorage: secureStorage);

  Future<void> load() async {
    current = await _repoLocalSsCurrent.find(RepoLocalSsCurrent.key);
    if (current.email != null) {
      user = await _repoLocalSsUser.find(current.email);
      if (user.address != null)
        keys = await _repoLocalSsKeys.find(user.address);
      token = await _repoLocalSsToken.find(current.email);
    }
  }

  bool isReturning() {
    return current.email != null;
  }

  bool isLoggedIn() {
    return user != null &&
        user.isLoggedIn != null &&
        user.isLoggedIn &&
        keys != null &&
        keys.address != null &&
        keys.signPrivateKey != null &&
        keys.dataPrivateKey != null &&
        token != null &&
        token.refresh != null;
  }
}
