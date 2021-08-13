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
import '../model/api_company_model_index.dart';

class ApiCompanyRepositoryIndex {
  static final String _path = '/api/latest/company';

  static Future<HelperApiRsp<ApiCompanyModelIndex>> find(
      String? bearer, String domain) async {
    Response rsp = await ConfigSentry.http.get(
        ConfigDomain.asUri(
            ConfigDomain.companyIndex, _path, {"domain": domain}),
        headers: HelperApiHeaders(auth: bearer).header);
    Map? rspMap = jsonDecode(rsp.body);
    return HelperApiRsp.fromJson(rspMap as Map<String, dynamic>?,
        (json) => ApiCompanyModelIndex.fromJson(json as Map<String, dynamic>?));
  }
}
