/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/repositories/secure_storage/secure_storage_repository.dart';
import 'package:app/src/slices/app/model/app_model_user.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageRepositoryUser extends SecureStorageRepository<AppModelUser> {
  static const String _table = "user";
  static const String _version = "0.0.1";

  SecureStorageRepositoryUser({FlutterSecureStorage? secureStorage})
      : super(_table, _version, (AppModelUser model) => model.toJson(),
            (Map<String, dynamic>? json) => AppModelUser.fromJson(json),
            secureStorage: secureStorage);
}
