/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/slices/login_screen/model/login_screen_model_token.dart';
import 'package:app/src/slices/secure_storage/secure_storage_repository.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageRepositoryToken
    extends SecureStorageRepository<LoginScreenModelToken> {
  static const String _table = "token";
  static const String _version = "0.0.1";

  SecureStorageRepositoryToken({FlutterSecureStorage? secureStorage})
      : super(
            _table,
            _version,
            (LoginScreenModelToken model) => model.toJson(),
            (Map<String, dynamic>? json) =>
                LoginScreenModelToken.fromJson(json),
            secureStorage: secureStorage);
}
