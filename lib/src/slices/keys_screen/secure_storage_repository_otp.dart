/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/repositories/secure_storage/secure_storage_repository.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../login_screen/model/login_screen_model_otp.dart';

class SecureStorageRepositoryOtp
    extends SecureStorageRepository<LoginScreenModelOtp> {
  static const String _table = "otp";
  static const String _version = "0.0.1";

  SecureStorageRepositoryOtp({FlutterSecureStorage? secureStorage})
      : super(_table, _version, (LoginScreenModelOtp model) => model.toJson(),
            (Map<String, dynamic>? json) => LoginScreenModelOtp.fromJson(json),
            secureStorage: secureStorage);
}
