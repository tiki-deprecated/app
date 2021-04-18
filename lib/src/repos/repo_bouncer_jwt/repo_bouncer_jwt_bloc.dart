/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'dart:convert';

import 'package:app/src/configs/config_domains.dart' as Domains;
import 'package:app/src/repos/repo_bouncer_jwt/repo_bouncer_jwt_model_req_otp.dart';
import 'package:app/src/repos/repo_bouncer_jwt/repo_bouncer_jwt_model_req_refresh.dart';
import 'package:app/src/repos/repo_bouncer_jwt/repo_bouncer_jwt_model_rsp.dart';
import 'package:app/src/utilities/utility_api_rsp.dart';
import 'package:app/src/utilities/utility_functions.dart';
import 'package:http/http.dart' as http;

class RepoBouncerJwtBloc {
  static final String _path = '/api/latest/jwt';
  static final String _pathOtp = _path + '/otp';
  static final String _pathRefresh = _path + '/refresh';

  Future<UtilityAPIRsp<RepoBouncerJwtModelRsp>> otp(
      RepoBouncerJwtModelReqOtp req) async {
    http.Response rsp = await http.post(
        envAwareUri(Domains.of(Domains.bouncer), _pathOtp),
        headers: jsonHeaders(),
        body: jsonEncode(req.toJson()));
    Map rspMap = jsonDecode(rsp.body);
    return UtilityAPIRsp.fromJson(
        rspMap, (json) => RepoBouncerJwtModelRsp.fromJson(json));
  }

  Future<UtilityAPIRsp<RepoBouncerJwtModelRsp>> refresh(
      RepoBouncerJwtModelReqRefresh req) async {
    http.Response rsp = await http.post(
        envAwareUri(Domains.of(Domains.bouncer), _pathRefresh),
        headers: jsonHeaders(),
        body: jsonEncode(req.toJson()));
    Map rspMap = jsonDecode(rsp.body);
    return UtilityAPIRsp.fromJson(
        rspMap, (json) => RepoBouncerJwtModelRsp.fromJson(json));
  }
}
