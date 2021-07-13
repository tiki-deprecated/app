/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/slices/secure_storage/abstract_ss_repository.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../model/auth_model_otp.dart';

class SecureStorageRepositoryOtp extends SecureStorageRepository<AuthModelOtp> {
  static const String _table = "otp";
  static const String _version = "0.0.1";
  static const String reqKey = "req";

  SecureStorageRepositoryOtp({FlutterSecureStorage? secureStorage})
      : super(_table, _version, (AuthModelOtp model) => model.toJson(),
            (Map<String, dynamic>? json) => AuthModelOtp.fromJson(json),
            secureStorage: secureStorage);
}
