/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/utils/helper/helper_repo_local_ss_crud.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'repo_local_ss_user_model.dart';

class RepoLocalSsUser extends HelperRepoLocalSsCrud<RepoLocalSsUserModel> {
  static const String _table = "user";
  static const String _version = "0.0.1";

  RepoLocalSsUser({FlutterSecureStorage secureStorage})
      : super(_table, _version, (RepoLocalSsUserModel model) => model.toJson(),
            (Map<String, dynamic> json) => RepoLocalSsUserModel.fromJson(json),
            secureStorage: secureStorage);
}
