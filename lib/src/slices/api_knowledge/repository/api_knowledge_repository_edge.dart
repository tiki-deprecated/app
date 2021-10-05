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
import '../model/edge/api_knowledge_model_edge.dart';

class ApiKnowledgeRepositoryEdge {
  static final String _path = '/api/latest/edge';

  static Future<HelperApiRsp<ApiKnowledgeModelEdge>> post(
      String? bearer, ApiKnowledgeModelEdge edge) async {
    Response rsp = await ConfigSentry.http.post(
        ConfigDomain.asUri(ConfigDomain.knowledge, _path),
        headers: HelperApiHeaders(auth: bearer).header,
        body: jsonEncode(edge.toJson()));
    Map? rspMap = jsonDecode(rsp.body);
    return HelperApiRsp.fromJson(
        rspMap as Map<String, dynamic>?,
        (json) =>
            ApiKnowledgeModelEdge.fromJson(json as Map<String, dynamic>?));
  }
}
