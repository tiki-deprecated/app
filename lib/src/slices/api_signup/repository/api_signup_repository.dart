/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'dart:convert';

import 'package:app/src/config/config_domain.dart';
import 'package:app/src/config/config_sentry.dart';
import 'package:app/src/slices/api_signup/model/api_signup_model_user_rsp.dart';
import 'package:app/src/utils/api/helper_api_headers.dart';
import 'package:app/src/utils/api/helper_api_rsp.dart';
import 'package:http/http.dart';

class ApiSignupRepository {
  static const String _path = '/api/0-1-0/user';

  static Future<HelperApiRsp<ApiSignupModelUserRsp>> total(
      {String? code}) async {
    var query;
    if (code != null) query = {"referrer": code};
    Response rsp = await ConfigSentry.http.get(
        ConfigDomain.asUri(ConfigDomain.signup, _path, query),
        headers: HelperApiHeaders().header);
    Map? rspMap = jsonDecode(rsp.body);
    return HelperApiRsp(
        code: rsp.statusCode,
        data: ApiSignupModelUserRsp.fromJson(rspMap as Map<String, dynamic>?));
  }
}
