/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'dart:convert';

import 'package:app/src/config/config_domain.dart';
import 'package:app/src/slices/api/helpers/helper_api_rsp.dart';
import 'package:http/http.dart' as http;

import '../../api/helpers/helper_headers.dart';
import '../model/auth_bouncer_jwt_req_otp.dart';
import '../model/auth_bouncer_jwt_req_refresh.dart';
import '../model/auth_bouncer_jwt_rsp.dart';

class AuthBouncerJwt {
  static final String _path = '/api/latest/jwt';
  static final String _pathOtp = _path + '/otp';
  static final String _pathRefresh = _path + '/refresh';

  static Future<HelperApiRsp<AuthBouncerJwtRsp>> otp(
      AuthModelJwtReqOtp req) async {
    http.Response rsp = await http.post(
        ConfigDomain.asUri(ConfigDomain.bouncer, _pathOtp),
        headers: HelperHeaders().header,
        body: jsonEncode(req.toJson()));
    Map? rspMap = jsonDecode(rsp.body);
    return HelperApiRsp.fromJson(rspMap as Map<String, dynamic>?,
        (json) => AuthBouncerJwtRsp.fromJson(json as Map<String, dynamic>?));
  }

  static Future<HelperApiRsp<AuthBouncerJwtRsp>> refresh(
      AuthModelJwtReqRefresh req) async {
    http.Response rsp = await http.post(
        ConfigDomain.asUri(ConfigDomain.bouncer, _pathRefresh),
        headers: HelperHeaders().header,
        body: jsonEncode(req.toJson()));
    Map? rspMap = jsonDecode(rsp.body);
    return HelperApiRsp.fromJson(rspMap as Map<String, dynamic>?,
        (json) => AuthBouncerJwtRsp.fromJson(json as Map<String, dynamic>?));
  }
}
