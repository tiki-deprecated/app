/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/slices/api_user/model/api_user_model_keys.dart';
import 'package:app/src/utils/abstract_ss_repository.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ApiUserRepositoryKeys extends AbstractSsRepository<ApiUserModelKeys> {
  static const String _table = "keys";
  static const String _version = "0.0.1";

  ApiUserRepositoryKeys(FlutterSecureStorage secureStorage)
      : super(
            table: _table,
            version: _version,
            toJson: (ApiUserModelKeys model) => model.toJson(),
            fromJson: (Map<String, dynamic>? json) =>
                ApiUserModelKeys.fromJson(json),
            secureStorage: secureStorage);
}
