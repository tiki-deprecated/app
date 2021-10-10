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
import '../../../utils/helper_json.dart';
import '../model/edge/api_knowledge_model_edge.dart';

class ApiKnowledgeRepositoryEdge {
  static final String _path = '/api/latest/edge';

  static Future<HelperApiRsp> post(
      String? bearer, List<ApiKnowledgeModelEdge> edges) async {
    Response rsp = await ConfigSentry.http.post(
        ConfigDomain.asUri(ConfigDomain.knowledge, _path),
        headers: HelperApiHeaders(auth: bearer).header,
        body: jsonEncode(HelperJson.listToJson(edges)));
    Map? rspMap = jsonDecode(rsp.body);
    return HelperApiRsp.fromJson(rspMap as Map<String, dynamic>?, (json) => {});
  }
}
