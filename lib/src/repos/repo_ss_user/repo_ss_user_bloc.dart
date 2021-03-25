/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'dart:convert';

import 'package:app/src/repos/repo_ss_user/repo_ss_user_model.dart';
import 'package:app/src/utilities/utility_functions.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class RepoSSUserBloc {
  static final String _key = "com.mytiki.app.user";
  final FlutterSecureStorage _secureStorage;

  RepoSSUserBloc(this._secureStorage);

  Future<RepoSSUserModel> save(RepoSSUserModel user) async {
    await _secureStorage.write(key: _key, value: jsonEncode(user.toJson()));
    return user;
  }

  Future<RepoSSUserModel> find() async {
    Map jsonMap = jsonDecodeNullSafe(await _secureStorage.read(key: _key));
    return RepoSSUserModel.fromJson(jsonMap);
  }
}
