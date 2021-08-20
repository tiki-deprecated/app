/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../../utils/abstract_ss_repository.dart';
import '../model/api_user_model_current.dart';

class ApiUserRepositoryCurrent
    extends AbstractSsRepository<ApiUserModelCurrent> {
  static const String key = "user";
  static const String _table = "current";
  static const String _version = "0.0.1";

  ApiUserRepositoryCurrent(FlutterSecureStorage secureStorage)
      : super(
            table: _table,
            version: _version,
            toJson: (ApiUserModelCurrent model) => model.toJson(),
            fromJson: (Map<String, dynamic>? json) =>
                ApiUserModelCurrent.fromJson(json),
            secureStorage: secureStorage);
}
