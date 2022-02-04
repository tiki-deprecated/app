/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

class ApiKnowledgeRepositoryFingerprint {
  /*static final String _path = '/api/latest/fingerprint';

  static Future<HelperApiRsp<ApiKnowledgeModelFingerprintRsp>> post(
      String? bearer, ApiKnowledgeModelFingerprintReq req) async {
    Response rsp = await ConfigSentry.http.post(
        ConfigDomain.asUri(ConfigDomain.knowledge, _path),
        headers: HttppHeaders.typical(bearerToken: bearer).map,
        body: jsonEncode(req.toJson()));
    Map? rspMap = jsonDecode(rsp.body);
    return HelperApiRsp.fromJson(
        rspMap as Map<String, dynamic>?,
        (json) => ApiKnowledgeModelFingerprintRsp.fromJson(
            json as Map<String, dynamic>?));
  }*/
}
