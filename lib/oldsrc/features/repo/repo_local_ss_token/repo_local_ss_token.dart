/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/utils/repo_local_ss_crud.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'repo_local_ss_token_model.dart';

class RepoLocalSsToken extends RepoLocalSsCrud<RepoLocalSsTokenModel> {
  static const String _table = "token";
  static const String _version = "0.0.1";

  RepoLocalSsToken({FlutterSecureStorage? secureStorage})
      : super(
            _table,
            _version,
            (RepoLocalSsTokenModel model) => model.toJson(),
            (Map<String, dynamic>? json) =>
                RepoLocalSsTokenModel.fromJson(json),
            secureStorage: secureStorage);
}
