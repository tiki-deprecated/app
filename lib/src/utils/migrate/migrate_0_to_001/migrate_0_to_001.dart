/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'dart:convert';

import 'package:app/src/features/repo/repo_local_ss_current/repo_local_ss_current.dart';
import 'package:app/src/features/repo/repo_local_ss_current/repo_local_ss_current_model.dart';
import 'package:app/src/features/repo/repo_local_ss_keys/repo_local_ss_keys.dart';
import 'package:app/src/features/repo/repo_local_ss_keys/repo_local_ss_keys_model.dart';
import 'package:app/src/features/repo/repo_local_ss_token/repo_local_ss_token.dart';
import 'package:app/src/features/repo/repo_local_ss_token/repo_local_ss_token_model.dart';
import 'package:app/src/features/repo/repo_local_ss_user/repo_local_ss_user.dart';
import 'package:app/src/features/repo/repo_local_ss_user/repo_local_ss_user_model.dart';
import 'package:app/src/utils/migrate/migrate_0_to_001/migrate_0_to_001_keys.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'migrate_0_to_001_user.dart';

class Migrate0to001 {
  final FlutterSecureStorage _secureStorage;
  final RepoLocalSsCurrent _repoLocalSsCurrent;
  final RepoLocalSsUser _repoLocalSsUser;
  final RepoLocalSsToken _repoLocalSsToken;
  final RepoLocalSsKeys _repoLocalSsKeys;

  Migrate0to001(this._secureStorage)
      : _repoLocalSsToken = RepoLocalSsToken(secureStorage: _secureStorage),
        _repoLocalSsKeys = RepoLocalSsKeys(secureStorage: _secureStorage),
        _repoLocalSsUser = RepoLocalSsUser(secureStorage: _secureStorage),
        _repoLocalSsCurrent = RepoLocalSsCurrent(secureStorage: _secureStorage);

  Future<void> migrate() async {
    Migrate0To001User user = await getUser();
    Migrate0To001Keys keys;
    if (user != null) {
      keys = await getKeys(user.uuid);
      await _repoLocalSsUser.save(
          user.email,
          RepoLocalSsUserModel(
              email: user.email,
              address: keys == null ? null : keys.address,
              isLoggedIn: false));

      await _repoLocalSsCurrent.save(
          user.email, RepoLocalSsCurrentModel(email: user.email));

      if (keys != null && keys.address != null)
        await _repoLocalSsKeys.save(
            keys.address,
            RepoLocalSsKeysModel(
                address: keys.address,
                dataPublicKey: keys.dataPublicKey,
                dataPrivateKey: keys.dataPrivateKey,
                signPublicKey: keys.signPublicKey,
                signPrivateKey: keys.signPrivateKey));

      await _repoLocalSsToken.save(user.email,
          RepoLocalSsTokenModel(bearer: user.bearer, refresh: user.refresh));

      await _secureStorage.delete(key: "com.mytiki.app.user");
      await _secureStorage.delete(key: "com.mytiki.app." + user.uuid);
    }
  }

  Future<Migrate0To001User> getUser() async {
    String userString = await _secureStorage.read(key: "com.mytiki.app.user");
    if (userString != null) {
      return Migrate0To001User.fromJson(jsonDecode(userString));
    } else
      return null;
  }

  Future<Migrate0To001Keys> getKeys(String uuid) async {
    String keysString =
        await _secureStorage.read(key: "com.mytiki.app." + uuid);
    if (keysString != null) {
      return Migrate0To001Keys.fromJson(jsonDecode(keysString));
    } else
      return null;
  }
}
