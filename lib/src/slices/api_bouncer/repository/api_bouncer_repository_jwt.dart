/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'dart:convert';

import 'package:http/http.dart';

import '../../../config/config_domain.dart';
import '../../../config/config_sentry.dart';
import '../../../utils/api/helper_api_headers.dart';
import '../../../utils/api/helper_api_rsp.dart';
import '../model/api_bouncer_model_jwt_req_otp.dart';
import '../model/api_bouncer_model_jwt_req_refresh.dart';
import '../model/api_bouncer_model_jwt_rsp.dart';

class ApiBouncerRepositoryJwt {
  static final String _path = '/api/latest/jwt';
  static final String _pathOtp = _path + '/otp';
  static final String _pathRefresh = _path + '/refresh';

  static Future<HelperApiRsp<ApiBouncerModelJwtRsp>> otp(
      ApiBouncerModelJwtReqOtp req) async {
    Response rsp = await ConfigSentry.http.post(
        ConfigDomain.asUri(ConfigDomain.bouncer, _pathOtp),
        headers: HelperApiHeaders().header,
        body: jsonEncode(req.toJson()));
    Map? rspMap = jsonDecode(rsp.body);
    return HelperApiRsp.fromJson(
        rspMap as Map<String, dynamic>?,
        (json) =>
            ApiBouncerModelJwtRsp.fromJson(json as Map<String, dynamic>?));
  }

  static Future<HelperApiRsp<ApiBouncerModelJwtRsp>> refresh(
      ApiBouncerModelJwtReqRefresh req) async {
    Response rsp = await ConfigSentry.http.post(
        ConfigDomain.asUri(ConfigDomain.bouncer, _pathRefresh),
        headers: HelperApiHeaders().header,
        body: jsonEncode(req.toJson()));
    Map? rspMap = jsonDecode(rsp.body);
    return HelperApiRsp.fromJson(
        rspMap as Map<String, dynamic>?,
        (json) =>
            ApiBouncerModelJwtRsp.fromJson(json as Map<String, dynamic>?));
  }
}
