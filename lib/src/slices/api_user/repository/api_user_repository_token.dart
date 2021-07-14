/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/slices/api_user/model/api_user_model_token.dart';
import 'package:app/src/utils/abstract_ss_repository.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ApiUserRepositoryToken extends AbstractSsRepository<ApiUserModelToken> {
  static const String _table = "token";
  static const String _version = "0.0.1";

  ApiUserRepositoryToken(FlutterSecureStorage secureStorage)
      : super(
            table: _table,
            version: _version,
            toJson: (ApiUserModelToken model) => model.toJson(),
            fromJson: (Map<String, dynamic>? json) =>
                ApiUserModelToken.fromJson(json),
            secureStorage: secureStorage);
}
