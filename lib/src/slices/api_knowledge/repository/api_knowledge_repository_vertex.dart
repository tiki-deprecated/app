/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

class ApiKnowledgeRepositoryVertex {
  /*static final String _path = '/api/latest/vertex';

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
  }*/
}
