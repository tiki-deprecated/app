/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'dart:convert';

import 'package:http/http.dart';
import 'package:httpp/httpp.dart';

import '../../../config/config_domain.dart';
import '../../../config/config_sentry.dart';
import '../../../utils/api/helper_api_rsp.dart';
import '../model/company/api_knowledge_model_company.dart';

class ApiKnowledgeRepositoryCompany {
  static final String _path = '/api/latest/vertex/company';

  static Future<HelperApiRsp<ApiKnowledgeModelCompany>> get(
      String? bearer, String domain) async {
    Response rsp = await ConfigSentry.http.get(
        ConfigDomain.asUri(ConfigDomain.knowledge, _path, {"domain": domain}),
        headers: HttppHeaders.typical(bearerToken: bearer).map);
    Map? rspMap = jsonDecode(rsp.body);
    return HelperApiRsp.fromJson(
        rspMap as Map<String, dynamic>?,
        (json) =>
            ApiKnowledgeModelCompany.fromJson(json as Map<String, dynamic>?));
  }
}
