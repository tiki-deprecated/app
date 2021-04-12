/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'dart:convert';

import 'package:app/src/repos/repo_ss_security_keys/repo_ss_security_keys_model.dart';
import 'package:app/src/utilities/utility_functions.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class RepoSSSecurityKeysBloc {
  static final String _keyPrefix = "com.mytiki.app.";
  final FlutterSecureStorage _secureStorage;
  RepoSSSecurityKeysModel _repoSSSecurityKeysModel;

  RepoSSSecurityKeysBloc(this._secureStorage);

  Future<RepoSSSecurityKeysModel> save(RepoSSSecurityKeysModel keys) async {
    await _secureStorage.write(
        key: _keyPrefix + keys.uuid, value: jsonEncode(keys.toJson()));
    return keys;
  }

  Future<RepoSSSecurityKeysModel> find(String uuid) async {
    Map jsonMap =
        jsonDecodeNullSafe(await _secureStorage.read(key: _keyPrefix + uuid));
    return RepoSSSecurityKeysModel.fromJson(jsonMap);
  }
}
