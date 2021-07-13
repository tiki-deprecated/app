/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'dart:convert';

import 'package:app/src/config/config_domain.dart';
import 'package:app/src/slices/api/helpers/helper_api_rsp.dart';
import 'package:http/http.dart' as http;

import '../../api/helpers/helper_api_headers.dart';
import '../model/auth_bouncer_otp_req.dart';
import '../model/auth_bouncer_otp_rsp.dart';

class AuthBouncerOtp {
  static const String _path = '/api/latest/otp/email';

  static Future<HelperApiRsp<AuthModelOtpRsp>> email(
      AuthModelOtpReq req) async {
    http.Response rsp = await http.post(
        ConfigDomain.asUri(ConfigDomain.bouncer, _path),
        headers: HelperHeaders().header,
        body: jsonEncode(req.toJson()));

    Map? rspMap = jsonDecode(rsp.body);
    return HelperApiRsp.fromJson(rspMap as Map<String, dynamic>?,
        (json) => AuthModelOtpRsp.fromJson(json as Map<String, dynamic>?));
  }
}
