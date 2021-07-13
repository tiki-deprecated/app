/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/slices/api_user/model/api_user_model_user.dart';
import 'package:app/src/utils/abstract_ss_repository.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ApiUserRepositoryUser extends AbstractSsRepository<ApiUserModelUser> {
  static const String _table = "user";
  static const String _version = "0.0.1";

  ApiUserRepositoryUser(FlutterSecureStorage secureStorage)
      : super(
            table: _table,
            version: _version,
            toJson: (ApiUserModelUser model) => model.toJson(),
            fromJson: (Map<String, dynamic>? json) =>
                ApiUserModelUser.fromJson(json),
            secureStorage: secureStorage);
}
