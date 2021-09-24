/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../../utils/abstract_ss_repository.dart';
import '../model/api_user_model_otp.dart';

class ApiUserRepositoryOtp extends AbstractSsRepository<ApiUserModelOtp> {
  static const String _table = "otp";
  static const String _version = "0.0.1";
  static const String reqKey = "req";

  ApiUserRepositoryOtp(FlutterSecureStorage secureStorage)
      : super(
            table: _table,
            version: _version,
            toJson: (ApiUserModelOtp model) => model.toJson(),
            fromJson: (Map<String, dynamic>? json) =>
                ApiUserModelOtp.fromJson(json),
            secureStorage: secureStorage);
}
