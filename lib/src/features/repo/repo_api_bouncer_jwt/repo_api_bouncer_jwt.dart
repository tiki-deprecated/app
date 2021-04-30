/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'dart:convert';

import 'package:app/src/config/config_domain.dart';
import 'package:app/src/utils/helper/helper_api_rsp.dart';
import 'package:app/src/utils/helper/helper_headers.dart';
import 'package:http/http.dart' as http;

import 'repo_api_bouncer_jwt_req_otp.dart';
import 'repo_api_bouncer_jwt_req_refresh.dart';
import 'repo_api_bouncer_jwt_rsp.dart';

class RepoApiBouncerJwt {
  static final String _path = '/api/latest/jwt';
  static final String _pathOtp = _path + '/otp';
  static final String _pathRefresh = _path + '/refresh';

  Future<HelperApiRsp<RepoApiBouncerJwtRsp>> otp(
      RepoApiBouncerJwtReqOtp req) async {
    http.Response rsp = await http.post(
        ConfigDomain.asUri(ConfigDomain.bouncer, _pathOtp),
        headers: HelperHeaders().header,
        body: jsonEncode(req.toJson()));
    Map rspMap = jsonDecode(rsp.body);
    return HelperApiRsp.fromJson(
        rspMap, (json) => RepoApiBouncerJwtRsp.fromJson(json));
  }

  Future<HelperApiRsp<RepoApiBouncerJwtRsp>> refresh(
      RepoApiBouncerJwtReqRefresh req) async {
    http.Response rsp = await http.post(
        ConfigDomain.asUri(ConfigDomain.bouncer, _pathRefresh),
        headers: HelperHeaders().header,
        body: jsonEncode(req.toJson()));
    Map rspMap = jsonDecode(rsp.body);
    return HelperApiRsp.fromJson(
        rspMap, (json) => RepoApiBouncerJwtRsp.fromJson(json));
  }
}
