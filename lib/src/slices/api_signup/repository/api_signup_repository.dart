/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'dart:convert';

import 'package:http/http.dart';
import 'package:httpp/httpp.dart';

import '../../../config/config_domain.dart';
import '../../../config/config_sentry.dart';
import '../../../utils/api/tiki_api_model_rsp.dart';
import '../model/api_signup_model_user_rsp.dart';

class ApiSignupRepository {
  static const String _path = '/api/0-1-0/user';

  static Future<TikiApiModelRsp<ApiSignupModelUserRsp>> total(
      {String? code}) async {
    var query;
    if (code != null) query = {"referrer": code};
    Response rsp = await ConfigSentry.http.get(
        ConfigDomain.asUri(ConfigDomain.signup, _path, query),
        headers: HttppHeaders.typical().map);
    Map? rspMap = jsonDecode(rsp.body);
    return TikiApiModelRsp(
        code: rsp.statusCode,
        data: ApiSignupModelUserRsp.fromJson(rspMap as Map<String, dynamic>?));
  }
}
