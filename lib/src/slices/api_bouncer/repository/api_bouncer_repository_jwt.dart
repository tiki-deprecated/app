/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'dart:convert';

import 'package:app/src/config/config_domain.dart';
import 'package:app/src/config/config_sentry.dart';
import 'package:app/src/slices/api_bouncer/model/api_bouncer_model_jwt_req_otp.dart';
import 'package:app/src/slices/api_bouncer/model/api_bouncer_model_jwt_req_refresh.dart';
import 'package:app/src/slices/api_bouncer/model/api_bouncer_model_jwt_rsp.dart';
import 'package:app/src/utils/api/helper_api_headers.dart';
import 'package:app/src/utils/api/helper_api_rsp.dart';
import 'package:http/http.dart';

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
