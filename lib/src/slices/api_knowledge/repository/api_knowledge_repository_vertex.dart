/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'dart:convert';

import 'package:app/src/slices/api_knowledge/model/vertex/api_knowledge_model_vertex.dart';
import 'package:http/http.dart';

import '../../../config/config_domain.dart';
import '../../../config/config_sentry.dart';
import '../../../utils/api/helper_api_headers.dart';
import '../../../utils/api/helper_api_rsp.dart';

class ApiKnowledgeRepositoryVertex {
  static final String _path = '/api/latest/vertex';

  static Future<HelperApiRsp<ApiKnowledgeModelVertex>> get(
      String? bearer) async {
    Response rsp = await ConfigSentry.http.get(
        ConfigDomain.asUri(ConfigDomain.knowledge, _path),
        headers: HelperApiHeaders(auth: bearer).header);
    Map? rspMap = jsonDecode(rsp.body);
    return HelperApiRsp.fromJson(
        rspMap as Map<String, dynamic>?,
        (json) =>
            ApiKnowledgeModelVertex.fromJson(json as Map<String, dynamic>?));
  }
}
