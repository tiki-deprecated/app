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
import '../model/api_bouncer_model_otp_req.dart';
import '../model/api_bouncer_model_otp_rsp.dart';

class ApiBouncerRepositoryOtp {
  static const String _path = '/api/latest/otp/email';

  static Future<HelperApiRsp<ApiBouncerModelOtpRsp>> email(
      ApiBouncerModelOtpReq req) async {
    Response rsp = await ConfigSentry.http.post(
        ConfigDomain.asUri(ConfigDomain.bouncer, _path),
        headers: HelperApiHeaders().header,
        body: jsonEncode(req.toJson()));
    Map? rspMap = jsonDecode(rsp.body);
    return HelperApiRsp.fromJson(
        rspMap as Map<String, dynamic>?,
        (json) =>
            ApiBouncerModelOtpRsp.fromJson(json as Map<String, dynamic>?));
  }
}
