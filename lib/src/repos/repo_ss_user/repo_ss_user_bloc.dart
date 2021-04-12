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
  RepoSSUserModel _repoSSUserModel;

  RepoSSUserBloc(this._secureStorage);

  Future<RepoSSUserModel> save(RepoSSUserModel user) async {
    await _secureStorage.write(key: _key, value: jsonEncode(user.toJson()));
    _repoSSUserModel = await _find();
    return user;
  }

  Future<RepoSSUserModel> find() async {
    if (_repoSSUserModel != null)
      return _repoSSUserModel;
    else
      return await _find();
  }

  Future<RepoSSUserModel> setTokens(String bearer, String refresh) async {
    RepoSSUserModel userModel = await find();
    userModel.refresh = refresh;
    userModel.bearer = bearer;
    return await save(userModel);
  }

  Future<RepoSSUserModel> setLoggedIn(bool isLoggedIn) async {
    RepoSSUserModel userModel = await find();
    userModel.loggedIn = isLoggedIn;
    return await save(userModel);
  }

  Future<RepoSSUserModel> _find() async {
    Map jsonMap = jsonDecodeNullSafe(await _secureStorage.read(key: _key));
    return RepoSSUserModel.fromJson(jsonMap);
  }
}
