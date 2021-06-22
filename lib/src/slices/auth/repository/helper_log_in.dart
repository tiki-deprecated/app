/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/repositories/repo_local_ss_current/app_model_current.dart';
import 'package:app/src/repositories/repo_local_ss_current/secure_storage_repository_current.dart';
import 'package:app/src/repositories/repo_local_ss_keys/keys_screen_model.dart';
import 'package:app/src/repositories/repo_local_ss_keys/secure_storage_repository_keys.dart';
import 'package:app/src/repositories/repo_local_ss_token/login_screen_model_token.dart';
import 'package:app/src/repositories/repo_local_ss_token/secure_storage_repository_token.dart';
import 'package:app/src/repositories/repo_local_ss_user/app_model_user.dart';
import 'package:app/src/repositories/repo_local_ss_user/secure_storage_repository_user.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class HelperLogIn {
  late RepoLocalSsCurrent _repoLocalSsCurrent;
  late RepoLocalSsUser _repoLocalSsUser;
  late RepoLocalSsKeys _repoLocalSsKeys;
  late RepoLocalSsToken _repoLocalSsToken;
  late FlutterSecureStorage secureStorage;
  late RepoLocalSsCurrentModel current;

  RepoLocalSsUserModel? user;
  RepoLocalSsKeysModel? keys;
  RepoLocalSsTokenModel? token;

  HelperLogIn() : secureStorage = FlutterSecureStorage() {
    _repoLocalSsCurrent = RepoLocalSsCurrent(secureStorage: secureStorage);
    _repoLocalSsUser = RepoLocalSsUser(secureStorage: secureStorage);
    _repoLocalSsKeys = RepoLocalSsKeys(secureStorage: secureStorage);
    _repoLocalSsToken = RepoLocalSsToken(secureStorage: secureStorage);
  }

  Future<HelperLogIn> load() async {
    current = await _repoLocalSsCurrent.find(RepoLocalSsCurrent.key);
    if (current.email != null) {
      user = await _repoLocalSsUser.find(current.email!);
      if (user!.address != null)
        keys = await _repoLocalSsKeys.find(user!.address!);
      token = await _repoLocalSsToken.find(current.email!);
    }
    return this;
  }

  bool isReturning() {
    return current.email != null;
  }

  bool isLoggedIn() {
    return user != null &&
        user!.isLoggedIn != null &&
        user!.isLoggedIn! &&
        keys != null &&
        keys!.address != null &&
        keys!.signPrivateKey != null &&
        keys!.dataPrivateKey != null &&
        token != null &&
        token!.refresh != null;
  }
}
