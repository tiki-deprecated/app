/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'dart:convert';

import 'package:app/src/configs/config_domains.dart';
import 'package:app/src/repos/repo_bouncer_jwt/repo_bouncer_jwt_model_req.dart';
import 'package:app/src/repos/repo_bouncer_jwt/repo_bouncer_jwt_model_rsp.dart';
import 'package:app/src/utilities/utility_api_rsp.dart';
import 'package:app/src/utilities/utility_functions.dart';
import 'package:http/http.dart' as http;

class RepoBouncerJwtBloc {
  static final String _path = '/api/latest/jwt/otp';

  Future<UtilityAPIRsp<RepoBouncerJwtModelRsp>> otp(
      RepoBouncerJwtModelReq req) async {
    http.Response rsp = await http.post(Uri.https(ConfigDomains.bouncer, _path),
        headers: jsonHeaders(), body: jsonEncode(req.toJson()));
    Map rspMap = jsonDecode(rsp.body);
    return UtilityAPIRsp.fromJson(
        rspMap, (json) => RepoBouncerJwtModelRsp.fromJson(json));
  }
}
