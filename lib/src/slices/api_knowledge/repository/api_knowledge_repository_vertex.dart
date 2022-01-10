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
import '../model/vertex/api_knowledge_model_vertex.dart';

class ApiKnowledgeRepositoryVertex {
  static final String _path = '/api/latest/vertex';

  static Future<HelperApiRsp<ApiKnowledgeModelVertex>> get(
      String? bearer) async {
    Response rsp = await ConfigSentry.http.get(
        ConfigDomain.asUri(ConfigDomain.knowledge, _path),
        headers: HttppHeaders.typical(bearerToken: bearer).map);
    Map? rspMap = jsonDecode(rsp.body);
    return HelperApiRsp.fromJson(
        rspMap as Map<String, dynamic>?,
        (json) =>
            ApiKnowledgeModelVertex.fromJson(json as Map<String, dynamic>?));
  }
}
