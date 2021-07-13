/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'dart:convert';

import 'package:app/src/config/config_domain.dart';
import 'package:app/src/config/config_sentry.dart';
import 'package:app/src/slices/api_bouncer/model/api_bouncer_model_otp_req.dart';
import 'package:app/src/slices/api_bouncer/model/api_bouncer_model_otp_rsp.dart';
import 'package:app/src/utils/api/helper_api_headers.dart';
import 'package:app/src/utils/api/helper_api_rsp.dart';
import 'package:http/http.dart';

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
