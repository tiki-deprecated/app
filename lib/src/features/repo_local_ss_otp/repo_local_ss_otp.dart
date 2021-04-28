/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/utils/helper/helper_repo_local_ss_crud.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'repo_local_ss_otp_model.dart';

class RepoLocalSsOtp extends HelperRepoLocalSsCrud<RepoLocalSsOtpModel> {
  static const String _table = "otp";
  static const String _version = "0.0.1";

  RepoLocalSsOtp({FlutterSecureStorage secureStorage})
      : super(_table, _version, (RepoLocalSsOtpModel model) => model.toJson(),
            (Map<String, dynamic> json) => RepoLocalSsOtpModel.fromJson(json),
            secureStorage: secureStorage);
}
