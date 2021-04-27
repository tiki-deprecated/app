/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'dart:convert';

import 'package:app/src/config/config_domain.dart';
import 'package:app/src/features/repo_api_bouncer_otp/repo_api_bouncer_otp_req.dart';
import 'package:app/src/features/repo_api_bouncer_otp/repo_api_bouncer_otp_rsp.dart';
import 'package:app/src/utils/helper/helper_api_rsp.dart';
import 'package:app/src/utils/helper/helper_headers.dart';
import 'package:http/http.dart' as http;

class RepoApiBouncerOtp {
  static const String _path = '/api/latest/otp/email';

  Future<HelperApiRsp<RepoApiBouncerOtpRsp>> email(
      RepoApiBouncerOtpReq req) async {
    http.Response rsp = await http.post(
        ConfigDomain.asUri(ConfigDomain.bouncer, _path),
        headers: HelperHeaders().header,
        body: jsonEncode(req.toJson()));

    Map rspMap = jsonDecode(rsp.body);
    return HelperApiRsp.fromJson(
        rspMap, (json) => RepoApiBouncerOtpRsp.fromJson(json));
  }
}
