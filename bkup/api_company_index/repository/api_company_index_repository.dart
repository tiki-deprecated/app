/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'dart:convert';

import 'package:app/src/config/config_domain.dart';
import 'package:app/src/config/config_sentry.dart';
import 'package:app/src/slices/api_company_index/model/api_company_index_model_rsp.dart';
import 'package:app/src/utils/api/helper_api_headers.dart';
import 'package:app/src/utils/api/helper_api_rsp.dart';
import 'package:http/http.dart';

class ApiCompanyIndexRepository {
  static final String _path = '/api/latest/company';

  static Future<HelperApiRsp<ApiCompanyIndexModelRsp>> find(
      String? bearer, String domain) async {
    Response rsp = await ConfigSentry.http.get(
        ConfigDomain.asUri(
            ConfigDomain.companyIndex, _path, {"domain": domain}),
        headers: HelperApiHeaders(auth: bearer).header);
    Map? rspMap = jsonDecode(rsp.body);
    return HelperApiRsp.fromJson(
        rspMap as Map<String, dynamic>?,
        (json) =>
            ApiCompanyIndexModelRsp.fromJson(json as Map<String, dynamic>?));
  }
}
