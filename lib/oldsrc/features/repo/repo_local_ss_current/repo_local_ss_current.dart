/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/utils/repo_local_ss_crud.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'repo_local_ss_current_model.dart';

class RepoLocalSsCurrent extends RepoLocalSsCrud<RepoLocalSsCurrentModel> {
  static const String key = "user";
  static const String _table = "current";
  static const String _version = "0.0.1";

  RepoLocalSsCurrent({FlutterSecureStorage? secureStorage})
      : super(
            _table,
            _version,
            (RepoLocalSsCurrentModel model) => model.toJson(),
            (Map<String, dynamic>? json) =>
                RepoLocalSsCurrentModel.fromJson(json),
            secureStorage: secureStorage);
}
