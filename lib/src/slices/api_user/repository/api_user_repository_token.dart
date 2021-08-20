/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../../utils/abstract_ss_repository.dart';
import '../model/api_user_model_token.dart';

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
