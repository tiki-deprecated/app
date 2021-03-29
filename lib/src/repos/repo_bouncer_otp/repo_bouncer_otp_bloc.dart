/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'dart:convert';

import 'package:app/src/constants/constant_domains.dart';
import 'package:app/src/repos/repo_bouncer_otp/repo_bouncer_otp_model_req.dart';
import 'package:app/src/repos/repo_bouncer_otp/repo_bouncer_otp_model_rsp.dart';
import 'package:app/src/utilities/utility_api_rsp.dart';
import 'package:app/src/utilities/utility_functions.dart';
import 'package:http/http.dart' as http;

class RepoBouncerOtpBloc {
  static final String _path = '/api/latest/otp/email';

  Future<UtilityAPIRsp<RepoBouncerOtpModelRsp>> email(
      RepoBouncerOtpModelReq req) async {
    http.Response rsp = await http.post(
        Uri.https(ConstantDomains.bouncer, _path),
        headers: jsonHeaders(),
        body: jsonEncode(req.toJson()));
    Map rspMap = jsonDecode(rsp.body);
    return UtilityAPIRsp.fromJson(
        rspMap, (json) => RepoBouncerOtpModelRsp.fromJson(json));
  }
}
