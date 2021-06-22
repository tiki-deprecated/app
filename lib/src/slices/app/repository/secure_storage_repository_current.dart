/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/repositories/secure_storage/secure_storage_repository.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../model/app_model_current.dart';

class SecureStorageRepositoryCurrent extends SecureStorageRepository<AppModelCurrent> {
  static const String key = "user";
  static const String _table = "current";
  static const String _version = "0.0.1";

  SecureStorageRepositoryCurrent({FlutterSecureStorage? secureStorage})
      : super(
            _table,
            _version,
            (AppModelCurrent model) => model.toJson(),
            (Map<String, dynamic>? json) =>
                AppModelCurrent.fromJson(json),
            secureStorage: secureStorage);
}
