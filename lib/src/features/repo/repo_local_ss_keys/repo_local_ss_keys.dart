/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/utils/repo_local_ss_crud.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'repo_local_ss_keys_model.dart';

class RepoLocalSsKeys extends RepoLocalSsCrud<RepoLocalSsKeysModel> {
  static const String _table = "keys";
  static const String _version = "0.0.1";

  RepoLocalSsKeys({FlutterSecureStorage secureStorage})
      : super(_table, _version, (RepoLocalSsKeysModel model) => model.toJson(),
            (Map<String, dynamic> json) => RepoLocalSsKeysModel.fromJson(json),
            secureStorage: secureStorage);
}
