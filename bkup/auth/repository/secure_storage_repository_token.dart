/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/slices/auth/model/auth_model_token.dart';
import 'package:app/src/slices/secure_storage/secure_storage_repository.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageRepositoryToken
    extends SecureStorageRepository<AuthModelToken> {
  static const String _table = "token";
  static const String _version = "0.0.1";

  SecureStorageRepositoryToken({FlutterSecureStorage? secureStorage})
      : super(_table, _version, (AuthModelToken model) => model.toJson(),
            (Map<String, dynamic>? json) => AuthModelToken.fromJson(json),
            secureStorage: secureStorage);
}
